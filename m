Return-Path: <jonb@marel.is>
Received: from marel.marel.is (GW-NAT01-ISLNET.marel.is [213.213.131.1])
	by ozlabs.org (Postfix) with ESMTP id 2D84C2BF07
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Jan 2005 01:24:08 +1100 (EST)
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Message-ID: <OFE3F13085.168CF615-ON00256F80.003C6775-00256F80.004A9C3D@marel.is>
From: "=?iso-8859-1?Q?J=F3n_Benediktsson?=" <jonb@marel.is>
Date: Wed, 5 Jan 2005 13:34:44 +0000
Content-Type: text/html; charset="ISO-8859-1"
Subject: MPC5200 - problem with CF card
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


<br><font size=3D2 face=3D"sans-serif">Hi</font>
<br>
<br><font size=3D2 face=3D"sans-serif">I am working with a custom MPC5200 b=
oard
which uses the built-in ATA/IDE controller for a compact flash card.</font>
<br><font size=3D2 face=3D"sans-serif">The Linux kernel is Denx linux=5F2=
=5F4=5Fdevel.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">I have been using an old SanDisk 16MB
CF card which works fine. &nbsp;Here is the console output with this card
plugged in:</font>
<br>
<br><font size=3D2 face=3D"sans-serif">U-Boot 1.1.2 (Dec &nbsp;2 2004 - 16:=
01:06)</font>
<br>
<br><font size=3D2 face=3D"sans-serif">CPU: &nbsp; MPC5200 v1.2 at 396 MHz<=
/font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp;Bus 132 M=
Hz,
IPB 66 MHz, PCI 33 MHz</font>
<br><font size=3D2 face=3D"sans-serif">Board: Marel NS4</font>
<br><font size=3D2 face=3D"sans-serif">I2C: &nbsp; 85 kHz, ready</font>
<br><font size=3D2 face=3D"sans-serif">DRAM: &nbsp;128 MB</font>
<br><font size=3D2 face=3D"sans-serif">FLASH: 16 MB</font>
<br><font size=3D2 face=3D"sans-serif">In: &nbsp; &nbsp;serial</font>
<br><font size=3D2 face=3D"sans-serif">Out: &nbsp; serial</font>
<br><font size=3D2 face=3D"sans-serif">Err: &nbsp; serial</font>
<br><font size=3D2 face=3D"sans-serif">Net: &nbsp; FEC ETHERNET</font>
<br><font size=3D2 face=3D"sans-serif">IDE: &nbsp; Bus 0: OK </font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; Device 0: Model: SanDisk SDCF=
B-16
Firm: vde 1.10 Ser#: 24349220714</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp;
Type: Removable Hard Disk</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp;
Capacity: 15.3 MB =3D 0.0 GB (31360 x 512)</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Type &quot;run flash=5Fnfs&quot; to =
mount
root filesystem over NFS</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Hit any key to stop autoboot: &nbsp;0
</font>
<br><font size=3D2 face=3D"sans-serif">Using FEC ETHERNET device</font>
<br><font size=3D2 face=3D"sans-serif">TFTP from server 10.100.1.30; our IP
address is 10.100.50.68</font>
<br><font size=3D2 face=3D"sans-serif">Filename 'mpc5200/uImage'.</font>
<br><font size=3D2 face=3D"sans-serif">Load address: 0x200000</font>
<br><font size=3D2 face=3D"sans-serif">Loading: ###########################=
######################################</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;##=
###############################################################</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;##=
###########################</font>
<br><font size=3D2 face=3D"sans-serif">done</font>
<br><font size=3D2 face=3D"sans-serif">Bytes transferred =3D 810417 (c5db1 =
hex)</font>
<br><font size=3D2 face=3D"sans-serif">## Booting image at 00200000 ...</fo=
nt>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp;Image Name: &nbsp; Linu=
x-2.4.25</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp;Created: &nbsp; &nbsp;
&nbsp;2004-12-03 &nbsp;11:35:18 UTC</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp;Image Type: &nbsp; Powe=
rPC
Linux Kernel Image (gzip compressed)</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp;Data Size: &nbsp; &nbsp=
;810353
Bytes =3D 791.4 kB</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp;Load Address: 00000000<=
/font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp;Entry Point: &nbsp;0000=
0000</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp;Verifying Checksum ...
OK</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp;Uncompressing Kernel Im=
age
... OK</font>
<br><font size=3D2 face=3D"sans-serif">Memory BAT mapping: BAT2=3D128Mb, BA=
T3=3D0Mb,
residual: 0Mb</font>
<br><font size=3D2 face=3D"sans-serif">Linux version 2.4.25 (jonb@tux.marel=
.is)
(gcc version 3.2.2 20030217 (Yellow Dog</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Linux 3.0 3.2.2-2a=5F1)) #4 F=
=F6s
Des 3 11:34:35 UTC 2004</font>
<br><font size=3D2 face=3D"sans-serif">On node 0 totalpages: 32768</font>
<br><font size=3D2 face=3D"sans-serif">zone(0): 32768 pages.</font>
<br><font size=3D2 face=3D"sans-serif">zone(1): 0 pages.</font>
<br><font size=3D2 face=3D"sans-serif">zone(2): 0 pages.</font>
<br><font size=3D2 face=3D"sans-serif">Kernel command line: root=3D/dev/nfs=
 rw
nfsroot=3D10.100.1.30:/opt/eldk/ppc=5F82xx ip=3D</font>
<br><font size=3D2 face=3D"sans-serif">10.100.50.68:10.100.1.30:10.100.254.=
254:255.255.0.0:ns4b:eth0:off
panic=3D1</font>
<br><font size=3D2 face=3D"sans-serif">Calibrating delay loop... 263.78 Bog=
oMIPS</font>
<br><font size=3D2 face=3D"sans-serif">Memory: 127080k available (1396k ker=
nel
code, 464k data, 76k init, 0k highmem)</font>
<br><font size=3D2 face=3D"sans-serif">Dentry cache hash table entries: 163=
84
(order: 5, 131072 bytes)</font>
<br><font size=3D2 face=3D"sans-serif">Inode cache hash table entries: 8192
(order: 4, 65536 bytes)</font>
<br><font size=3D2 face=3D"sans-serif">Mount cache hash table entries: 512
(order: 0, 4096 bytes)</font>
<br><font size=3D2 face=3D"sans-serif">Buffer cache hash table entries: 8192
(order: 3, 32768 bytes)</font>
<br><font size=3D2 face=3D"sans-serif">Page-cache hash table entries: 32768
(order: 5, 131072 bytes)</font>
<br><font size=3D2 face=3D"sans-serif">POSIX conformance testing by UNIFIX<=
/font>
<br><font size=3D2 face=3D"sans-serif">PCI: Probing PCI hardware</font>
<br><font size=3D2 face=3D"sans-serif">Linux NET4.0 for Linux 2.4</font>
<br><font size=3D2 face=3D"sans-serif">Based upon Swansea University Comput=
er
Society NET3.039</font>
<br><font size=3D2 face=3D"sans-serif">Initializing RT netlink socket</font>
<br><font size=3D2 face=3D"sans-serif">Starting kswapd</font>
<br><font size=3D2 face=3D"sans-serif">Journalled Block Device driver loade=
d</font>
<br><font size=3D2 face=3D"sans-serif">JFFS2 version 2.2. (C) 2001-2003 Red
Hat, Inc.</font>
<br><font size=3D2 face=3D"sans-serif">i2c-core.o: i2c core module version
2.6.1 (20010830)</font>
<br><font size=3D2 face=3D"sans-serif">i2c-dev.o: i2c /dev entries driver m=
odule
version 2.6.1 (20010830)</font>
<br><font size=3D2 face=3D"sans-serif">pty: 256 Unix98 ptys configured</fon=
t>
<br><font size=3D2 face=3D"sans-serif">ttyS0 on PSC1</font>
<br><font size=3D2 face=3D"sans-serif">ttyS1 on PSC2</font>
<br><font size=3D2 face=3D"sans-serif">ttyS2 on PSC3</font>
<br><font size=3D2 face=3D"sans-serif">PCF8563 Real-Time Clock Driver $Revi=
sion:
1.3 $ wd@denx.de</font>
<br><font size=3D2 face=3D"sans-serif">RAMDISK driver initialized: 16 RAM d=
isks
of 4096K size 1024 blocksize</font>
<br><font size=3D2 face=3D"sans-serif">loop: loaded (max 8 devices)</font>
<br><font size=3D2 face=3D"sans-serif">Uniform Multi-Platform E-IDE driver
Revision: 7.00beta4-2.4</font>
<br><font size=3D2 face=3D"sans-serif">ide: Assuming 33MHz system bus speed
for PIO modes; override with idebus=3Dxx</font>
<br><font size=3D2 face=3D"sans-serif">Port Config is: 0x91050404</font>
<br><font size=3D2 face=3D"sans-serif">ipb=3D66MHz, set clock period to 15<=
/font>
<br><font size=3D2 face=3D"sans-serif">GPIO config: 91050404</font>
<br><font size=3D2 face=3D"sans-serif">ATA invalid: 00800000</font>
<br><font size=3D2 face=3D"sans-serif">ATA hostcnf: 03000000</font>
<br><font size=3D2 face=3D"sans-serif">ATA pio1 &nbsp; : 100a0a00</font>
<br><font size=3D2 face=3D"sans-serif">ATA pio2 &nbsp; : 02040600</font>
<br><font size=3D2 face=3D"sans-serif">XLB Arb cnf: 80002006</font>
<br><font size=3D2 face=3D"sans-serif">mpc5xxx=5Fide: Setting up IDE interf=
ace
ide0...</font>
<br><font size=3D2 face=3D"sans-serif">Probing IDE interface ide0...</font>
<br><font size=3D2 face=3D"sans-serif">hda: SanDisk SDCFB-16, CFA DISK driv=
e</font>
<br><font size=3D2 face=3D"sans-serif">ide0 at 0xf0003a60-0xf0003a67,0xf000=
3a5c
on irq 45</font>
<br><font size=3D2 face=3D"sans-serif">hda: attached ide-disk driver.</font>
<br><font size=3D2 face=3D"sans-serif">hda: 31360 sectors (16 MB) w/1KiB Ca=
che,
CHS=3D490/2/32</font>
<br><font size=3D2 face=3D"sans-serif">Partition check:</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;hda: hda1</font>
<br><font size=3D2 face=3D"sans-serif">NS4 Bank 0: Found 1 x16 devices at 0=
x0
in 8-bit mode</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Amd/Fujitsu Extended Query Tab=
le
at 0x0040</font>
<br><font size=3D2 face=3D"sans-serif">NS4 Bank 0: CFI does not contain boot
bank location. Assuming top.</font>
<br><font size=3D2 face=3D"sans-serif">number of CFI chips: 1</font>
<br><font size=3D2 face=3D"sans-serif">cfi=5Fcmdset=5F0002: Disabling erase=
-suspend-program
due to code brokenness.</font>
<br><font size=3D2 face=3D"sans-serif">NS4 flash bank 0: Using static image
partition definition</font>
<br><font size=3D2 face=3D"sans-serif">Creating 5 MTD partitions on &quot;N=
S4
Bank 0&quot;:</font>
<br><font size=3D2 face=3D"sans-serif">0x00000000-0x00100000 : &quot;U-Boot=
&quot;</font>
<br><font size=3D2 face=3D"sans-serif">0x00100000-0x00200000 : &quot;kernel=
&quot;</font>
<br><font size=3D2 face=3D"sans-serif">0x00200000-0x00500000 : &quot;initrd=
&quot;</font>
<br><font size=3D2 face=3D"sans-serif">0x00500000-0x00b00000 : &quot;jffs2&=
quot;</font>
<br><font size=3D2 face=3D"sans-serif">0x00b00000-0x01000000 : &quot;Spare&=
quot;</font>
<br>
<br><font size=3D2 face=3D"sans-serif">--- cut out insignificant rest of co=
nsole
output &nbsp;---</font>
<br>
<br>
<br><font size=3D2 face=3D"sans-serif">Now I have a brand new SanDisk 1GB I=
ndustrial
Grade card that is giving me a problem. &nbsp;Here is what happens</font>
<br><font size=3D2 face=3D"sans-serif">with exactly the same u-boot and ker=
nel
versions, just this new CF card plugged in instead of the older one.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">U-Boot 1.1.2 (Dec &nbsp;2 2004 - 16:=
01:06)</font>
<br>
<br><font size=3D2 face=3D"sans-serif">CPU: &nbsp; MPC5200 v1.2 at 396 MHz<=
/font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp;Bus 132 M=
Hz,
IPB 66 MHz, PCI 33 MHz</font>
<br><font size=3D2 face=3D"sans-serif">Board: Marel NS4</font>
<br><font size=3D2 face=3D"sans-serif">I2C: &nbsp; 85 kHz, ready</font>
<br><font size=3D2 face=3D"sans-serif">DRAM: &nbsp;128 MB</font>
<br><font size=3D2 face=3D"sans-serif">FLASH: 16 MB</font>
<br><font size=3D2 face=3D"sans-serif">In: &nbsp; &nbsp;serial</font>
<br><font size=3D2 face=3D"sans-serif">Out: &nbsp; serial</font>
<br><font size=3D2 face=3D"sans-serif">Err: &nbsp; serial</font>
<br><font size=3D2 face=3D"sans-serif">Net: &nbsp; FEC ETHERNET</font>
<br><font size=3D2 face=3D"sans-serif">IDE: &nbsp; Bus 0: OK </font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; Device 0: Model: SanDisk SDCF=
BI-1024
Firm: HDX 2.15 Ser#: 111515L1004P3254</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp;
Type: Hard Disk</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp;
Capacity: 977.4 MB =3D 0.9 GB (2001888 x 512)</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Type &quot;run flash=5Fnfs&quot; to =
mount
root filesystem over NFS</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Hit any key to stop autoboot: &nbsp;0
</font>
<br><font size=3D2 face=3D"sans-serif">Using FEC ETHERNET device</font>
<br><font size=3D2 face=3D"sans-serif">TFTP from server 10.100.1.30; our IP
address is 10.100.50.68</font>
<br><font size=3D2 face=3D"sans-serif">Filename 'mpc5200/uImage'.</font>
<br><font size=3D2 face=3D"sans-serif">Load address: 0x200000</font>
<br><font size=3D2 face=3D"sans-serif">Loading: ###########################=
######################################</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;##=
###############################################################</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;##=
###########################</font>
<br><font size=3D2 face=3D"sans-serif">done</font>
<br><font size=3D2 face=3D"sans-serif">Bytes transferred =3D 810417 (c5db1 =
hex)</font>
<br><font size=3D2 face=3D"sans-serif">## Booting image at 00200000 ...</fo=
nt>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp;Image Name: &nbsp; Linu=
x-2.4.25</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp;Created: &nbsp; &nbsp;
&nbsp;2004-12-03 &nbsp;11:35:18 UTC</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp;Image Type: &nbsp; Powe=
rPC
Linux Kernel Image (gzip compressed)</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp;Data Size: &nbsp; &nbsp=
;810353
Bytes =3D 791.4 kB</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp;Load Address: 00000000<=
/font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp;Entry Point: &nbsp;0000=
0000</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp;Verifying Checksum ...
OK</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp;Uncompressing Kernel Im=
age
... OK</font>
<br><font size=3D2 face=3D"sans-serif">Memory BAT mapping: BAT2=3D128Mb, BA=
T3=3D0Mb,
residual: 0Mb</font>
<br><font size=3D2 face=3D"sans-serif">Linux version 2.4.25 (jonb@tux.marel=
.is)
(gcc version 3.2.2 20030217 (Yellow Dog</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;Linux 3.0 3.2.2-2a=5F1)) #4 F=
=F6s
Des 3 11:34:35 UTC 2004</font>
<br><font size=3D2 face=3D"sans-serif">On node 0 totalpages: 32768</font>
<br><font size=3D2 face=3D"sans-serif">zone(0): 32768 pages.</font>
<br><font size=3D2 face=3D"sans-serif">zone(1): 0 pages.</font>
<br><font size=3D2 face=3D"sans-serif">zone(2): 0 pages.</font>
<br><font size=3D2 face=3D"sans-serif">Kernel command line: root=3D/dev/nfs=
 rw
nfsroot=3D10.100.1.30:/opt/eldk/ppc=5F82xx ip=3D</font>
<br><font size=3D2 face=3D"sans-serif">10.100.50.68:10.100.1.30:10.100.254.=
254:255.255.0.0:ns4b:eth0:off
panic=3D1</font>
<br><font size=3D2 face=3D"sans-serif">Calibrating delay loop... 263.78 Bog=
oMIPS</font>
<br><font size=3D2 face=3D"sans-serif">Memory: 127080k available (1396k ker=
nel
code, 464k data, 76k init, 0k highmem)</font>
<br><font size=3D2 face=3D"sans-serif">Dentry cache hash table entries: 163=
84
(order: 5, 131072 bytes)</font>
<br><font size=3D2 face=3D"sans-serif">Inode cache hash table entries: 8192
(order: 4, 65536 bytes)</font>
<br><font size=3D2 face=3D"sans-serif">Mount cache hash table entries: 512
(order: 0, 4096 bytes)</font>
<br><font size=3D2 face=3D"sans-serif">Buffer cache hash table entries: 8192
(order: 3, 32768 bytes)</font>
<br><font size=3D2 face=3D"sans-serif">Page-cache hash table entries: 32768
(order: 5, 131072 bytes)</font>
<br><font size=3D2 face=3D"sans-serif">POSIX conformance testing by UNIFIX<=
/font>
<br><font size=3D2 face=3D"sans-serif">PCI: Probing PCI hardware</font>
<br><font size=3D2 face=3D"sans-serif">Linux NET4.0 for Linux 2.4</font>
<br><font size=3D2 face=3D"sans-serif">Based upon Swansea University Comput=
er
Society NET3.039</font>
<br><font size=3D2 face=3D"sans-serif">Initializing RT netlink socket</font>
<br><font size=3D2 face=3D"sans-serif">Starting kswapd</font>
<br><font size=3D2 face=3D"sans-serif">Journalled Block Device driver loade=
d</font>
<br><font size=3D2 face=3D"sans-serif">JFFS2 version 2.2. (C) 2001-2003 Red
Hat, Inc.</font>
<br><font size=3D2 face=3D"sans-serif">i2c-core.o: i2c core module version
2.6.1 (20010830)</font>
<br><font size=3D2 face=3D"sans-serif">i2c-dev.o: i2c /dev entries driver m=
odule
version 2.6.1 (20010830)</font>
<br><font size=3D2 face=3D"sans-serif">pty: 256 Unix98 ptys configured</fon=
t>
<br><font size=3D2 face=3D"sans-serif">ttyS0 on PSC1</font>
<br><font size=3D2 face=3D"sans-serif">ttyS1 on PSC2</font>
<br><font size=3D2 face=3D"sans-serif">ttyS2 on PSC3</font>
<br><font size=3D2 face=3D"sans-serif">PCF8563 Real-Time Clock Driver $Revi=
sion:
1.3 $ wd@denx.de</font>
<br><font size=3D2 face=3D"sans-serif">RAMDISK driver initialized: 16 RAM d=
isks
of 4096K size 1024 blocksize</font>
<br><font size=3D2 face=3D"sans-serif">loop: loaded (max 8 devices)</font>
<br><font size=3D2 face=3D"sans-serif">Uniform Multi-Platform E-IDE driver
Revision: 7.00beta4-2.4</font>
<br><font size=3D2 face=3D"sans-serif">ide: Assuming 33MHz system bus speed
for PIO modes; override with idebus=3Dxx</font>
<br><font size=3D2 face=3D"sans-serif">Port Config is: 0x91050404</font>
<br><font size=3D2 face=3D"sans-serif">ipb=3D66MHz, set clock period to 15<=
/font>
<br><font size=3D2 face=3D"sans-serif">GPIO config: 91050404</font>
<br><font size=3D2 face=3D"sans-serif">ATA invalid: 00800000</font>
<br><font size=3D2 face=3D"sans-serif">ATA hostcnf: 03000000</font>
<br><font size=3D2 face=3D"sans-serif">ATA pio1 &nbsp; : 100a0a00</font>
<br><font size=3D2 face=3D"sans-serif">ATA pio2 &nbsp; : 02040600</font>
<br><font size=3D2 face=3D"sans-serif">XLB Arb cnf: 80002006</font>
<br><font size=3D2 face=3D"sans-serif">mpc5xxx=5Fide: Setting up IDE interf=
ace
ide0...</font>
<br><font size=3D2 face=3D"sans-serif">Probing IDE interface ide0...</font>
<br><font size=3D2 face=3D"sans-serif">hda: SanDisk SDCFBI-1024, ATA DISK d=
rive</font>
<br><font size=3D2 face=3D"sans-serif">hdb: probing with STATUS(0x00) inste=
ad
of ALTSTATUS(0x7f)</font>
<br><font size=3D2 face=3D"sans-serif">ide0: unexpected interrupt, status=
=3D0x00,
count=3D1</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Here the boot process fails and the
kernel hangs without further messages to the console.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Actually I did get one bootup with t=
his
1 GB SanDisk Industrial Grade card that succeeded &nbsp;without this happen=
ing,
where the card seemed to be</font>
<br><font size=3D2 face=3D"sans-serif">properly identiified, but I have not
been able to repeat that.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Does anyone have a clue what might be
causing this ?</font>
<br>
<br>
<br><font size=3D2 face=3D"sans-serif">Thanks,</font>
<br><font size=3D2 face=3D"sans-serif">Jon Benediktsson</font>
<br><font size=3D2 face=3D"sans-serif">Marel hf.</font>
<br>
