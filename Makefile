version = "n4.4.1"
srcPath = "tmp/$(version)/src"

generate-flags:
	go run internal/cmd/flags/main.go

ubuntu-deps:
	sudo apt update && sudo apt install -y \
  wget curl vim tmux \
  build-essential pkg-config \
  librtmp-dev libx264-dev libfreetype-dev libgnutls28-dev \
  libfdk-aac-dev libfontconfig-dev libmp3lame-dev yasm qpdf

install-ffmpeg: 
	rm -rf $(srcPath)
	mkdir -p $(srcPath)
	git clone https://github.com/FFmpeg/FFmpeg $(srcPath)
	cd $(srcPath) && git checkout $(version)
	cd $(srcPath) && ./configure  --enable-libfdk-aac --enable-nonfree --enable-libx264 --enable-libmp3lame --enable-gnutls --enable-librtmp  --enable-gpl --enable-fontconfig --enable-libfreetype  --prefix=.. $(configure)
	cd $(srcPath) && make -j$(nproc)
	cd $(srcPath) && make install
