docker build -f adoptium/21-rocky/Dockerfile -t ghcr.io/vanes430/java:adoptium_21-rocky .
docker build -f adoptium/17-rocky/Dockerfile -t ghcr.io/vanes430/java:adoptium_17-rocky .
docker build -f adoptium/21-debian/Dockerfile -t ghcr.io/vanes430/java:adoptium_21-debian .
docker build -f adoptium/17-debian/Dockerfile -t ghcr.io/vanes430/java:adoptium_17-debian .

docker build -f bellsoft/21-rocky/Dockerfile -t ghcr.io/vanes430/java:bellsoft_21-rocky .
docker build -f bellsoft/17-rocky/Dockerfile -t ghcr.io/vanes430/java:bellsoft_17-rocky .
docker build -f bellsoft/21-debian/Dockerfile -t ghcr.io/vanes430/java:bellsoft_21-debian .
docker build -f bellsoft/17-debian/Dockerfile -t ghcr.io/vanes430/java:bellsoft_17-debian .

docker build -f corretto/21-rocky/Dockerfile -t ghcr.io/vanes430/java:corretto_21-rocky .
docker build -f corretto/17-rocky/Dockerfile -t ghcr.io/vanes430/java:corretto_17-rocky .
docker build -f corretto/21-debian/Dockerfile -t ghcr.io/vanes430/java:corretto_21-debian .
docker build -f corretto/17-debian/Dockerfile -t ghcr.io/vanes430/java:corretto_17-debian .

docker build -f graalce/21-rocky/Dockerfile -t ghcr.io/vanes430/java:graalce_21-rocky .
docker build -f graalce/17-rocky/Dockerfile -t ghcr.io/vanes430/java:graalce_17-rocky .
docker build -f graalce/21-debian/Dockerfile -t ghcr.io/vanes430/java:graalce_21-debian .
docker build -f graalce/17-debian/Dockerfile -t ghcr.io/vanes430/java:graalce_17-debian .

docker build -f zulu/21-rocky/Dockerfile -t ghcr.io/vanes430/java:zulu_21-rocky .
docker build -f zulu/17-rocky/Dockerfile -t ghcr.io/vanes430/java:zulu_17-rocky .
docker build -f zulu/21-debian/Dockerfile -t ghcr.io/vanes430/java:zulu_21-debian .
docker build -f zulu/17-debian/Dockerfile -t ghcr.io/vanes430/java:zulu_17-debian .