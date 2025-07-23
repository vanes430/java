package main

import (
    "fmt"
    "os"
    "os/exec"
    "runtime"
    "strings"
    "syscall"
    "regexp"
)

var (
    Red    = "\033[31m"
    White  = "\033[37m"
    Purple = "\033[35m"
    Yellow = "\033[33m"
    Bold   = "\033[1m"
    Reset  = "\033[0m"
)

func setInternalIPFromServerIP() {
    serverIP := os.Getenv("SERVER_IP")
    os.Setenv("INTERNAL_IP", serverIP)
}

func getCPU() string {
    out, err := exec.Command("sh", "-c", "awk -F: '/model name/ {print $2; exit}' /proc/cpuinfo").Output()
    if err != nil {
        return "Unknown"
    }
    return strings.TrimSpace(string(out))
}

func getCore() string {
    return fmt.Sprintf("%d", runtime.NumCPU())
}

func getRAM() string {
    out, err := exec.Command("sh", "-c", "awk '/MemTotal/ {print $2}' /proc/meminfo").Output()
    if err != nil {
        return "Unknown"
    }
    memKB := strings.TrimSpace(string(out))
    var mem int
    fmt.Sscanf(memKB, "%d", &mem)
    return fmt.Sprintf("%d MB", mem/1024)
}

func getDisk() string {
    var stat syscall.Statfs_t
    wd, _ := os.Getwd()
    err := syscall.Statfs(wd, &stat)
    if err != nil {
        return "Unknown"
    }
    total := stat.Blocks * uint64(stat.Bsize)
    return fmt.Sprintf("%d GB", total/(1024*1024*1024))
}

func getOS() string {
    osRelease, _ := exec.Command("sh", "-c", `awk -F= '/^PRETTY_NAME/ {gsub(/"/, "", $2); print $2}' /etc/os-release`).Output()
    osName := strings.TrimSpace(string(osRelease))
    if osName == "" {
        osName = runtime.GOOS
    }
    arch := runtime.GOARCH
    return fmt.Sprintf("%s (%s)", osName, arch)
}

func printInfo(labelColor, eqColor, resultColor, label, result string) {
    fmt.Printf("%s%s%s %s%s%s %s%s%s\n",
        labelColor, label, Reset,
        eqColor, "=", Reset,
        resultColor, result, Reset)
}

func getImagePrompt() string {
    prompt := os.Getenv("IMAGE_PROMPT")
    if prompt == "" {
        prompt = Bold + Yellow + "container@pterodactyl~ " + Reset
    }
    return prompt
}

func parseStartupCommand(startup string) string {
    replaced := regexp.MustCompile(`\{\{(\w+)\}\}`).ReplaceAllString(startup, `${$1}`)
    cmd := exec.Command("sh", "-c", "eval echo \""+replaced+"\"")
    out, err := cmd.Output()
    if err != nil {
        return startup
    }
    return strings.TrimSpace(string(out))
}

// Print one line of 8 color blocks, start from code (e.g. 40 for dark, 100 for bright)
func printColorBlocks(start int) {
    for i := 0; i < 8; i++ {
        fmt.Printf("\033[%dm   \033[0m", start+i)
    }
    fmt.Println()
}

func main() {
    setInternalIPFromServerIP()

	prompt := getImagePrompt()
    fmt.Printf("%ssystemfetch%s\n", prompt, Reset)
    printInfo(Red, White, Purple, "cpu      ", getCPU())
    printInfo(Red, White, Purple, "core     ", getCore())
    printInfo(Red, White, Purple, "ram      ", getRAM())
    printInfo(Red, White, Purple, "disk     ", getDisk())
    printInfo(Red, White, Purple, "os       ", getOS())
    printColorBlocks(40)
    printColorBlocks(100)
    fmt.Println()

    fmt.Printf("%sjava -version\n", prompt)
    cmd := exec.Command("java", "-version")
    cmd.Stdout = os.Stdout
    cmd.Stderr = os.Stderr
    _ = cmd.Run()
    fmt.Println()

    startup := os.Getenv("STARTUP")
    parsed := parseStartupCommand(startup)
    fmt.Printf("%s%s\n", prompt, parsed)

    args := []string{"-c", parsed}
    execCmd := exec.Command("sh", args...)
    execCmd.Stdin = os.Stdin
    execCmd.Stdout = os.Stdout
    execCmd.Stderr = os.Stderr
    execCmd.Env = os.Environ()
    if err := execCmd.Run(); err != nil {
        fmt.Fprintf(os.Stderr, "Failed to execute command: %v\n", err)
        os.Exit(1)
    }
}
