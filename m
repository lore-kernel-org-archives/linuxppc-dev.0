Return-Path: <jagadeesh.k@rediffmail.com>
Received: from rediffmail.com (unknown [203.199.83.28])
	by ozlabs.org (Postfix) with SMTP id 06AB667B2D
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jun 2006 01:32:14 +1000 (EST)
Date: 18 Jun 2006 15:23:44 -0000
Message-ID: <20060618152344.13300.qmail@webmail18.rediffmail.com>
MIME-Version: 1.0
From: "jagadeesh kalisetty" <jagadeesh.k@rediffmail.com>
To: linuxppc-dev@ozlabs.org
Subject: help requesting for mounting eldk tools on AMCC PPC 405EP Taihu kit
Content-type: multipart/alternative;
	boundary="Next_1150644224---0-203.199.83.28-13246"
Reply-To: jagadeesh kalisetty <jagadeesh.k@rediffmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 This is a multipart mime message


--Next_1150644224---0-203.199.83.28-13246
Content-type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi=0A=0A I am using Taihu Amcc PPC 405EP kit it already contains the U-boot=
, Linux kernel image, and ramdisk image. I connected the kit using c-kermit=
 on fedora core 4 and installed eldk tools and added it (/opt/eldk/ppc_4xx)=
 to NFS sharing.=0AWhile booting on kit I passed kernel arguments as =0Aset=
env bootargs root=3D/dev/nfs nfsroot=3D192.168.2.18:/opt/eldk/ppc_4xx ip=3D=
192.168.1.62:::::eth0:off=0A=0A but the kernel is failed to mount on /dev/n=
fs as below please can you provide necessary steps to fix the problem.=0AI =
am waiting for your response. =0A    =0A=85=85=85.after U-booting on kit=85=
..=0AHit any key to stop autoboot:  0=0A=3D> setenv setboot setenv bootargs=
 root=3D/dev/pts nfsroot=3D192.168.2.18:/opt/eldk/ppc_4xx ip=3D192.168.1.62=
:::::eth0:off=0A=3D> printenv=0Abootdelay=3D5=0Abaudrate=3D9600=0Afilesize=
=3Debb7e5=0Aethaddr=3D50:00:00:00:25:00=0Aeth1addr=3D50:00:00:00:25:01=0Alo=
ads_echo=3D1=0Aethact=3Dppc_4xx_eth0=0Abootcmd=3Drun setboot;bootm 0xfc0000=
00 0xfc300000=0Akozio=3Dbootm 0xffe00000=0ART_eth0_ip=3D192.168.1.62=0ART_e=
th0_ip2=3D:::::eth0:off=0Astdin=3Dserial=0Astdout=3Dserial=0Astderr=3Dseria=
l=0Aver=3DU-Boot 1.1.4 (Jan 19 2006 - 14:16:53)=0Asetboot=3Dsetenv bootargs=
 root=3D/dev/pts nfsroot=3D192.168.2.18:/opt/eldk/ppc_4xx ip=3D192.168.1.62=
:::::eth0:off=0A=0AEnvironment size: 450/16379 bytes=0A=3D> boot=0A## Booti=
ng image at fc000000 ...=0A   Image Name:   Linux-2.6.13=0A   Image Type:  =
 PowerPC Linux Kernel Image (gzip compressed)=0A   Data Size:    1121647 By=
tes =3D  1.1 MB=0A   Load Address: 00000000=0A   Entry Point:  00000000=0A =
  Verifying Checksum ... OK=0A   Uncompressing Kernel Image ... OK=0A## Loa=
ding RAMDisk Image at fc300000 ...=0A   Image Name:   Taihu Ramdisk=0A   Im=
age Type:   PowerPC Linux RAMDisk Image (gzip compressed)=0A   Data Size:  =
  15447973 Bytes =3D 14.7 MB=0A   Load Address: 00000000=0A   Entry Point: =
 00000000=0A   Verifying Checksum ... OK=0A   Loading Ramdisk to 070e3000, =
end 07f9e7a5 ... OK=0ALinux version 2.6.13 (root@linux_box) (gcc version 4.=
0.0 (DENX ELDK 4.0 4.0.0)) #50 Tue Feb 7 09:07:24 CST 2006=0AAMCC PowerPC 4=
05EP Taihu Platform=0ABuilt 1 zonelists=0AKernel command line: root=3D/dev/=
pts nfsroot=3D192.168.2.18:/opt/eldk/ppc_4xx ip=3D192.168.1.62:::::eth0:off=
=0APID hash table entries: 1024 (order: 10, 16384 bytes)=0ADentry cache has=
h table entries: 32768 (order: 5, 131072 bytes)=0AInode-cache hash table en=
tries: 16384 (order: 4, 65536 bytes)=0AMemory: 112128k available (1916k ker=
nel code, 452k data, 96k init, 0k highmem)=0AMount-cache hash table entries=
: 512=0Achecking if image is initramfs...it isn't (no cpio magic); looks li=
ke an initrd=0AFreeing initrd memory: 15085k freed=0ANET: Registered protoc=
ol family 16=0APCI: Probing PCI hardware=0AJFFS2 version 2.2. (NAND) (C) 20=
01-2003 Red Hat, Inc.=0AInitializing Cryptographic API=0ASerial: 8250/16550=
 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled=0AttyS0 at MMIO 0x0 =
(irq =3D 1) is a 16550A=0AttyS1 at MMIO 0x0 (irq =3D 0) is a 16550A=0Aio sc=
heduler noop registered=0Aio scheduler anticipatory registered=0Aio schedul=
er deadline registered=0Aio scheduler cfq registered=0ARAMDISK driver initi=
alized: 16 RAM disks of 4096K size 1024 blocksize=0Aloop: loaded (max 8 dev=
ices)=0Amal0: Initialized, 4 tx channels, 2 rx channels=0Aemac: IBM EMAC Et=
hernet driver, version 2.0=0AMaintained by Benjamin Herrenschmidt <benh@ker=
nel.crashing.org>=0Aeth0: IBM emac, MAC 50:00:00:00:25:00=0Aeth0: Found Gen=
eric MII PHY (0x14)=0Aeth1: IBM emac, MAC 50:00:00:00:25:01=0Aeth1: Found G=
eneric MII PHY (0x10)=0Ae100: Intel(R) PRO/100 Network Driver, 3.4.8-k2-NAP=
I=0Ae100: Copyright(c) 1999-2005 Intel Corporation=0Ataihu: bootflash mappi=
ng: 200000 at ffe00000=0AAMCC Taihu Boot Flash: Found 1 x16 devices at 0x0 =
in 16-bit bank=0A Amd/Fujitsu Extended Query Table at 0x0040=0Anumber of CF=
I chips: 1=0Acfi_cmdset_0002: Disabling erase-suspend-program due to code b=
rokenness.=0ACreating 3 MTD partitions on "AMCC Taihu Boot Flash":=0A0x0000=
0000-0x001a0000 : "kozio diags"=0A0x001a0000-0x001c0000 : "u-boot env"=0A0x=
001c0000-0x00200000 : "u-boot"=0Ataihu: appflash mapping: 2000000 at fc0000=
00=0AAMCC Taihu Application Flash: Found 2 x16 devices at 0x0 in 16-bit ban=
k=0A Amd/Fujitsu Extended Query Table at 0x0040=0AAMCC Taihu Application Fl=
ash: CFI does not contain boot bank location. Assuming top.=0Anumber of CFI=
 chips: 1=0Acfi_cmdset_0002: Disabling erase-suspend-program due to code br=
okenness.=0ACreating 3 MTD partitions on "AMCC Taihu Application Flash":=0A=
0x00000000-0x00300000 : "kernel"=0A0x00300000-0x01d00000 : "initrd"=0A0x01d=
00000-0x02000000 : "jffs2"=0AYenta: CardBus bridge found at 0000:00:07.0 [0=
000:0000]=0AYenta: Enabling burst memory read transactions=0AYenta: Using C=
SCINT to route CSC interrupts to PCI=0AYenta: Routing CardBus interrupts to=
 PCI=0AYenta TI: socket 0000:00:07.0, mfunc 0x00001000, devctl 0x66=0AYenta=
 TI: socket 0000:00:07.0 probing PCI interrupt failed, trying to fix=0AYent=
a TI: socket 0000:00:07.0 falling back to parallel PCI interrupts=0AYenta T=
I: socket 0000:00:07.0 parallel PCI interrupts ok=0Aeth0: Link is Up=0Aeth0=
: Speed: 100, Full duplex.=0AYenta: ISA IRQ mask 0x0000, PCI irq 26=0ASocke=
t status: 30000087=0Apcmcia: parent PCI bridge I/O window: 0x0 - 0xffff=0Ap=
cmcia: parent PCI bridge Memory window: 0x80000000 - 0xbfffffff=0Azero gadg=
et: Gadget Zero, version: St Patrick's Day 2004=0Azero gadget: using pd12_u=
dc, OUT ep1out-bulk IN ep2in-bulk=0Apd12_udc: registered gadget driver 'zer=
o'=0Ai2c /dev entries driver=0AIBM IIC driver v2.1=0Aibm-iic0: using standa=
rd (100 kHz) mode=0ANET: Registered protocol family 2=0AIP route cache hash=
 table entries: 2048 (order: 1, 8192 bytes)=0ATCP established hash table en=
tries: 8192 (order: 4, 65536 bytes)=0ATCP bind hash table entries: 8192 (or=
der: 3, 32768 bytes)=0ATCP: Hash tables configured (established 8192 bind 8=
192)=0ATCP reno registered=0ATCP bic registered=0ANET: Registered protocol =
family 1=0ANET: Registered protocol family 17=0ANET: Registered protocol fa=
mily 15=0Aeth0: Link is Up=0Aeth0: Speed: 100, Full duplex.=0AIP-Config: Gu=
essing netmask 255.255.255.0=0AIP-Config: Complete:=0A      device=3Deth0, =
addr=3D192.168.1.62, mask=3D255.255.255.0, gw=3D255.255.255.255,=0A     hos=
t=3D192.168.1.62, domain=3D, nis-domain=3D(none),=0A     bootserver=3D255.2=
55.255.255, rootserver=3D255.255.255.255, rootpath=3D=0ARAMDISK: Compressed=
 image found at block 0=0ARAMDISK: incomplete write (-28 !=3D 32768) 419430=
4=0AVFS: Cannot open root device "pts" or unknown-block(0,0)=0APlease appen=
d a correct "root=3D" boot option=0AKernel panic - not syncing: VFS: Unable=
 to mount root fs on unknown-block(0,0)=0A <0>Rebooting in 180 seconds..<NU=
LL>=0A=0A=0A
--Next_1150644224---0-203.199.83.28-13246
Content-type: text/html;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<P>=0Ahi<BR>=0A<BR>=0A I am using Taihu Amcc PPC 405EP kit it already conta=
ins the U-boot, Linux kernel image, and ramdisk image. I connected the kit =
using c-kermit on fedora core 4 and installed eldk tools and added it (/opt=
/eldk/ppc_4xx) to NFS sharing.<BR>=0AWhile booting on kit I passed kernel a=
rguments as <BR>=0Asetenv bootargs root=3D/dev/nfs nfsroot=3D192.168.2.18:/=
opt/eldk/ppc_4xx ip=3D192.168.1.62:::::eth0:off<BR>=0A<BR>=0A but the kerne=
l is failed to mount on /dev/nfs as below please can you provide necessary =
steps to fix the problem.<BR>=0AI am waiting for your response. <BR>=0A&nbs=
p; &nbsp; <BR>=0A=85=85=85.after U-booting on kit=85..<BR>=0AHit any key to=
 stop autoboot:&nbsp; 0<BR>=0A=3D&gt; setenv setboot setenv bootargs root=
=3D/dev/pts nfsroot=3D192.168.2.18:/opt/eldk/ppc_4xx ip=3D192.168.1.62:::::=
eth0:off<BR>=0A=3D&gt; printenv<BR>=0Abootdelay=3D5<BR>=0Abaudrate=3D9600<B=
R>=0Afilesize=3Debb7e5<BR>=0Aethaddr=3D50:00:00:00:25:00<BR>=0Aeth1addr=3D5=
0:00:00:00:25:01<BR>=0Aloads_echo=3D1<BR>=0Aethact=3Dppc_4xx_eth0<BR>=0Aboo=
tcmd=3Drun setboot;bootm 0xfc000000 0xfc300000<BR>=0Akozio=3Dbootm 0xffe000=
00<BR>=0ART_eth0_ip=3D192.168.1.62<BR>=0ART_eth0_ip2=3D:::::eth0:off<BR>=0A=
stdin=3Dserial<BR>=0Astdout=3Dserial<BR>=0Astderr=3Dserial<BR>=0Aver=3DU-Bo=
ot 1.1.4 (Jan 19 2006 - 14:16:53)<BR>=0Asetboot=3Dsetenv bootargs root=3D/d=
ev/pts nfsroot=3D192.168.2.18:/opt/eldk/ppc_4xx ip=3D192.168.1.62:::::eth0:=
off<BR>=0A<BR>=0AEnvironment size: 450/16379 bytes<BR>=0A=3D&gt; boot<BR>=
=0A## Booting image at fc000000 ...<BR>=0A&nbsp;  Image Name:&nbsp;  Linux-=
2.6.13<BR>=0A&nbsp;  Image Type:&nbsp;  PowerPC Linux Kernel Image (gzip co=
mpressed)<BR>=0A&nbsp;  Data Size:&nbsp; &nbsp; 1121647 Bytes =3D&nbsp; 1.1=
 MB<BR>=0A&nbsp;  Load Address: 00000000<BR>=0A&nbsp;  Entry Point:&nbsp; 0=
0000000<BR>=0A&nbsp;  Verifying Checksum ... OK<BR>=0A&nbsp;  Uncompressing=
 Kernel Image ... OK<BR>=0A## Loading RAMDisk Image at fc300000 ...<BR>=0A&=
nbsp;  Image Name:&nbsp;  Taihu Ramdisk<BR>=0A&nbsp;  Image Type:&nbsp;  Po=
werPC Linux RAMDisk Image (gzip compressed)<BR>=0A&nbsp;  Data Size:&nbsp; =
&nbsp; 15447973 Bytes =3D 14.7 MB<BR>=0A&nbsp;  Load Address: 00000000<BR>=
=0A&nbsp;  Entry Point:&nbsp; 00000000<BR>=0A&nbsp;  Verifying Checksum ...=
 OK<BR>=0A&nbsp;  Loading Ramdisk to 070e3000, end 07f9e7a5 ... OK<BR>=0ALi=
nux version 2.6.13 (root@linux_box) (gcc version 4.0.0 (DENX ELDK 4.0 4.0.0=
)) #50 Tue Feb 7 09:07:24 CST 2006<BR>=0AAMCC PowerPC 405EP Taihu Platform<=
BR>=0ABuilt 1 zonelists<BR>=0AKernel command line: root=3D/dev/pts nfsroot=
=3D192.168.2.18:/opt/eldk/ppc_4xx ip=3D192.168.1.62:::::eth0:off<BR>=0APID =
hash table entries: 1024 (order: 10, 16384 bytes)<BR>=0ADentry cache hash t=
able entries: 32768 (order: 5, 131072 bytes)<BR>=0AInode-cache hash table e=
ntries: 16384 (order: 4, 65536 bytes)<BR>=0AMemory: 112128k available (1916=
k kernel code, 452k data, 96k init, 0k highmem)<BR>=0AMount-cache hash tabl=
e entries: 512<BR>=0Achecking if image is initramfs...it isn't (no cpio mag=
ic); looks like an initrd<BR>=0AFreeing initrd memory: 15085k freed<BR>=0AN=
ET: Registered protocol family 16<BR>=0APCI: Probing PCI hardware<BR>=0AJFF=
S2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.<BR>=0AInitializing Crypt=
ographic API<BR>=0ASerial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ=
 sharing enabled<BR>=0AttyS0 at MMIO 0x0 (irq =3D 1) is a 16550A<BR>=0AttyS=
1 at MMIO 0x0 (irq =3D 0) is a 16550A<BR>=0Aio scheduler noop registered<BR=
>=0Aio scheduler anticipatory registered<BR>=0Aio scheduler deadline regist=
ered<BR>=0Aio scheduler cfq registered<BR>=0ARAMDISK driver initialized: 16=
 RAM disks of 4096K size 1024 blocksize<BR>=0Aloop: loaded (max 8 devices)<=
BR>=0Amal0: Initialized, 4 tx channels, 2 rx channels<BR>=0Aemac: IBM EMAC =
Ethernet driver, version 2.0<BR>=0AMaintained by Benjamin Herrenschmidt &lt=
;benh@kernel.crashing.org&gt;<BR>=0Aeth0: IBM emac, MAC 50:00:00:00:25:00<B=
R>=0Aeth0: Found Generic MII PHY (0x14)<BR>=0Aeth1: IBM emac, MAC 50:00:00:=
00:25:01<BR>=0Aeth1: Found Generic MII PHY (0x10)<BR>=0Ae100: Intel(R) PRO/=
100 Network Driver, 3.4.8-k2-NAPI<BR>=0Ae100: Copyright(c) 1999-2005 Intel =
Corporation<BR>=0Ataihu: bootflash mapping: 200000 at ffe00000<BR>=0AAMCC T=
aihu Boot Flash: Found 1 x16 devices at 0x0 in 16-bit bank<BR>=0A Amd/Fujit=
su Extended Query Table at 0x0040<BR>=0Anumber of CFI chips: 1<BR>=0Acfi_cm=
dset_0002: Disabling erase-suspend-program due to code brokenness.<BR>=0ACr=
eating 3 MTD partitions on &quot;AMCC Taihu Boot Flash&quot;:<BR>=0A0x00000=
000-0x001a0000 : &quot;kozio diags&quot;<BR>=0A0x001a0000-0x001c0000 : &quo=
t;u-boot env&quot;<BR>=0A0x001c0000-0x00200000 : &quot;u-boot&quot;<BR>=0At=
aihu: appflash mapping: 2000000 at fc000000<BR>=0AAMCC Taihu Application Fl=
ash: Found 2 x16 devices at 0x0 in 16-bit bank<BR>=0A Amd/Fujitsu Extended =
Query Table at 0x0040<BR>=0AAMCC Taihu Application Flash: CFI does not cont=
ain boot bank location. Assuming top.<BR>=0Anumber of CFI chips: 1<BR>=0Acf=
i_cmdset_0002: Disabling erase-suspend-program due to code brokenness.<BR>=
=0ACreating 3 MTD partitions on &quot;AMCC Taihu Application Flash&quot;:<B=
R>=0A0x00000000-0x00300000 : &quot;kernel&quot;<BR>=0A0x00300000-0x01d00000=
 : &quot;initrd&quot;<BR>=0A0x01d00000-0x02000000 : &quot;jffs2&quot;<BR>=
=0AYenta: CardBus bridge found at 0000:00:07.0 [0000:0000]<BR>=0AYenta: Ena=
bling burst memory read transactions<BR>=0AYenta: Using CSCINT to route CSC=
 interrupts to PCI<BR>=0AYenta: Routing CardBus interrupts to PCI<BR>=0AYen=
ta TI: socket 0000:00:07.0, mfunc 0x00001000, devctl 0x66<BR>=0AYenta TI: s=
ocket 0000:00:07.0 probing PCI interrupt failed, trying to fix<BR>=0AYenta =
TI: socket 0000:00:07.0 falling back to parallel PCI interrupts<BR>=0AYenta=
 TI: socket 0000:00:07.0 parallel PCI interrupts ok<BR>=0Aeth0: Link is Up<=
BR>=0Aeth0: Speed: 100, Full duplex.<BR>=0AYenta: ISA IRQ mask 0x0000, PCI =
irq 26<BR>=0ASocket status: 30000087<BR>=0Apcmcia: parent PCI bridge I/O wi=
ndow: 0x0 - 0xffff<BR>=0Apcmcia: parent PCI bridge Memory window: 0x8000000=
0 - 0xbfffffff<BR>=0Azero gadget: Gadget Zero, version: St Patrick's Day 20=
04<BR>=0Azero gadget: using pd12_udc, OUT ep1out-bulk IN ep2in-bulk<BR>=0Ap=
d12_udc: registered gadget driver 'zero'<BR>=0Ai2c /dev entries driver<BR>=
=0AIBM IIC driver v2.1<BR>=0Aibm-iic0: using standard (100 kHz) mode<BR>=0A=
NET: Registered protocol family 2<BR>=0AIP route cache hash table entries: =
2048 (order: 1, 8192 bytes)<BR>=0ATCP established hash table entries: 8192 =
(order: 4, 65536 bytes)<BR>=0ATCP bind hash table entries: 8192 (order: 3, =
32768 bytes)<BR>=0ATCP: Hash tables configured (established 8192 bind 8192)=
<BR>=0ATCP reno registered<BR>=0ATCP bic registered<BR>=0ANET: Registered p=
rotocol family 1<BR>=0ANET: Registered protocol family 17<BR>=0ANET: Regist=
ered protocol family 15<BR>=0Aeth0: Link is Up<BR>=0Aeth0: Speed: 100, Full=
 duplex.<BR>=0AIP-Config: Guessing netmask 255.255.255.0<BR>=0AIP-Config: C=
omplete:<BR>=0A&nbsp; &nbsp; &nbsp; device=3Deth0, addr=3D192.168.1.62, mas=
k=3D255.255.255.0, gw=3D255.255.255.255,<BR>=0A&nbsp; &nbsp;  host=3D192.16=
8.1.62, domain=3D, nis-domain=3D(none),<BR>=0A&nbsp; &nbsp;  bootserver=3D2=
55.255.255.255, rootserver=3D255.255.255.255, rootpath=3D<BR>=0ARAMDISK: Co=
mpressed image found at block 0<BR>=0ARAMDISK: incomplete write (-28 !=3D 3=
2768) 4194304<BR>=0AVFS: Cannot open root device &quot;pts&quot; or unknown=
-block(0,0)<BR>=0APlease append a correct &quot;root=3D&quot; boot option<B=
R>=0AKernel panic - not syncing: VFS: Unable to mount root fs on unknown-bl=
ock(0,0)<BR>=0A &lt;0&gt;Rebooting in 180 seconds..&lt;NULL&gt;<BR>=0A<BR>=
=0A<BR>=0A=0A</P>=0A<br><br>=0A<a href=3D"http://adworks.rediff.com/cgi-bin=
/AdWorks/sigclick.cgi/www.rediff.com/signature-home.htm/1507191490@Middle5?=
PARTNER=3D3"><IMG SRC=3D"http://adworks.rediff.com/cgi-bin/AdWorks/sigimpre=
ss.cgi/www.rediff.com/signature-home.htm/1963059423@Middle5?OAS_query=3Dnul=
l&PARTNER=3D3" BORDER=3D0 VSPACE=3D0 HSPACE=3D0></a>=0A
--Next_1150644224---0-203.199.83.28-13246--
