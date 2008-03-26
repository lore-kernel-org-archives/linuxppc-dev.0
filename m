Return-Path: <stephen.neuendorffer@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Cannot open root device "xsysace/disco0/part3" or 00:00
Date: Wed, 26 Mar 2008 13:32:27 -0700
In-Reply-To: <001101c88f79$17da5ae0$7738f496@JoseLuisAM>
References: <001101c88f79$17da5ae0$7738f496@JoseLuisAM>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: =?iso-8859-1?Q?Jos=E9_Luis_A=F1amuro_Machicao?=
	<jose.annamuro@ESTUDIANTE.UAM.ES>, <Linuxppc-embedded@ozlabs.org>
Message-Id: <20080326203232.32B30181008F@mail146-sin.bigfish.com>
Cc: jose_luis@fun-humanismo-ciencia.es
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Maybe just a typo?  I think it should be 'disc0' not 'disco0'

Steve

> -----Original Message-----
> From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org =
[mailto:linuxppc-embedded-
> bounces+stephen=3Dneuendorffer.name@ozlabs.org] On Behalf Of Jos=E9 =
Luis A=F1amuro Machicao
> Sent: Wednesday, March 26, 2008 12:39 PM
> To: Linuxppc-embedded@ozlabs.org
> Cc: jose_luis@fun-humanismo-ciencia.es
> Subject: Cannot open root device "xsysace/disco0/part3" or 00:00
>=20
> Hi
> I am installing the linux kernel 2.4.26 in the FPGA Virtex II Pro =
following the instruction of
> http://www.cs.washington.edu/research/lis/empart/xup_ppc_linux.shtml
>=20
> I compiled the linux kernel successfully, after that I build the root =
file system using the BusyBox
> 1.1.0 infrastructure. I configured the busybox and the kernel with the =
cross compiler, finally I
> execute the mkrootfs.sh script and obtain the all files of fyle =
system, these files I copied to ext3
> partition of CompacFlash when I probe operati=F3n by the hyperTerminal =
(38400 bps) appears a error that
> say:
>=20
> Serial driver version 5.05c (2001-07-08) with no serial options =
enabled
> ttyS00 at 0xfdfff003 (irq =3D 30) is a 16550A
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> VFS: Cannot open root device "xsysace/disco0/part3" or 00:00
> Please append a correct "root=3D" boot option
> Kernel panic: VFS: Unable to mount root fs on 00:00
>  <0>Rebooting in 180 seconds.
>=20
>=20
> I configured the linux kernel with:
>=20
> Code maturity level options --->
>=20
>             [*] Prompt for development and/or incomplete code/drivers
>=20
> File systems --->
>=20
>     [*] /dev file system support (EXPERIMENTAL)
>=20
>      [*] Automatically mount at boot
>=20
>     [*] Virtual memory file system support (former shm fs)
>=20
>     [*] /proc file system support
>=20
> General Setup --->
>=20
>     [*] Networking support
>=20
>     [*] Sysctl support
>=20
>     [*] System V IPC
>=20
>=20
>=20
> and edit the /etc/fstab
>=20
> tmpfs /dev/shm tmpfs nodev,nosuid,noexec 0 0
>=20
> proc /proc proc defaults 0 0
>=20
> /dev/root / auto defaults,errors=3Dremount-ro 0 0
>=20
>=20
>=20
> =
-------------------------------------------------------------------------=
------------
> __    _        __  __      Jos=E9 Luis A=F1amuro - PhD Student
> \/    V  /\  |\_\ /\_\      Dept. Ingenier=EDa Inform=E1tica
> | |     |  /  \  | |  \/  |   |    Universidad Aut=F3noma de Madrid
> | |     | / /\\ | |   |   |   |    Lab B-209   Tel. +34 615887260
> | |     |/ __ \| | \  /    |    http://www.ii.uam.es/
> `-_-/_/    \_\|_|\/|__|
