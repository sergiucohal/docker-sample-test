TAG='testlab'
docker run -it --rm \
    -p 8009:8000 \
    -e PORT=8000 \
    $TAG:latest