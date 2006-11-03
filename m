Return-Path: <christophe.alayrac@cresitt.com>
Received: from postfix2-g20.free.fr (postfix2-g20.free.fr [212.27.60.43])
	by ozlabs.org (Postfix) with ESMTP id 0492A67D22
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Nov 2006 00:39:40 +1100 (EST)
Received: from smtp2-g19.free.fr (smtp2-g19.free.fr [212.27.42.28])
	by postfix2-g20.free.fr (Postfix) with ESMTP id 38C673164A0
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Nov 2006 14:39:39 +0100 (CET)
From: "alayrac" <christophe.alayrac@cresitt.com>
To: "'robert corley'" <rdcorle@yahoo.com>,
	"'linux linuxppc-embedded'" <linuxppc-embedded@ozlabs.org>
Subject: RE : minor progress with plb_temac v3.00a, EDK 8.2, & 2.6.18.1
Date: Fri, 3 Nov 2006 14:39:23 +0100
Message-ID: <001f01c6ff4d$797b82a0$c900a8c0@CRESITTLAB>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20061102222041.16498.qmail@web56312.mail.re3.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Robert,

Thanks for your contribution.
I would like to know where did you get the kernel source 2.6.18.1?

I've tried from kernel.org, but then temac drivers is not included.
I've then download the temac patch from mvista at following address :
http://source.mvista.com/~ank/paulus-powerpc/20060309/temac.paulus-power
pc.20060309.tgz

When I try to pacth the kernel with following command :
	patch -i ppc32_xilinx_edk_temac.patch
the process ask me the file to pacth.

I've try to get the kernel source code from mvista with cg-clone
commande from=20
cg-clone git://source.mvista.com/git/linux-xilinx-26.git=20

and patch command give same message.

Any track to properly applying patch?

Kinds regards

Chris

CRESITT INDUSTRIE
12 Rue de Blois, BP6744
45067 ORLEANS Cedex 2
Tel : 02.38.49.45.59
Fax :02.38.49.45.55
Email : christophe.alayrac@cresitt.com=20
Web : http://www.cresitt.com


<----> -----Message d'origine-----
<----> De=A0: linuxppc-embedded-
<----> bounces+christophe.alayrac=3Dcresitt.com@ozlabs.org
[mailto:linuxppc-
<----> embedded-bounces+christophe.alayrac=3Dcresitt.com@ozlabs.org] De =
la
<----> part de robert corley
<----> Envoy=E9=A0: jeudi 2 novembre 2006 23:21
<----> =C0=A0: linux linuxppc-embedded
<----> Objet=A0: minor progress with plb_temac v3.00a, EDK 8.2, & =
2.6.18.1
<---->=20
<----> For those interested, I have acheived some measure of success
with
<----> the plb_temac driver.
<---->=20
<----> I have attached a txt file of what I had to do to get it working
<----> under 2.6.18.1
<---->=20
<----> I am using the plb_temac in DMA mode 3
<---->=20
<----> Below you will see the boot dump.
<---->=20
<----> For those able to help, can anyone provide insight as to the
failure
<----> of setting PHY link speed?
<---->=20
<----> -cy
<---->=20
<---->=20
<---->=20
<----> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
<---->
---------------------------------------------------------------------
<----> -
<----> 2.6.18.1 kernel with all patches
<----> 11/02/2006    15:30
<----> plb_temac v3.00a
<----> hard_temac v3.00b
<---->=20
<---->=20
<----> loaded at:     00400000 009F1138
<----> board data at: 009EF120 009EF138
<----> relocated to:  004040B4 004040CC
<----> zimage at:     00404EC7 0057C1F2
<----> initrd at:     0057D000 009EE6FE
<----> avail ram:     009F2000 04000000
<---->=20
<---->=20
<----> Linux/PPC load: console=3DttyUL0 single
<----> ip=3D192.168.1.100:192.168.1.144:192.168.1.1:255.255.255.0:nab::
<----> ramdisk_size=3D4660000 root=3D/dev/ram rw
<---->=20
<----> Uncompressing Linux...done.
<---->=20
<----> Now booting the kernel
<---->=20
<----> [    0.000000] Linux version 2.6.18.1 (rdcorle@athena) (gcc
version
<----> 3.4.2) #2 Thu Nov 2 21:56:32 UTC 2006
<----> [    0.000000] Xilinx ML403 Reference System (Virtex-4 FX)
<----> [    0.000000] Built 1 zonelists.  Total pages: 16384
<----> [    0.000000] Kernel command line: console=3DttyUL0 single
<----> ip=3D192.168.1.100:192.168.1.144:192.168.1.1:255.255.255.0:nab::
<----> ramdisk_size=3D4660000 root=3D/dev/ram rw
<----> [    0.000000] Xilinx INTC #0 at 0xD1000FC0 mapped to 0xFDFFFFC0
<----> [    0.000000] PID hash table entries: 512 (order: 9, 2048 bytes)
<----> [    0.000158] Console: colour dummy device 80x25
<----> [    0.000568] Dentry cache hash table entries: 8192 (order: 3,
32768
<----> bytes)
<----> [    0.001277] Inode-cache hash table entries: 4096 (order: 2,
16384
<----> bytes)
<----> [    0.012895] Memory: 57060k available (2548k kernel code, 640k
<----> data, 96k init, 0k highmem)
<----> [    0.104378] Mount-cache hash table entries: 512
<----> [    0.106721] checking if image is initramfs...it isn't (no cpio
<----> magic); looks like an initrd
<----> [    2.414242] Freeing initrd memory: 4549k freed
<----> [    2.418712] NET: Registered protocol family 16
<----> [    2.427313] NET: Registered protocol family 2
<----> [    2.464244] IP route cache hash table entries: 512 (order: -1,
<----> 2048 bytes)
<----> [    2.465037] TCP established hash table entries: 2048 (order:
1,
<----> 8192 bytes)
<----> [    2.465205] TCP bind hash table entries: 1024 (order: 0, 4096
<----> bytes)
<----> [    2.465296] TCP: Hash tables configured (established 2048 bind
<----> 1024)
<----> [    2.465324] TCP reno registered
<----> [    2.474633] NTFS driver 2.1.27 [Flags: R/O].
<----> [    2.475046] JFS: nTxBlock =3D 481, nTxLock =3D 3854
<----> [    2.477623] SGI XFS with no debug enabled
<----> [    2.479001] io scheduler noop registered
<----> [    2.479109] io scheduler anticipatory registered
<----> [    2.479197] io scheduler deadline registered
<----> [    2.479402] io scheduler cfq registered (default)
<----> [    2.517627] uartlite.0: ttyUL0 at MMIO 0xa0000000 (irq =3D 1) =
is
a
<----> uartlite
<----> [    2.691029] RAMDISK driver initialized: 16 RAM disks of
4660000K
<----> size 1024 blocksize
<----> [    2.703933] loop: loaded (max 8 devices)
<----> [    2.709698] XTemac: using sgDMA mode.
<----> [    2.713493] XTemac: using TxDRE mode
<----> [    2.717081] XTemac: using RxDRE mode
<----> [    2.720678] XTemac: buffer descriptor size: 32768 (0x8000)
<----> [    2.726622] XTemac: (buffer_descriptor_init) phy: 0x580000,
virt:
<----> 0xff100000, size: 0x8000
<----> [    2.741073] eth0: Xilinx TEMAC #0 at 0x60000000 mapped to
<----> 0xC5050000, irq=3D0
<----> [    2.748080] eth0: XTemac id 1.0f, block id 5, type 8
<----> [    2.753636] mice: PS/2 mouse device common for all mice
<----> [    2.759529] TCP bic registered
<----> [    3.264317] eth0: XTemac: Options: 0xb8f2
<----> [   15.227339] eth0: XTemac: Not able to set the speed to 1000
<----> (status: 0x148)
<----> [   25.200394] eth0: XTemac: Not able to set the speed to 100
<----> (status: 0x148)
<----> [   35.173357] eth0: XTemac: Not able to set the speed to 10
(status:
<----> 0x148)
<----> [   35.180122] eth0: XTemac: could not negotiate speed
<----> [   35.187740] eth0: XTemac: Send Threshold =3D 16, Receive
Threshold =3D
<----> 2
<----> [   35.194116] eth0: XTemac: Send Wait bound =3D 1, Receive Wait
bound
<----> =3D 1
<----> [   36.205399] IP-Config: Complete:
<----> [   36.208459]       device=3Deth0, addr=3D192.168.1.100,
<----> mask=3D255.255.255.0, gw=3D192.168.1.1,
<----> [   36.216339]      host=3Dnab, domain=3D, nis-domain=3D(none),
<----> [   36.221487]      bootserver=3D192.168.1.144,
<----> rootserver=3D192.168.1.144, rootpath=3D
<----> [   36.229826] RAMDISK: Compressed image found at block 0
<----> [   37.200498] eth0: XTemac: PHY Link carrier lost.
<----> [   39.097820] VFS: Mounted root (ext2 filesystem).
<----> [   39.102751] Freeing unused kernel memory: 96k init
<----> [   39.108356] ulite_startup: UART status =3D 0x0014
<----> [   39.124619] ulite_startup: UART status =3D 0x0014
<----> [   39.134313] ulite_startup: UART status =3D 0x0014
<---->=20
<---->=20
<----> BusyBox v1.00-pre9 (2004.04.18-19:53+0000) Built-in shell (ash)
<----> Enter 'help' for a list of built-in commands.
<---->=20
<----> -sh: can't access tty; job control turned off
<---->=20
