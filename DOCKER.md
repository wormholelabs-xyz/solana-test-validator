# build the image and tag it appropriately

docker buildx build --platform linux/amd64,linux/arm64 --build-arg SOLANA_SHA=563f59594e64051b6dbf62ea2d2c282420a81534 -f Dockerfile -t ghcr.io/wormholelabs-xyz/solana-test-validator:3.1.3 .

# push to ghcr

docker push ghcr.io/wormholelabs-xyz/solana-test-validator:3.1.3
