import sys
import os

def createpal(argv):
    assert len(argv)>2
    f = open(argv[1],"br")
    fo = open(argv[2],"bw")
    fsize = os.path.getsize(argv[1])
    print(fsize/3)
    for i in range(int(fsize/3)):
        r = int.from_bytes(f.read1(1), "little")
        g = int.from_bytes(f.read1(1), "little")
        b = int.from_bytes(f.read1(1), "little")

        r = r%32
        g = g%32
        b = b%32

        print("r= "+str(r))
        print("g= "+str(g))
        print("b= "+str(b))
        print("\n")

        rb = bin(r).replace("0b","")
        gb = bin(g).replace("0b","")
        bb = bin(b).replace("0b","")

        for j in range(5-len(rb)):
            rb= "0"+rb
        for j in range(5-len(gb)):
            gb+="0"
        for j in range(5-len(bb)):
            bb+="0"
        final = "0"
        final += rb
        final += gb
        final += bb
        
        fo.write(int(final,2).to_bytes(2, "big"))
        

    f.close()
    fo.close()
    return 0

if __name__ == "__main__":
    createpal(sys.argv)
