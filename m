Return-Path: <edfuchs@uni-kassel.de>
Received: from hrz-ws41.hrz.uni-kassel.de (smtp.hrz.uni-kassel.de
	[141.51.12.231]) by ozlabs.org (Postfix) with ESMTP id 8D9A3DDD0B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Oct 2008 23:42:55 +1100 (EST)
Received: from [192.168.101.87] (rs-pc1.rs.eecs.uni-kassel.de [141.51.112.154])
	by hrz-ws41.hrz.uni-kassel.de (8.14.0/8.14.0) with ESMTP id
	m9TCKeJl000612
	for <linuxppc-embedded@ozlabs.org>; Wed, 29 Oct 2008 13:20:41 +0100
Message-ID: <490855F0.5020009@uni-kassel.de>
Date: Wed, 29 Oct 2008 13:24:16 +0100
From: Eduard Fuchs <edfuchs@uni-kassel.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Marvell MV64560 & MPC7448 Problem with init PCI device
Content-Type: multipart/mixed; boundary="------------030003010303030605040005"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030003010303030605040005
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Hi,


I'm porting Linux Kermel 2.6.27 for our custom board. Currenlly I have 
some troubles with the SATA (SIL3114) controller. The controller and 
hard disk are found, but when the driver try to read the partiton table, 
error messages (timeouts) appears (see attachment).

Can somebody please give me a tip, where the problem can possible be. 
Are there some resources in Internet, which describes init process of an 
PCI-Bridge resp. PCI-Device under Linux?

In attachment are the log-output from boot-process and the corresponding 
dts files.

Best regards

Eduard Fuchs


-- 

  Eduard Fuchs                            Telefon:    +49 (561) 804-6596
  Universität Kassel                          Fax:    +49 (561) 804-6588
  Wilhelmshöher Allee 73                   E-Mail: edfuchs@uni-kassel.de
  34121 Kassel                     WWW: http://www.rs.eecs.uni-kassel.de
  Raum 0335:0339          FG Rechnerarchitektur und Systemprogrammierung

--------------030003010303030605040005
Content-Type: text/plain;
 name="lm074.dts"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="lm074.dts"

LyogRGV2aWNlIFRyZWUgU291cmNlIGZvciBNb3Rvcm9sYSBQclBNQzI4MDAKICoKICogQXV0
aG9yOiBFZHVhcmQgRnVjaHMgPGVkZnVjaHNAdW5pLWthc3NlbC5jb20+CiAqCiAqLwoKL2R0
cy12MS87CgovIHsKCW1vZGVsID0gImxtMDc0IjsKCWNvbXBhdGlibGUgPSAibG0wNzQiOwoJ
I2FkZHJlc3MtY2VsbHMgPSA8MT47Cgkjc2l6ZS1jZWxscyA9IDwxPjsKCWNvaGVyZW5jeS1v
ZmY7CgoJY3B1cyB7CgkJI2FkZHJlc3MtY2VsbHMgPSA8MT47CgkJI3NpemUtY2VsbHMgPTww
PjsKCQkJCQoJCVBvd2VyUEMsNzQ0OEAwIHsKCQkJZGV2aWNlX3R5cGUgPSAiY3B1IjsKCQkJ
cmVnID0gPDB4MD47CgkJCWQtY2FjaGUtbGluZS1zaXplID0gPDMyPjsJLy8gMzIgYnl0ZXMK
CQkJaS1jYWNoZS1saW5lLXNpemUgPSA8MzI+OwkvLyAzMiBieXRlcwoJCQlkLWNhY2hlLXNp
emUgPSA8MHg4MDAwPjsJCS8vIEwxLCAzMksgYnl0ZXMKCQkJaS1jYWNoZS1zaXplID0gPDB4
ODAwMD47CQkvLyBMMSwgMzJLIGJ5dGVzCgkJCXRpbWViYXNlLWZyZXF1ZW5jeSA9IDwzMzAw
MDAwMD47CS8vIDMzIE1IeiwgZnJvbSB1Ym9vdAoJCQljbG9jay1mcmVxdWVuY3kgPSA8NjAw
MDAwMDAwPjsJCS8vIEZyb20gVS1Cb290CgkJCWJ1cy1mcmVxdWVuY3kgPSA8MTMzMDAwMDAw
PjsJCS8vIEZyb20gVS1Cb290CgkJfTsKCX07CgoJbWVtb3J5IHsKCQlkZXZpY2VfdHlwZSA9
ICJtZW1vcnkiOwoJCXJlZyA9IDwweDAgMHg0MDAwMDAwMD47CS8vIEREUjIgICA1MTJNIGF0
IDAKCX07CgoJc3lzdGVtLWNvbnRyb2xsZXJAZmJlMDAwMDAgeyAvKiBNYXJ2ZWxsIERpc2Nv
dmVyeSBtdjY0NTYwIChEaXNjb3ZlcnkgVikqLwoJCSNhZGRyZXNzLWNlbGxzID0gPDE+OwoJ
CSNzaXplLWNlbGxzID0gPDE+OwoJCW1vZGVsID0gIm12NjQ1NjAiOwkJCS8qIERlZmF1bHQg
Ki8KCQljb21wYXRpYmxlID0gIm1hcnZlbGwsbXY2NDM2MCIsICJzaW1wbGUtYnVzIjsKCQlj
bG9jay1mcmVxdWVuY3kgPSA8MTMzMzMzMzMzPjsKCQlyZWcgPSA8MHhmYmUwMDAwMCAweDEw
MDAwMD47CgkJdmlydHVhbC1yZWcgPSA8MHhmYmUwMDAwMD47CgkJcmFuZ2VzID0gPDB4ZjAw
MDAwMDAgMHhmMDAwMDAwMCAweDAwMjAwMDAwCS8qIFBDSSAwIEkvTyBTcGFjZSAqLwoJCQkg
IDB4YTAwMDAwMDAgMHhhMDAwMDAwMCAweDQwMDAwMDAwCS8qIFBDSSAwIE1FTSBTcGFjZSAq
LwoJCQkgIDB4ZjAyMDAwMDAgMHhmMDIwMDAwMCAweDAwMTAwMDAwCS8qIFBDSSAxIEkvTyBT
cGFjZSAqLwoJCQkgIDB4YzAwMDAwMDAgMHhjMDAwMDAwMCAweDA4MDAwMDAwCS8qIFBDSSAx
IE1FTSBTcGFjZSAqLwoJCQkgIDB4ZjgwMDAwMDAgMHhmODAwMDAwMCAweDA0MDAwMDAwCS8q
IFVzZXIgRkxBU0ggKi8KCQkJICAweGZmZTAwMDAwIDB4ZmZlMDAwMDAgMHgwMDIwMDAwMAkv
KiBCb290IEZsYXNoICovCgkJCSAgMHgwMDAwMDAwMCAweGZiZTAwMDAwIDB4MDAxMDAwMDA+
OwkvKiBCcmlkZ2UncyByZWdzICovCgoJCW1kaW9ANzIwMDAgewoJCQkjYWRkcmVzcy1jZWxs
cyA9IDwxPjsKCQkJI3NpemUtY2VsbHMgPSA8MD47CgkJCWNvbXBhdGlibGUgPSAibWFydmVs
bCxtdjY0MzYwLW1kaW8iOwoJCQlyZWcgPSA8MHg3MjAwMCA0PjsKCQkJUEhZMDogZXRoZXJu
ZXQtcGh5QDAgewoJCQkJZGV2aWNlX3R5cGUgPSAiZXRoZXJuZXQtcGh5IjsKCQkJCWludGVy
cnVwdHMgPSA8NzY+OwkvKiBHUFAgMTIgKi8KCQkJCWludGVycnVwdC1wYXJlbnQgPSA8JlBJ
Qz47CgkJCX07CgkJCVBIWTE6IGV0aGVybmV0LXBoeUAxIHsKCQkJCWRldmljZV90eXBlID0g
ImV0aGVybmV0LXBoeSI7CgkJCQlpbnRlcnJ1cHRzID0gPDc2PjsJLyogR1BQIDEyICovCgkJ
CQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZQSUM+OwoJCQl9OwoJCQlQSFkyOiBldGhlcm5ldC1w
aHlAMiB7CgkJCQlkZXZpY2VfdHlwZSA9ICJldGhlcm5ldC1waHkiOwoJCQkJaW50ZXJydXB0
cyA9IDw3Nj47CS8qIEdQUCAxMiAqLwoJCQkJaW50ZXJydXB0LXBhcmVudCA9IDwmUElDPjsK
CQkJfTsKCQl9OwoKCQlldGhlcm5ldC1ncm91cEA3MjAwMCB7CgkJCSNhZGRyZXNzLWNlbGxz
ID0gPDE+OwoJCQkjc2l6ZS1jZWxscyA9IDwwPjsKCQkJY29tcGF0aWJsZSA9ICJtYXJ2ZWxs
LG12NjQzNjAtZXRoLWdyb3VwIjsKCQkJcmVnID0gPDB4NzIwMDAgMHgyMDAwPjsKCQkJZXRo
ZXJuZXRAMCB7CgkJCQlkZXZpY2VfdHlwZSA9ICJuZXR3b3JrIjsKCQkJCWNvbXBhdGlibGUg
PSAibWFydmVsbCxtdjY0MzYwLWV0aCI7CgkJCQlyZWcgPSA8MD47CgkJCQlpbnRlcnJ1cHRz
ID0gPDMyPjsKCQkJCWludGVycnVwdC1wYXJlbnQgPSA8JlBJQz47CgkJCQlwaHkgPSA8JlBI
WTA+OwoJCQkJbG9jYWwtbWFjLWFkZHJlc3MgPSBbIDAwIDAwIDAwIDAwIDAwIDAwIF07CgkJ
CX07CgkJCWV0aGVybmV0QDEgewoJCQkJZGV2aWNlX3R5cGUgPSAibmV0d29yayI7CgkJCQlj
b21wYXRpYmxlID0gIm1hcnZlbGwsbXY2NDM2MC1ldGgiOwoJCQkJcmVnID0gPDE+OwoJCQkJ
aW50ZXJydXB0cyA9IDwzMz47CgkJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZQSUM+OwoJCQkJ
cGh5ID0gPCZQSFkxPjsKCQkJCWxvY2FsLW1hYy1hZGRyZXNzID0gWyAwMCAwMCAwMCAwMCAw
MCAwMCBdOwoJCQl9OwoJCQlldGhlcm5ldEAyIHsKCQkJCWRldmljZV90eXBlID0gIm5ldHdv
cmsiOwoJCQkJY29tcGF0aWJsZSA9ICJtYXJ2ZWxsLG12NjQzNjAtZXRoIjsKCQkJCXJlZyA9
IDwyPjsKCQkJCWludGVycnVwdHMgPSA8MzQ+OwoJCQkJaW50ZXJydXB0LXBhcmVudCA9IDwm
UElDPjsKCQkJCXBoeSA9IDwmUEhZMj47CgkJCQlsb2NhbC1tYWMtYWRkcmVzcyA9IFsgMDAg
MDAgMDAgMDAgMDAgMDAgXTsKCQkJfTsKCQl9OwoKCQltcHBAMTAwMDAgewoJCQljb21wYXRp
YmxlID0gIm1hcnZlbGwsbXY2NDM2MC1tcHAiOwoJCQlyZWcgPSA8MHgxMDAwMCAweDBDPjsK
CQl9OwoKCQlncHBAMTAxMDAgewoJCQljb21wYXRpYmxlID0gIm1hcnZlbGwsbXY2NDM2MC1n
cHAiOwoJCQlyZWcgPSA8MHgxMDEwMCAweEQwPjsKCQl9OwoKCQlQSUM6IHBpY0AyMDAwMCB7
CgkJCSNpbnRlcnJ1cHQtY2VsbHMgPSA8MT47CgkJCSNhZGRyZXNzLWNlbGxzID0gPDA+OwoJ
CQljb21wYXRpYmxlID0gIm1hcnZlbGwsbXY2NDM2MC1waWMiOwoJCQlyZWcgPSA8MHgyMDAw
MCAweDg4PjsKCQkJaW50ZXJydXB0LWNvbnRyb2xsZXI7CgkJfTsKCgkJc2VyaWFsQDEyMDAw
IHsKCQkJZGV2aWNlX3R5cGUgPSAic2VyaWFsIjsKCQkJY29tcGF0aWJsZSA9ICJuczE2NTUw
IjsKCQkJcmVnID0gPDB4MTIwMDAgMHgxMDA+OwoJCQljbG9jay1mcmVxdWVuY3kgPSA8MTMz
MzMzMzMzPjsJCS8qIEZpbGxlZCBpbiBieSB6SW1hZ2UgKi8KCQkJY3VycmVudC1zcGVlZCA9
IDwxMTUyMDA+OwoJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZQSUM+OwoJCQlpbnRlcnJ1cHRz
ID0gPDQwPjsKCQl9OwoKCQlzZXJpYWxAMTIxMDAgewoJCQlkZXZpY2VfdHlwZSA9ICJzZXJp
YWwiOwoJCQljb21wYXRpYmxlID0gIm5zMTY1NTAiOwoJCQlyZWcgPSA8MHgxMjEwMCAweDEw
MD47CgkJCWNsb2NrLWZyZXF1ZW5jeSA9IDwwPjsKCQkJY3VycmVudC1zcGVlZCA9IDwwPjsK
CQkJaW50ZXJydXB0LXBhcmVudCA9IDwmUElDPjsKCQkJaW50ZXJydXB0cyA9IDw0MT47CgkJ
fTsKCgkJUENJMDogcGNpQGEwMDAwMDAwIHsKCQkJI2FkZHJlc3MtY2VsbHMgPSA8Mz47CgkJ
CSNzaXplLWNlbGxzID0gPDI+OwoJCQkjaW50ZXJydXB0LWNlbGxzID0gPDE+OwoJCQlkZXZp
Y2VfdHlwZSA9ICJwY2kiOwoJCQljb21wYXRpYmxlID0gIm1hcnZlbGwsbXY2NDM2MC1wY2ki
OwoJCQlyZWcgPSA8MHgzMGM3OCAxMj47CgoJCQlyYW5nZXMgPSA8MHgwMTAwMDAwMCAweDAg
MHhmMDAwMDAwMCAweGYwMDAwMDAwIDB4MCAweDAwMjAwMDAwCgkJCQkgIDB4MDIwMDAwMDAg
MHgwIDB4YTAwMDAwMDAgMHhhMDAwMDAwMCAweDAgMHgyMDAwMDAwMD47CgoJCQlidXMtcmFu
Z2UgPSA8MCAyNTU+OwoJCQljbG9jay1mcmVxdWVuY3kgPSA8MzMwMDAwMDA+OwoJCQlpbnRl
cnJ1cHQtcGNpLWlhY2sgPSA8MHgzMGMzND47CgkJCWludGVycnVwdC1wYXJlbnQgPSA8JlBJ
Qz47CgoJCQlpbnRlcnJ1cHQtbWFwLW1hc2sgPSA8MHhmODAwIDB4MCAweDAgMHg3PjsKCQkJ
aW50ZXJydXB0LW1hcCA9IDwKCQkJCS8qIElEU0VMIDB4MDcgKi8KCQkJCTB4MzgwMCAwIDAg
MSAmUElDIDc0CgkJCQkweDM4MDAgMCAwIDIgJlBJQyA3NAoJCQkJMHgzODAwIDAgMCAzICZQ
SUMgNzQKCQkJCTB4MzgwMCAwIDAgNCAmUElDIDc0CgoJCQkJLyogSURTRUwgMHgwOCAqLwov
KgoJCQkJMHg0MDAwIDAgMCAxICZQSUMgNzQKCQkJCTB4NDAwMCAwIDAgMiAmUElDIDc0CgkJ
CQkweDQwMDAgMCAwIDMgJlBJQyA3NAoJCQkJMHg0MDAwIDAgMCA0ICZQSUMgNzQKKi8KCQkJ
CS8qIElEU0VMIDB4MDkgKi8KCQkJCTB4NDgwMCAwIDAgMSAmUElDIDY4CgkJCQkweDQ4MDAg
MCAwIDIgJlBJQyA2OAoJCQkJMHg0ODAwIDAgMCAzICZQSUMgNjgKCQkJCTB4NDgwMCAwIDAg
NCAmUElDIDY4CgoJCQkJLyogSURTRUwgMHgwQSAqLwoJCQkJMHg1MDAwIDAgMCAxICZQSUMg
NjkKCQkJCTB4NTAwMCAwIDAgMiAmUElDIDY5CgkJCQkweDUwMDAgMCAwIDMgJlBJQyA2OQoJ
CQkJMHg1MDAwIDAgMCA0ICZQSUMgNjkKCQkJPjsKCQl9OwovKgoJCVBDSTE6IHBjaUBjMDAw
MDAwMCB7CgkJCSNhZGRyZXNzLWNlbGxzID0gPDM+OwoJCQkjc2l6ZS1jZWxscyA9IDwyPjsK
CQkJI2ludGVycnVwdC1jZWxscyA9IDwxPjsKCQkJZGV2aWNlX3R5cGUgPSAicGNpIjsKCQkJ
Y29tcGF0aWJsZSA9ICJtYXJ2ZWxsLG12NjQzNjAtcGNpIjsKCQkJcmVnID0gPDB4NDBjZjgg
MHg4PjsKCgkJCXJhbmdlcyA9IDwweDAxMDAwMDAwIDB4MCAweDAwMjAwMDAwIDB4ZjAyMDAw
MDAgMHgwIDB4MDAxMDAwMDAKCQkJCSAgMHgwMjAwMDAwMCAweDAgMHhjMDAwMDAwMCAweGMw
MDAwMDAwIDB4MCAweDA4MDAwMDAwPjsKCgkJCWJ1cy1yYW5nZSA9IDwwIDI1NT47CgkJCWNs
b2NrLWZyZXF1ZW5jeSA9IDwzMzAwMDAwMD47CgkJCWludGVycnVwdC1wY2ktaWFjayA9IDww
eDQwY2I0PjsKCQkJaW50ZXJydXB0LXBhcmVudCA9IDwmUElDPjsKCQkJaW50ZXJydXB0LW1h
cC1tYXNrID0gPDB4MDAwMCAweDAgMHgwIDB4Nz47CgkJfTsKKi8KCX07CgoJY2hvc2VuIHsK
CQlsaW51eCxzdGRvdXQtcGF0aCA9ICIvc3lzdGVtLWNvbnRyb2xsZXIvc2VyaWFsQDEyMDAw
IjsKCQlib290YXJncyA9ICJyb290PS9kZXYvc2RhIjsKCX07Cgp9Ow==
--------------030003010303030605040005
Content-Type: text/plain;
 name="boot.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="boot.txt"

Linux version 2.6.27-rc5-01244-g4dcd863-dirty (efu@ws-87) (gcc version 3.4.5) #103 Wed Oct 15 08:07:50 CEST 2008
console [udbg0] enabled
Found MV64x60 PCI host bridge at 0x00000000fbe30c78. Firmware bus number: 0->255
PCI host bridge /system-controller@fbe00000/pci@a0000000 (primary) ranges:
  IO 0x00000000f0000000..0x00000000f01fffff -> 0x00000000f0000000
 MEM 0x00000000a0000000..0x00000000bfffffff -> 0x00000000a0000000
Zone PFN ranges:
  DMA      0x00000000 -> 0x00030000
  Normal   0x00030000 -> 0x00030000
  HighMem  0x00030000 -> 0x00040000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00040000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260096
Kernel command line: root=/dev/sda
PID hash table entries: 4096 (order: 12, 16384 bytes)
clocksource: timebase mult[79364d9] shift[22] registered
Console: colour dummy device 80x25
console handover: boot [udbg0] -> real [tty0]
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1032528k/1048576k available (3496k kernel code, 15348k reserved, 140k data, 334k bss, 172k init)
SLUB: Genslabs=10, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Calibrating delay loop... 65.79 BogoMIPS (lpj=131584)
Security Framework initialized
Mount-cache hash table entries: 512
khelper used greatest stack depth: 7272 bytes left
net_namespace: 788 bytes
NET: Registered protocol family 16
PCI: Probing PCI hardware
PCI: Scanning bus 0000:00
PCI found [11ab/6450] class 000580 header type 00
VendorID 0x0000, SybSystemID 0x0000
pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot
pci 0000:00:00.0: PME# disabled
PCI found [11ab/6450] class 000580 header type 00
VendorID 0x0000, SybSystemID 0x0000
pci 0000:00:00.1: PME# supported from D0 D1 D2 D3hot
pci 0000:00:00.1: PME# disabled
PCI found [11ab/6450] class 000580 header type 00
VendorID 0x0000, SybSystemID 0x0000
pci 0000:00:00.2: PME# supported from D0 D1 D2 D3hot
pci 0000:00:00.2: PME# disabled
PCI found [11ab/6450] class 000580 header type 00
VendorID 0x0000, SybSystemID 0x0000
pci 0000:00:00.3: PME# supported from D0 D1 D2 D3hot
pci 0000:00:00.3: PME# disabled
PCI found [11ab/6450] class 000580 header type 00
VendorID 0x0000, SybSystemID 0x0000
pci 0000:00:00.4: PME# supported from D0 D1 D2 D3hot
pci 0000:00:00.4: PME# disabled
PCI found [11ab/6450] class 000580 header type 00
VendorID 0x0000, SybSystemID 0x0000
PCI found [11ab/6450] class 000580 header type 00
VendorID 0x0000, SybSystemID 0x0000
PCI found [11ab/6450] class 000580 header type 00
VendorID 0x0000, SybSystemID 0x0000
PCI found [1002/5960] class 000300 header type 00
VendorID 0x174b, SybSystemID 0x0250
PCI found [1002/5940] class 000380 header type 00
VendorID 0x174b, SybSystemID 0x0251
PCI found [1095/3114] class 000180 header type 00
VendorID 0x1095, SybSystemID 0x3114
PCI found [10cf/201e] class 000380 header type 00
VendorID 0x0000, SybSystemID 0x0000
PCI: Fixups for bus 0000:00
Try to map irq for 0000:00:00.0...
Try to map irq for 0000:00:00.1...
Try to map irq for 0000:00:00.2...
Try to map irq for 0000:00:00.3...
Try to map irq for 0000:00:00.4...
Try to map irq for 0000:00:00.5...
Try to map irq for 0000:00:00.6...
Try to map irq for 0000:00:00.7...
Try to map irq for 0000:00:08.0...
Try to map irq for 0000:00:08.1...
Try to map irq for 0000:00:09.0...
 -> got one, spec 1 cells (0x00000044 0xffffffff...) on /system-controller@fbe00000/pic@20000
 -> mapped to linux irq 68
Try to map irq for 0000:00:0a.0...
 -> got one, spec 1 cells (0x00000045 0xffffffff...) on /system-controller@fbe00000/pic@20000
 -> mapped to linux irq 69
PCI: Bus scan for 0000:00 returning with max=00
PCI: PHB (bus 0) bridge rsrc 0: 00000000f0000000-00000000f01fffff [0x100], parent c036eca8 (PCI IO)
PCI: PHB (bus 0) bridge rsrc 1: 00000000a0000000-00000000bfffffff [0x200], parent c036ec8c (PCI mem)
PCI: Allocating 0000:00:00.0: Resource 2: 0000000010000000..000000001fffffff [2120c]
PCI: Cannot allocate resource region 2 of device 0000:00:00.0, will remap
PCI: Allocating 0000:00:00.0: Resource 4: 00000000f1000000..00000000f10fffff [20204]
PCI: Cannot allocate resource region 4 of device 0000:00:00.0, will remap
PCI: Allocating 0000:00:00.1: Resource 0: 0000000020000000..000000002fffffff [2120c]
PCI: Cannot allocate resource region 0 of device 0000:00:00.1, will remap
PCI: Allocating 0000:00:00.1: Resource 2: 0000000030000000..000000003fffffff [2120c]
PCI: Cannot allocate resource region 2 of device 0000:00:00.1, will remap
PCI: Allocating 0000:00:00.1: Resource 4: 0000000042000000..000000004203ffff [2120c]
PCI: Cannot allocate resource region 4 of device 0000:00:00.1, will remap
PCI: Allocating 0000:00:00.2: Resource 0: 00000000e0000000..00000000e7ffffff [20204]
PCI: Cannot allocate resource region 0 of device 0000:00:00.2, will remap
PCI: Allocating 0000:00:00.2: Resource 2: 00000000e8000000..00000000efffffff [20204]
PCI: Cannot allocate resource region 2 of device 0000:00:00.2, will remap
PCI: Allocating 0000:00:00.2: Resource 4: 00000000f8000000..00000000fbffffff [20204]
PCI: Cannot allocate resource region 4 of device 0000:00:00.2, will remap
PCI: Allocating 0000:00:00.3: Resource 0: 00000000d8000000..00000000dfffffff [20204]
PCI: Cannot allocate resource region 0 of device 0000:00:00.3, will remap
PCI: Allocating 0000:00:00.3: Resource 2: 00000000ffe00000..00000000ffffffff [20204]
PCI: Cannot allocate resource region 2 of device 0000:00:00.3, will remap
PCI: Allocating 0000:00:00.3: Resource 4: 0000000040000000..0000000041ffffff [2120c]
PCI: Cannot allocate resource region 4 of device 0000:00:00.3, will remap
PCI: Allocating 0000:00:00.4: Resource 0: 0000000080000000..000000008fffffff [2120c]
PCI: Cannot allocate resource region 0 of device 0000:00:00.4, will remap
PCI: Allocating 0000:00:00.4: Resource 2: 0000000090000000..000000009fffffff [2120c]
PCI: Cannot allocate resource region 2 of device 0000:00:00.4, will remap
PCI: Allocating 0000:00:08.0: Resource 0: 00000000a0000000..00000000a7ffffff [21208]
PCI: Allocating 0000:00:08.0: Resource 1: 00000000f0000000..00000000f00000ff [20101]
PCI: Allocating 0000:00:08.0: Resource 2: 00000000a8000000..00000000a800ffff [20200]
PCI: Allocating 0000:00:08.1: Resource 0: 00000000b0000000..00000000b7ffffff [21208]
PCI: Allocating 0000:00:08.1: Resource 1: 00000000b8000000..00000000b800ffff [20200]
PCI: Allocating 0000:00:09.0: Resource 0: 00000000f0000100..00000000f0000107 [20101]
PCI: Allocating 0000:00:09.0: Resource 1: 00000000f0000108..00000000f000010b [20101]
PCI: Allocating 0000:00:09.0: Resource 2: 00000000f0000110..00000000f0000117 [20101]
PCI: Allocating 0000:00:09.0: Resource 3: 00000000f0000118..00000000f000011b [20101]
PCI: Allocating 0000:00:09.0: Resource 4: 00000000f0000120..00000000f000012f [20101]
PCI: Allocating 0000:00:09.0: Resource 5: 00000000b8010000..00000000b80103ff [20200]
PCI: Allocating 0000:00:0a.0: Resource 0: 00000000bc000000..00000000bfffffff [20200]
PCI: Assigning unassigned resouces...
pci 0000:00:00.0: BAR 0: can't allocate mem resource [0xc0000000-0xbfffffff]
pci 0000:00:00.0: BAR 2: can't allocate mem resource [0xc0000000-0xbfffffff]
pci 0000:00:00.1: BAR 0: can't allocate mem resource [0xc0000000-0xbfffffff]
pci 0000:00:00.1: BAR 2: can't allocate mem resource [0xc0000000-0xbfffffff]
pci 0000:00:00.4: BAR 0: can't allocate mem resource [0xc0000000-0xbfffffff]
pci 0000:00:00.4: BAR 2: can't allocate mem resource [0xc0000000-0xbfffffff]
pci 0000:00:00.0: BAR 6: can't allocate mem resource [0xc0000000-0xbfffffff]
pci 0000:00:00.2: BAR 0: can't allocate mem resource [0xc0000000-0xbfffffff]
pci 0000:00:00.2: BAR 2: can't allocate mem resource [0xc0000000-0xbfffffff]
pci 0000:00:00.3: BAR 0: can't allocate mem resource [0xc0000000-0xbfffffff]
bus: 00 index 0 io port: [f0000000f01fffff, c030000020027200]
bus: 00 index 1 mmio: [a0000000bfffffff, c030000000005280]
khelper used greatest stack depth: 7080 bytes left
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 8, 1310720 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
NET: Registered protocol family 1
audit: initializing netlink socket (disabled)
type=2000 audit(0.824:1): initialized
highmem bounce pool size: 64 pages
khelper used greatest stack depth: 6760 bytes left
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
JFFS2 version 2.2. (NAND) Â© 2001-2006 Red Hat, Inc.
msgmni has been set to 1506
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
quirk_cardbus_legacy+0x0/0x44
0xc02a5b70
quirk_cardbus_legacy+0x0/0x44
0xc02a5b70
quirk_cardbus_legacy+0x0/0x44
0xc02a5b70
quirk_cardbus_legacy+0x0/0x44
0xc02a5b70
quirk_cardbus_legacy+0x0/0x44
0xc02a5b70
quirk_cardbus_legacy+0x0/0x44
0xc02a5b70
quirk_cardbus_legacy+0x0/0x44
0xc02a5b70
quirk_cardbus_legacy+0x0/0x44
0xc02a5b70
quirk_cardbus_legacy+0x0/0x44
0xc02a5b70
quirk_cardbus_legacy+0x0/0x44
0xc02a5b70
quirk_cardbus_legacy+0x0/0x44
0xc02a5b70
quirk_cardbus_legacy+0x0/0x44
0xc02a5b70
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Serial: MPSC driver
brd: module loaded
MV-643xx 10/100/1000 ethernet driver version 1.3
net eth0: port 0 with MAC address 64:56:00:00:00:01
net eth0: scatter/gather enabled
net eth0: tx checksum offload
net eth0: napi enabled
net eth1: port 1 with MAC address 64:56:00:00:00:02
net eth1: scatter/gather enabled
net eth1: tx checksum offload
net eth1: napi enabled
net eth2: port 2 with MAC address 64:56:00:00:00:03
net eth2: scatter/gather enabled
net eth2: tx checksum offload
net eth2: napi enabled
Driver 'sd' needs updating - please use bus_type methods
sata_sil 0000:00:09.0: Applying R_ERR on DMA activate FIS errata fix
scsi0 : sata_sil
scsi1 : sata_sil
scsi2 : sata_sil
scsi3 : sata_sil
ata1: SATA max UDMA/100 mmio m1024@0xb8010000 tf 0xb8010080 irq 68
ata2: SATA max UDMA/100 mmio m1024@0xb8010000 tf 0xb80100c0 irq 68
ata3: SATA max UDMA/100 mmio m1024@0xb8010000 tf 0xb8010280 irq 68
ata4: SATA max UDMA/100 mmio m1024@0xb8010000 tf 0xb80102c0 irq 68
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
*<6>ata1.00: ATA-7: ST380815AS, 3.AAC, max UDMA/133
ata1.00: 156301488 sectors, multi 0: LBA48 NCQ (depth 0/32)
*<6>ata1.00: configured for UDMA/100
ata2: SATA link down (SStatus 0 SControl 310)
ata3: SATA link down (SStatus 0 SControl 310)
ata4: SATA link down (SStatus 0 SControl 310)
scsi 0:0:0:0: Direct-Access     ATA      ST380815AS       3.AA PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 156301488 512-byte hardware sectors (80026 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 156301488 512-byte hardware sectors (80026 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda:<3>ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x20 (host bus error)
ata1.00: status: { DRDY }
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1.00: revalidation failed (errno=-5)
ata1: hard resetting link
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
***<6>ata1.00: configured for UDMA/100
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x20 (host bus error)
ata1.00: status: { DRDY }
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1.00: revalidation failed (errno=-5)
ata1: hard resetting link
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
***<6>ata1.00: configured for UDMA/100
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x20 (host bus error)
ata1.00: status: { DRDY }
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1.00: revalidation failed (errno=-5)
ata1: hard resetting link
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
***<6>ata1.00: configured for UDMA/100
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x20 (host bus error)
ata1.00: status: { DRDY }
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1.00: revalidation failed (errno=-5)
ata1: hard resetting link
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
***<6>ata1.00: configured for UDMA/100
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x20 (host bus error)
ata1.00: status: { DRDY }
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1.00: revalidation failed (errno=-5)
ata1: hard resetting link
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
***<6>ata1.00: configured for UDMA/100
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x20 (host bus error)
ata1.00: status: { DRDY }
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1.00: revalidation failed (errno=-5)
ata1: hard resetting link
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
***<6>ata1.00: configured for UDMA/100
sd 0:0:0:0: [sda] Result: hostbyte=0x00 driverbyte=0x08
sd 0:0:0:0: [sda] Sense Key : 0xb [current] [descriptor]
Descriptor sense data with sense descriptors (in hex):
        72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
        00 00 00 00
sd 0:0:0:0: [sda] ASC=0x0 ASCQ=0x0
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
....

--------------030003010303030605040005--
