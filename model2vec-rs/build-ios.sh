export IPHONEOS_DEPLOYMENT_TARGET=18.5


cargo build --release --target aarch64-apple-ios
cargo build --release --target aarch64-apple-ios-sim
cargo build --release --target x86_64-apple-ios

rm -rf libs/libmodel2vec-ios.a
rm -rf libs/libmodel2vec-ios-sim.a

mkdir -p libs

cp target/aarch64-apple-ios/release/libmodel2vec.a libs/libmodel2vec-ios.a
lipo -create -output libs/libmodel2vec-ios-sim.a \
  target/aarch64-apple-ios-sim/release/libmodel2vec.a \
  target/x86_64-apple-ios/release/libmodel2vec.a

