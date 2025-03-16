import bech32

eth_address = input("Please enter a ETH address (0x...): ")
#eth_address = "0x4381dc2ab14285160c808659aee005d51255add7"
eth_address_bytes = bytes.fromhex(eth_address[2:])

bz = bech32.convertbits(eth_address_bytes, 8, 5)
bech32_address = bech32.bech32_encode("crc",bz)
print(bech32_address)
#crc1gwqac243g2z3vryqsev6acq965f9ttwhw9r7vk