clean:
	@cargo clean
	@rm -rf libs

build-macos:
	@rm -rf libs/libmodel2vec-macos.a

	$(info Building for macOS... This may take a while)
	@cargo build --release --target aarch64-apple-darwin
	@cargo build --release --target x86_64-apple-darwin

	@mkdir -p libs
	@cp target/aarch64-apple-darwin/release/libmodel2vec.a libs/libmodel2vec-macos.a
	@lipo -create -output libs/libmodel2vec-macos.a \
	  target/aarch64-apple-darwin/release/libmodel2vec.a \
	  target/x86_64-apple-darwin/release/libmodel2vec.a

build-ios:
	@rm -rf libs/libmodel2vec-ios.a
	@rm -rf libs/libmodel2vec-ios-sim.a

	$(info Building for iOS... This may take a while)
	@cargo build --release --target aarch64-apple-ios
	@cargo build --release --target aarch64-apple-ios-sim
	@cargo build --release --target x86_64-apple-ios

	@mkdir -p libs
	@cp target/aarch64-apple-ios/release/libmodel2vec.a libs/libmodel2vec-ios.a
	@lipo -create -output libs/libmodel2vec-ios-sim.a \
	  target/aarch64-apple-ios-sim/release/libmodel2vec.a \
	  target/x86_64-apple-ios/release/libmodel2vec.a

build-xcframework: build-macos build-ios
	@rm -rf libs/model2vec.xcframework
	@xcodebuild -create-xcframework \
	  -library libs/libmodel2vec-macos.a \
	  -headers ./include/ \
	  -library libs/libmodel2vec-ios-sim.a \
	  -headers ./include/ \
	  -library libs/libmodel2vec-ios.a \
	  -headers ./include/ \
	  -output libs/model2vec.xcframework
	$(info XCFramework created at libs/model2vec.xcframework)
	@zip -r libs/model2vec.xcframework.zip libs/model2vec.xcframework
	$(info Generating SHA256 checksum for libs/model2vec.xcframework.zip)
	@shasum -a 256 libs/model2vec.xcframework.zip > libs/model2vec.xcframework.zip.sha256