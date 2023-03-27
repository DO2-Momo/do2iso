build: 
	mkarchiso -v -w /tmp -o ./build ./

build-installer:
	cd ./airootfs/root/.yarp/ ; cargo build -r; cd ../../../
