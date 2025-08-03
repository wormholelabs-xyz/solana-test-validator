# build the image and tag it appropriately

docker buildx build --platform linux/amd64,linux/arm64 --build-arg SOLANA_SHA=beacdfc51cd395091b849a59d74112f302b3fb32 -f Dockerfile -t ghcr.io/wormholelabs-xyz/solana-test-validator:3.0.0 .

# push to ghcr

docker push ghcr.io/wormholelabs-xyz/solana-test-validator:3.0.0
