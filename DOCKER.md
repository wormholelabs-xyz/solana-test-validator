# build the image and tag it appropriately

docker buildx build --platform linux/amd64,linux/arm64 --build-arg SOLANA_SHA=5a06890206cf9f00a5fbd253b8f417cc5c3a075c -f Dockerfile -t ghcr.io/wormholelabs-xyz/solana-test-validator:3.0.12 .

# push to ghcr

docker push ghcr.io/wormholelabs-xyz/solana-test-validator:3.0.12
