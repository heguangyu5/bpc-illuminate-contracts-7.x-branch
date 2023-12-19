libilluminate-contracts.so:
	./bpc-prepare.sh src.list
	$(MAKE) -C ./Illuminate libilluminate-contracts

libilluminate-contracts:
	bpc -v \
		-c bpc.conf  \
		-l illuminate-contracts \
		-u psr-container \
		--input-file src.list

install-libilluminate-contracts:
	cd Illuminate && bpc -l illuminate-contracts --install
