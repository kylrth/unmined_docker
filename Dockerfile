FROM curlimages/curl as downloader

WORKDIR /home/curl_user

# we'll build the appropriate URL from the architecture name
ARG TARGETARCH
COPY arch.txt /home/curl_user

RUN UNMINEDARCH=$(grep $TARGETARCH arch.txt | cut -d' ' -f1) && \
    curl -s -S "https://unmined.net/download/unmined-cli-linux-$UNMINEDARCH-dev/" | \
	tar -xz
RUN mv unmined-cli* unmined-cli

FROM gcr.io/distroless/dotnet/core/aspnet:3.1
COPY --from=downloader --chown=1000 /home/curl_user/unmined-cli /unmined-cli
USER 1000
ENTRYPOINT ["/unmined-cli/unmined-cli"]
