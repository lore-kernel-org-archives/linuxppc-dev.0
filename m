Return-Path: <jagadeesh.k@rediffmail.com>
Received: from rediffmail.com (unknown [203.199.83.38])
	by ozlabs.org (Postfix) with SMTP id 464D9679E6
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jun 2006 03:20:41 +1000 (EST)
Date: 22 Jun 2006 17:18:46 -0000
Message-ID: <20060622171846.18376.qmail@webmail28.rediffmail.com>
MIME-Version: 1.0
From: "jagadeesh kalisetty" <jagadeesh.k@rediffmail.com>
To: linuxppc-dev@ozlabs.org
Cc: linuxppc-dev-request@ozlabs.org
Subject: help to run the C code on AMCC PPC 405EP Kit
Content-type: multipart/alternative;
	boundary="Next_1150996726---0-203.199.83.38-18353"
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


--Next_1150996726---0-203.199.83.38-18353
Content-type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi=0A     We are using AMCC PPC 405EP Taihu board, our aim is to run the C =
code on kit. The kit already contains U-boot, linux kernel, and Ramdik imag=
es on Flash memory. We are successfully configured C-Kermit, NFS server(/op=
t/eldk4/ppc_4xx, /mnt/nfs-share) on host(Fedora Core 4). We are succeeded  =
loading the files from NFS server after U-boot, but we are failed to mount =
the files (/mnt/nfs-share) on target after kernel booting on kit. But booth=
 host and target are communicating after kernel booting (using ping). =0A=
=0AWe using the command to mount /mnt/nfs-share on target(Busy box 1.1.0):=
=0A=0A target # mkdir /mnt/nfs=0A target # mount =96t nfs 192.168.1.18:/mnt=
/nfs-share /mnt/nfs=0Aerror: monting 192.168.1.18:/mnt/nfs-share on /mnt/nf=
s : No such directory or file=0A=0ACan u tell how to mount flash file syste=
m on target, using that one also we can run (bebug) the programs on kit usi=
ng gdb=0A=0ASo we are failed to transfer any file on to the target. Is it a=
ny way to run the program on kit using host side ppc_4xx-gdb tool and targe=
t side gdbserver tool?=0A=0AIs there any another way to run the code on the=
 target or =0A=0ABelow is the problem we are facing while passing arguments=
 to the kernel =85=85.=0Awe are expecting that there is no nfs device notic=
e on the target, we tried different ways but we have failed to mount the ro=
ot file system on linux or to mount host files on target, But we are succee=
ded  loading the files from NFS server after U-boot=0A=0AHit any key to sto=
p autoboot:  0=0A=3D> printenv=0Abootdelay=3D5=0Abaudrate=3D9600=0Afilesize=
=3Debb7e5=0Aethaddr=3D50:00:00:00:25:00=0Aeth1addr=3D50:00:00:00:25:01=0Alo=
ads_echo=3D1=0Asetboot=3Dsetenv bootargs ramdisk=3D71800 root=3D/dev/ram ip=
=3D$(RT_eth0_ip)$(RT_eth0_ip2)=0Aethact=3Dppc_4xx_eth0=0Abootcmd=3Drun setb=
oot;bootm 0xfc000000 0xfc300000=0Akozio=3Dbootm 0xffe00000=0ART_eth0_ip=3D1=
92.168.1.62=0ART_eth0_ip2=3D:::::eth0:off=0Aipaddr=3D192.168.1.62=0Aserveri=
p=3D192.168.1.18=0Anetmask=3D255.255.255.0=0Ahostname=3Dtaihu=0Anetdev=3Det=
h0=0Astdin=3Dserial=0Astdout=3Dserial=0Astderr=3Dserial=0Aver=3DU-Boot 1.1.=
4 (Jan 19 2006 - 14:16:53)=0A=0AEnvironment size: 722/16379 bytes=0A=3D> se=
tenv bootargs root=3D/dev/nfs rw nfsroot=3D192.168.1.18:/opt/eldk/ppc_4xx i=
p=3D192.168.1.62:192.168.1.18::::eth0:off=0A=3D> bootm 0xfc000000=0A## Boot=
ing image at fc000000 ...=0A   Image Name:   Linux-2.6.13=0A   Image Type: =
  PowerPC Linux Kernel Image (gzip compressed)=0A   Data Size:    1121647 B=
ytes =3D  1.1 MB=0A   Load Address: 00000000=0A   Entry Point:  00000000=0A=
   Verifying Checksum ... OK=0A   Uncompressing Kernel Image ... OK=0ALinux=
 version 2.6.13 (root@linux_box) (gcc version 4.0.0 (DENX ELDK 4.0 4.0.0)) =
#50 Tue Feb 7 09:07:24 CST 2006=0AAMCC PowerPC 405EP Taihu Platform=0ABuilt=
 1 zonelists=0AKernel command line: root=3D/dev/nfs rw nfsroot=3D192.168.1.=
18:/opt/eldk/ppc_4xx ip=3D192.168.1.62:192.168.1.18::::eth0:off=0APID hash =
table entries: 1024 (order: 10, 16384 bytes)=0ADentry cache hash table entr=
ies: 32768 (order: 5, 131072 bytes)=0AInode-cache hash table entries: 16384=
 (order: 4, 65536 bytes)=0AMemory: 127232k available (1916k kernel code, 45=
2k data, 96k init, 0k highmem)=0AMount-cache hash table entries: 512=0ANET:=
 Registered protocol family 16=0APCI: Probing PCI hardware=0AJFFS2 version =
2.2. (NAND) (C) 2001-2003 Red Hat, Inc.=0AInitializing Cryptographic API=0A=
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled=0A=
ttyS0 at MMIO 0x0 (irq =3D 1) is a 16550A=0AttyS1 at MMIO 0x0 (irq =3D 0) i=
s a 16550A=0Aio scheduler noop registered=0Aio scheduler anticipatory regis=
tered=0Aio scheduler deadline registered=0Aio scheduler cfq registered=0ARA=
MDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize=0Aloop:=
 loaded (max 8 devices)=0Amal0: Initialized, 4 tx channels, 2 rx channels=
=0Aemac: IBM EMAC Ethernet driver, version 2.0=0AMaintained by Benjamin Her=
renschmidt <benh@kernel.crashing.org>=0Aeth0: IBM emac, MAC 50:00:00:00:25:=
00=0Aeth0: Found Generic MII PHY (0x14)=0Aeth1: IBM emac, MAC 50:00:00:00:2=
5:01=0Aeth1: Found Generic MII PHY (0x10)=0Ae100: Intel(R) PRO/100 Network =
Driver, 3.4.8-k2-NAPI=0Ae100: Copyright(c) 1999-2005 Intel Corporation=0Ata=
ihu: bootflash mapping: 200000 at ffe00000=0AAMCC Taihu Boot Flash: Found 1=
 x16 devices at 0x0 in 16-bit bank=0A Amd/Fujitsu Extended Query Table at 0=
x0040=0Anumber of CFI chips: 1=0Acfi_cmdset_0002: Disabling erase-suspend-p=
rogram due to code brokenness.=0ACreating 3 MTD partitions on "AMCC Taihu B=
oot Flash":=0A0x00000000-0x001a0000 : "kozio diags"=0A0x001a0000-0x001c0000=
 : "u-boot env"=0A0x001c0000-0x00200000 : "u-boot"=0Ataihu: appflash mappin=
g: 2000000 at fc000000=0AAMCC Taihu Application Flash: Found 2 x16 devices =
at 0x0 in 16-bit bank=0A Amd/Fujitsu Extended Query Table at 0x0040=0AAMCC =
Taihu Application Flash: CFI does not contain boot bank location. Assuming =
top.=0Anumber of CFI chips: 1=0Acfi_cmdset_0002: Disabling erase-suspend-pr=
ogram due to code brokenness.=0ACreating 3 MTD partitions on "AMCC Taihu Ap=
plication Flash":=0A0x00000000-0x00300000 : "kernel"=0A0x00300000-0x01d0000=
0 : "initrd"=0A0x01d00000-0x02000000 : "jffs2"=0AYenta: CardBus bridge foun=
d at 0000:00:07.0 [0000:0000]=0AYenta: Enabling burst memory read transacti=
ons=0AYenta: Using CSCINT to route CSC interrupts to PCI=0AYenta: Routing C=
ardBus interrupts to PCI=0AYenta TI: socket 0000:00:07.0, mfunc 0x00001000,=
 devctl 0x66=0AYenta TI: socket 0000:00:07.0 probing PCI interrupt failed, =
trying to fix=0AYenta TI: socket 0000:00:07.0 falling back to parallel PCI =
interrupts=0AYenta TI: socket 0000:00:07.0 parallel PCI interrupts ok=0Aeth=
0: Link is Up=0Aeth0: Speed: 100, Full duplex.=0AYenta: ISA IRQ mask 0x0000=
, PCI irq 26=0ASocket status: 30000087=0Apcmcia: parent PCI bridge I/O wind=
ow: 0x0 - 0xffff=0Apcmcia: parent PCI bridge Memory window: 0x80000000 - 0x=
bfffffff=0Azero gadget: Gadget Zero, version: St Patrick's Day 2004=0Azero =
gadget: using pd12_udc, OUT ep1out-bulk IN ep2in-bulk=0Apd12_udc: registere=
d gadget driver 'zero'=0Ai2c /dev entries driver=0AIBM IIC driver v2.1=0Aib=
m-iic0: using standard (100 kHz) mode=0ANET: Registered protocol family 2=
=0AIP route cache hash table entries: 2048 (order: 1, 8192 bytes)=0ATCP est=
ablished hash table entries: 8192 (order: 4, 65536 bytes)=0ATCP bind hash t=
able entries: 8192 (order: 3, 32768 bytes)=0ATCP: Hash tables configured (e=
stablished 8192 bind 8192)=0ATCP reno registered=0ATCP bic registered=0ANET=
: Registered protocol family 1=0ANET: Registered protocol family 17=0ANET: =
Registered protocol family 15=0Aeth0: Link is Up=0Aeth0: Speed: 100, Full d=
uplex.=0AIP-Config: Guessing netmask 255.255.255.0=0AIP-Config: Complete:=
=0A      device=3Deth0, addr=3D192.168.1.62, mask=3D255.255.255.0, gw=3D255=
.255.255.255,=0A     host=3D192.168.1.62, domain=3D, nis-domain=3D(none),=
=0A     bootserver=3D192.168.1.18, rootserver=3D192.168.1.18, rootpath=3D=
=0AVFS: Cannot open root device "nfs" or unknown-block(0,255)=0APlease appe=
nd a correct "root=3D" boot option=0AKernel panic - not syncing: VFS: Unabl=
e to mount root fs on unknown-block(0,255)=0A <0>Rebooting in 180 seconds..
--Next_1150996726---0-203.199.83.38-18353
Content-type: text/html;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<P>=0AHi<BR>=0A&nbsp; &nbsp;  We are using AMCC PPC 405EP Taihu board, our =
aim is to run the C code on kit. The kit already contains U-boot, linux ker=
nel, and Ramdik images on Flash memory. We are successfully configured C-Ke=
rmit, NFS server(/opt/eldk4/ppc_4xx, /mnt/nfs-share) on host(Fedora Core 4)=
. We are succeeded&nbsp; loading the files from NFS server after U-boot, bu=
t we are failed to mount the files (/mnt/nfs-share) on target after kernel =
booting on kit. But booth host and target are communicating after kernel bo=
oting (using ping). <BR>=0A<BR>=0AWe using the command to mount /mnt/nfs-sh=
are on target(Busy box 1.1.0):<BR>=0A<BR>=0A target # mkdir /mnt/nfs<BR>=0A=
 target # mount =96t nfs 192.168.1.18:/mnt/nfs-share /mnt/nfs<BR>=0Aerror: =
monting 192.168.1.18:/mnt/nfs-share on /mnt/nfs : No such directory or file=
<BR>=0A<BR>=0ACan u tell how to mount flash file system on target, using th=
at one also we can run (bebug) the programs on kit using gdb<BR>=0A<BR>=0AS=
o we are failed to transfer any file on to the target. Is it any way to run=
 the program on kit using host side ppc_4xx-gdb tool and target side gdbser=
ver tool?<BR>=0A<BR>=0AIs there any another way to run the code on the targ=
et or <BR>=0A<BR>=0ABelow is the problem we are facing while passing argume=
nts to the kernel =85=85.<BR>=0Awe are expecting that there is no nfs devic=
e notice on the target, we tried different ways but we have failed to mount=
 the root file system on linux or to mount host files on target, But we are=
 succeeded&nbsp; loading the files from NFS server after U-boot<BR>=0A<BR>=
=0AHit any key to stop autoboot:&nbsp; 0<BR>=0A=3D&gt; printenv<BR>=0Abootd=
elay=3D5<BR>=0Abaudrate=3D9600<BR>=0Afilesize=3Debb7e5<BR>=0Aethaddr=3D50:0=
0:00:00:25:00<BR>=0Aeth1addr=3D50:00:00:00:25:01<BR>=0Aloads_echo=3D1<BR>=
=0Asetboot=3Dsetenv bootargs ramdisk=3D71800 root=3D/dev/ram ip=3D$(RT_eth0=
_ip)$(RT_eth0_ip2)<BR>=0Aethact=3Dppc_4xx_eth0<BR>=0Abootcmd=3Drun setboot;=
bootm 0xfc000000 0xfc300000<BR>=0Akozio=3Dbootm 0xffe00000<BR>=0ART_eth0_ip=
=3D192.168.1.62<BR>=0ART_eth0_ip2=3D:::::eth0:off<BR>=0Aipaddr=3D192.168.1.=
62<BR>=0Aserverip=3D192.168.1.18<BR>=0Anetmask=3D255.255.255.0<BR>=0Ahostna=
me=3Dtaihu<BR>=0Anetdev=3Deth0<BR>=0Astdin=3Dserial<BR>=0Astdout=3Dserial<B=
R>=0Astderr=3Dserial<BR>=0Aver=3DU-Boot 1.1.4 (Jan 19 2006 - 14:16:53)<BR>=
=0A<BR>=0AEnvironment size: 722/16379 bytes<BR>=0A=3D&gt; setenv bootargs r=
oot=3D/dev/nfs rw nfsroot=3D192.168.1.18:/opt/eldk/ppc_4xx ip=3D192.168.1.6=
2:192.168.1.18::::eth0:off<BR>=0A=3D&gt; bootm 0xfc000000<BR>=0A## Booting =
image at fc000000 ...<BR>=0A&nbsp;  Image Name:&nbsp;  Linux-2.6.13<BR>=0A&=
nbsp;  Image Type:&nbsp;  PowerPC Linux Kernel Image (gzip compressed)<BR>=
=0A&nbsp;  Data Size:&nbsp; &nbsp; 1121647 Bytes =3D&nbsp; 1.1 MB<BR>=0A&nb=
sp;  Load Address: 00000000<BR>=0A&nbsp;  Entry Point:&nbsp; 00000000<BR>=
=0A&nbsp;  Verifying Checksum ... OK<BR>=0A&nbsp;  Uncompressing Kernel Ima=
ge ... OK<BR>=0ALinux version 2.6.13 (root@linux_box) (gcc version 4.0.0 (D=
ENX ELDK 4.0 4.0.0)) #50 Tue Feb 7 09:07:24 CST 2006<BR>=0AAMCC PowerPC 405=
EP Taihu Platform<BR>=0ABuilt 1 zonelists<BR>=0AKernel command line: root=
=3D/dev/nfs rw nfsroot=3D192.168.1.18:/opt/eldk/ppc_4xx ip=3D192.168.1.62:1=
92.168.1.18::::eth0:off<BR>=0APID hash table entries: 1024 (order: 10, 1638=
4 bytes)<BR>=0ADentry cache hash table entries: 32768 (order: 5, 131072 byt=
es)<BR>=0AInode-cache hash table entries: 16384 (order: 4, 65536 bytes)<BR>=
=0AMemory: 127232k available (1916k kernel code, 452k data, 96k init, 0k hi=
ghmem)<BR>=0AMount-cache hash table entries: 512<BR>=0ANET: Registered prot=
ocol family 16<BR>=0APCI: Probing PCI hardware<BR>=0AJFFS2 version 2.2. (NA=
ND) (C) 2001-2003 Red Hat, Inc.<BR>=0AInitializing Cryptographic API<BR>=0A=
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled<BR=
>=0AttyS0 at MMIO 0x0 (irq =3D 1) is a 16550A<BR>=0AttyS1 at MMIO 0x0 (irq =
=3D 0) is a 16550A<BR>=0Aio scheduler noop registered<BR>=0Aio scheduler an=
ticipatory registered<BR>=0Aio scheduler deadline registered<BR>=0Aio sched=
uler cfq registered<BR>=0ARAMDISK driver initialized: 16 RAM disks of 4096K=
 size 1024 blocksize<BR>=0Aloop: loaded (max 8 devices)<BR>=0Amal0: Initial=
ized, 4 tx channels, 2 rx channels<BR>=0Aemac: IBM EMAC Ethernet driver, ve=
rsion 2.0<BR>=0AMaintained by Benjamin Herrenschmidt &lt;benh@kernel.crashi=
ng.org&gt;<BR>=0Aeth0: IBM emac, MAC 50:00:00:00:25:00<BR>=0Aeth0: Found Ge=
neric MII PHY (0x14)<BR>=0Aeth1: IBM emac, MAC 50:00:00:00:25:01<BR>=0Aeth1=
: Found Generic MII PHY (0x10)<BR>=0Ae100: Intel(R) PRO/100 Network Driver,=
 3.4.8-k2-NAPI<BR>=0Ae100: Copyright(c) 1999-2005 Intel Corporation<BR>=0At=
aihu: bootflash mapping: 200000 at ffe00000<BR>=0AAMCC Taihu Boot Flash: Fo=
und 1 x16 devices at 0x0 in 16-bit bank<BR>=0A Amd/Fujitsu Extended Query T=
able at 0x0040<BR>=0Anumber of CFI chips: 1<BR>=0Acfi_cmdset_0002: Disablin=
g erase-suspend-program due to code brokenness.<BR>=0ACreating 3 MTD partit=
ions on &quot;AMCC Taihu Boot Flash&quot;:<BR>=0A0x00000000-0x001a0000 : &q=
uot;kozio diags&quot;<BR>=0A0x001a0000-0x001c0000 : &quot;u-boot env&quot;<=
BR>=0A0x001c0000-0x00200000 : &quot;u-boot&quot;<BR>=0Ataihu: appflash mapp=
ing: 2000000 at fc000000<BR>=0AAMCC Taihu Application Flash: Found 2 x16 de=
vices at 0x0 in 16-bit bank<BR>=0A Amd/Fujitsu Extended Query Table at 0x00=
40<BR>=0AAMCC Taihu Application Flash: CFI does not contain boot bank locat=
ion. Assuming top.<BR>=0Anumber of CFI chips: 1<BR>=0Acfi_cmdset_0002: Disa=
bling erase-suspend-program due to code brokenness.<BR>=0ACreating 3 MTD pa=
rtitions on &quot;AMCC Taihu Application Flash&quot;:<BR>=0A0x00000000-0x00=
300000 : &quot;kernel&quot;<BR>=0A0x00300000-0x01d00000 : &quot;initrd&quot=
;<BR>=0A0x01d00000-0x02000000 : &quot;jffs2&quot;<BR>=0AYenta: CardBus brid=
ge found at 0000:00:07.0 [0000:0000]<BR>=0AYenta: Enabling burst memory rea=
d transactions<BR>=0AYenta: Using CSCINT to route CSC interrupts to PCI<BR>=
=0AYenta: Routing CardBus interrupts to PCI<BR>=0AYenta TI: socket 0000:00:=
07.0, mfunc 0x00001000, devctl 0x66<BR>=0AYenta TI: socket 0000:00:07.0 pro=
bing PCI interrupt failed, trying to fix<BR>=0AYenta TI: socket 0000:00:07.=
0 falling back to parallel PCI interrupts<BR>=0AYenta TI: socket 0000:00:07=
.0 parallel PCI interrupts ok<BR>=0Aeth0: Link is Up<BR>=0Aeth0: Speed: 100=
, Full duplex.<BR>=0AYenta: ISA IRQ mask 0x0000, PCI irq 26<BR>=0ASocket st=
atus: 30000087<BR>=0Apcmcia: parent PCI bridge I/O window: 0x0 - 0xffff<BR>=
=0Apcmcia: parent PCI bridge Memory window: 0x80000000 - 0xbfffffff<BR>=0Az=
ero gadget: Gadget Zero, version: St Patrick's Day 2004<BR>=0Azero gadget: =
using pd12_udc, OUT ep1out-bulk IN ep2in-bulk<BR>=0Apd12_udc: registered ga=
dget driver 'zero'<BR>=0Ai2c /dev entries driver<BR>=0AIBM IIC driver v2.1<=
BR>=0Aibm-iic0: using standard (100 kHz) mode<BR>=0ANET: Registered protoco=
l family 2<BR>=0AIP route cache hash table entries: 2048 (order: 1, 8192 by=
tes)<BR>=0ATCP established hash table entries: 8192 (order: 4, 65536 bytes)=
<BR>=0ATCP bind hash table entries: 8192 (order: 3, 32768 bytes)<BR>=0ATCP:=
 Hash tables configured (established 8192 bind 8192)<BR>=0ATCP reno registe=
red<BR>=0ATCP bic registered<BR>=0ANET: Registered protocol family 1<BR>=0A=
NET: Registered protocol family 17<BR>=0ANET: Registered protocol family 15=
<BR>=0Aeth0: Link is Up<BR>=0Aeth0: Speed: 100, Full duplex.<BR>=0AIP-Confi=
g: Guessing netmask 255.255.255.0<BR>=0AIP-Config: Complete:<BR>=0A&nbsp; &=
nbsp; &nbsp; device=3Deth0, addr=3D192.168.1.62, mask=3D255.255.255.0, gw=
=3D255.255.255.255,<BR>=0A&nbsp; &nbsp;  host=3D192.168.1.62, domain=3D, ni=
s-domain=3D(none),<BR>=0A&nbsp; &nbsp;  bootserver=3D192.168.1.18, rootserv=
er=3D192.168.1.18, rootpath=3D<BR>=0AVFS: Cannot open root device &quot;nfs=
&quot; or unknown-block(0,255)<BR>=0APlease append a correct &quot;root=3D&=
quot; boot option<BR>=0AKernel panic - not syncing: VFS: Unable to mount ro=
ot fs on unknown-block(0,255)<BR>=0A &lt;0&gt;Rebooting in 180 seconds..=0A=
</P>=0A<br><br>=0A<a href=3D"http://adworks.rediff.com/cgi-bin/AdWorks/sigc=
lick.cgi/www.rediff.com/signature-home.htm/1507191490@Middle5?PARTNER=3D3">=
<IMG SRC=3D"http://adworks.rediff.com/cgi-bin/AdWorks/sigimpress.cgi/www.re=
diff.com/signature-home.htm/1963059423@Middle5?OAS_query=3Dnull&PARTNER=3D3=
" BORDER=3D0 VSPACE=3D0 HSPACE=3D0></a>=0A
--Next_1150996726---0-203.199.83.38-18353--
