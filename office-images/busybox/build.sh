riscv="riscv64"
image="busybox"
version="1.35.0"
repo="g-ubjg5602-docker.pkg.coding.net/iscas-system/base-images"

docker rmi $image:$version
docker pull --platform=linux/amd64 $image:$version
docker tag $image:$version $repo/$image:$version-amd64
docker rmi $image:$version
docker pull --platform=linux/arm64 $image:$version
docker tag $image:$version $repo/$image:$version-arm64
docker rmi $image:$version

docker rmi $riscv/$image:$version
docker pull --platform=linux/riscv64 $riscv/$image:$version
docker tag $riscv/$image:$version $repo/$image:$version-riscv64
docker rmi $riscv/$image:$version

docker push $repo/$image:$version-amd64
docker push $repo/$image:$version-arm64
docker push $repo/$image:$version-riscv64

docker manifest create \
$repo/$image:$version \
--amend $repo/$image:$version-amd64 \
--amend $repo/$image:$version-arm64 \
--amend $repo/$image:$version-riscv64


docker manifest annotate $repo/$image:$version $repo/$image:$version-amd64 --os linux --arch amd64
docker manifest annotate $repo/$image:$version $repo/$image:$version-arm64 --os linux --arch arm64
docker manifest annotate $repo/$image:$version $repo/$image:$version-riscv64 --os linux --arch riscv64

docker manifest push $repo/$image:$version
