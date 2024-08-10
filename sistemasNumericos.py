def toBinary(num: int):
    return bin(num).replace("0b","")

def toHexa(num: int):
    return hex(num).replace("0x","")

def binToDecimal(bin_num: str):
    return int(bin_num,2)

def hexaToDecimal(hex_num: str):
    return int(hex_num,16)

def binarySum(*bin_nums: str):
    return sum(map(binToDecimal, bin_nums))

def hexaSum(*hexa_nums: str):
    return sum(map(hexaToDecimal, hexa_nums))

nums = [0,1,2,3,4,5,6,7,8,9,10,100,1000]
bins = [toBinary(b) for b in nums]
hexas = [toHexa(h) for h in nums]
for n in nums:
    binario = toBinary(n) 
    print(f"binario = {binario} decimal => {int(binario,2)}") 

for n in hexas:
    print(f"Hexa {n} decimal {hexaToDecimal(n)}") 
print('Decimal',sum(nums))
print('Binario',binarySum(*bins))
print('Hexadecimal', hexaSum(*hexas))
