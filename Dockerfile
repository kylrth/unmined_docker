FROM curlimages/curl AS downloader

WORKDIR /home/curl_user

# we'll build the appropriate URL from the architecture name
ARG TARGETARCH
COPY arch.txt /home/curl_user

RUN UNMINEDARCH=$(grep $TARGETARCH arch.txt | cut -d' ' -f1) && \
    curl -s -S "https://unmined.net/download/unmined-cli-linux-$UNMINEDARCH-dev/" | \
	tar -xz
RUN mv unmined-cli* unmined-cli

FROM mcr.microsoft.com/dotnet/aspnet:10.0
COPY --from=downloader --chown=1000 /home/curl_user/unmined-cli /unmined-cli
USER 1000
ENTRYPOINT ["/unmined-cli/unmined-cli"]
