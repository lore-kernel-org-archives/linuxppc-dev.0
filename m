Return-Path: <jonb@marel.is>
Received: from marel.marel.is (GW-NAT01-ISLNET.marel.is [213.213.131.1])
	by ozlabs.org (Postfix) with ESMTP id F38112BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Jan 2005 01:49:56 +1100 (EST)
In-Reply-To: <OFE3F13085.168CF615-ON00256F80.003C6775-00256F80.004A9C3D@marel.is>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Message-ID: <OF9A6BA55A.0E01CA7E-ON00256F80.0051303B-00256F80.0051795E@marel.is>
From: "=?iso-8859-1?Q?J=F3n_Benediktsson?=" <jonb@marel.is>
Date: Wed, 5 Jan 2005 14:49:42 +0000
Content-Type: text/plain; charset="ISO-8859-1"
Subject: Re: MPC5200 - problem with CF card
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Whoops, sorry for the HTML.  I forgot to change my e-mail options.
Here comes the plain text:

> Hi=20
>=20
> I am working with a custom MPC5200 board which uses the built-in=20
> ATA/IDE controller for a compact flash card.=20
> The Linux kernel is Denx linux=5F2=5F4=5Fdevel.=20
>=20
> I have been using an old SanDisk 16MB CF card which works fine.=20
> Here is the console output with this card plugged in:=20
>=20
> U-Boot 1.1.2 (Dec  2 2004 - 16:01:06)=20
>=20
> CPU:   MPC5200 v1.2 at 396 MHz=20
>        Bus 132 MHz, IPB 66 MHz, PCI 33 MHz=20
> Board: Marel NS4=20
> I2C:   85 kHz, ready=20
> DRAM:  128 MB=20
> FLASH: 16 MB=20
> In:    serial=20
> Out:   serial=20
> Err:   serial=20
> Net:   FEC ETHERNET=20
> IDE:   Bus 0: OK=20
>   Device 0: Model: SanDisk SDCFB-16 Firm: vde 1.10 Ser#: 24349220714=20
>             Type: Removable Hard Disk=20
>             Capacity: 15.3 MB =3D 0.0 GB (31360 x 512)=20
>=20
> Type "run flash=5Fnfs" to mount root filesystem over NFS=20
>=20
> Hit any key to stop autoboot:  0=20
> Using FEC ETHERNET device=20
> TFTP from server 10.100.1.30; our IP address is 10.100.50.68=20
> Filename 'mpc5200/uImage'.=20
> Load address: 0x200000=20
> Loading:=20
#################################################################=20
> #################################################################=20
>          #############################=20
> done=20
> Bytes transferred =3D 810417 (c5db1 hex)=20
> ## Booting image at 00200000 ...=20
>    Image Name:   Linux-2.4.25=20
>    Created:      2004-12-03  11:35:18 UTC=20
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)=20
>    Data Size:    810353 Bytes =3D 791.4 kB=20
>    Load Address: 00000000=20
>    Entry Point:  00000000=20
>    Verifying Checksum ... OK=20
>    Uncompressing Kernel Image ... OK=20
> Memory BAT mapping: BAT2=3D128Mb, BAT3=3D0Mb, residual: 0Mb=20
> Linux version 2.4.25 (jonb@tux.marel.is) (gcc version 3.2.2 20030217
> (Yellow Dog=20
>  Linux 3.0 3.2.2-2a=5F1)) #4 F=F6s Des 3 11:34:35 UTC 2004=20
> On node 0 totalpages: 32768=20
> zone(0): 32768 pages.=20
> zone(1): 0 pages.=20
> zone(2): 0 pages.=20
> Kernel command line: root=3D/dev/nfs rw nfsroot=3D10.100.1.30:
> /opt/eldk/ppc=5F82xx ip=3D=20
> 10.100.50.68:10.100.1.30:10.100.254.254:255.255.0.0:ns4b:eth0:off=20
panic=3D1=20
> Calibrating delay loop... 263.78 BogoMIPS=20
> Memory: 127080k available (1396k kernel code, 464k data, 76k init, 0k=20
highmem)
> Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)=20
> Inode cache hash table entries: 8192 (order: 4, 65536 bytes)=20
> Mount cache hash table entries: 512 (order: 0, 4096 bytes)=20
> Buffer cache hash table entries: 8192 (order: 3, 32768 bytes)=20
> Page-cache hash table entries: 32768 (order: 5, 131072 bytes)=20
> POSIX conformance testing by UNIFIX=20
> PCI: Probing PCI hardware=20
> Linux NET4.0 for Linux 2.4=20
> Based upon Swansea University Computer Society NET3.039=20
> Initializing RT netlink socket=20
> Starting kswapd=20
> Journalled Block Device driver loaded=20
> JFFS2 version 2.2. (C) 2001-2003 Red Hat, Inc.=20
> i2c-core.o: i2c core module version 2.6.1 (20010830)=20
> i2c-dev.o: i2c /dev entries driver module version 2.6.1 (20010830)=20
> pty: 256 Unix98 ptys configured=20
> ttyS0 on PSC1=20
> ttyS1 on PSC2=20
> ttyS2 on PSC3=20
> PCF8563 Real-Time Clock Driver $Revision: 1.3 $ wd@denx.de=20
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize=20
> loop: loaded (max 8 devices)=20
> Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4=20
> ide: Assuming 33MHz system bus speed for PIO modes; override with=20
idebus=3Dxx=20
> Port Config is: 0x91050404=20
> ipb=3D66MHz, set clock period to 15=20
> GPIO config: 91050404=20
> ATA invalid: 00800000=20
> ATA hostcnf: 03000000=20
> ATA pio1   : 100a0a00=20
> ATA pio2   : 02040600=20
> XLB Arb cnf: 80002006=20
> mpc5xxx=5Fide: Setting up IDE interface ide0...=20
> Probing IDE interface ide0...=20
> hda: SanDisk SDCFB-16, CFA DISK drive=20
> ide0 at 0xf0003a60-0xf0003a67,0xf0003a5c on irq 45=20
> hda: attached ide-disk driver.=20
> hda: 31360 sectors (16 MB) w/1KiB Cache, CHS=3D490/2/32=20
> Partition check:=20
>  hda: hda1=20
> NS4 Bank 0: Found 1 x16 devices at 0x0 in 8-bit mode=20
>  Amd/Fujitsu Extended Query Table at 0x0040=20
> NS4 Bank 0: CFI does not contain boot bank location. Assuming top.=20
> number of CFI chips: 1=20
> cfi=5Fcmdset=5F0002: Disabling erase-suspend-program due to code brokenne=
ss.=20

> NS4 flash bank 0: Using static image partition definition=20
> Creating 5 MTD partitions on "NS4 Bank 0":=20
> 0x00000000-0x00100000 : "U-Boot"=20
> 0x00100000-0x00200000 : "kernel"=20
> 0x00200000-0x00500000 : "initrd"=20
> 0x00500000-0x00b00000 : "jffs2"=20
> 0x00b00000-0x01000000 : "Spare"=20
>=20
> --- cut out insignificant rest of console output  ---=20
>=20
>=20
> Now I have a brand new SanDisk 1GB Industrial Grade card that is=20
> giving me a problem.  Here is what happens=20
> with exactly the same u-boot and kernel versions, just this new CF=20
> card plugged in instead of the older one.=20
>=20
> U-Boot 1.1.2 (Dec  2 2004 - 16:01:06)=20
>=20
> CPU:   MPC5200 v1.2 at 396 MHz=20
>        Bus 132 MHz, IPB 66 MHz, PCI 33 MHz=20
> Board: Marel NS4=20
> I2C:   85 kHz, ready=20
> DRAM:  128 MB=20
> FLASH: 16 MB=20
> In:    serial=20
> Out:   serial=20
> Err:   serial=20
> Net:   FEC ETHERNET=20
> IDE:   Bus 0: OK=20
>   Device 0: Model: SanDisk SDCFBI-1024 Firm: HDX 2.15 Ser#:=20
111515L1004P3254=20
>             Type: Hard Disk=20
>             Capacity: 977.4 MB =3D 0.9 GB (2001888 x 512)=20
>=20
> Type "run flash=5Fnfs" to mount root filesystem over NFS=20
>=20
> Hit any key to stop autoboot:  0=20
> Using FEC ETHERNET device=20
> TFTP from server 10.100.1.30; our IP address is 10.100.50.68=20
> Filename 'mpc5200/uImage'.=20
> Load address: 0x200000=20
> Loading:=20
#################################################################=20
> #################################################################=20
>          #############################=20
> done=20
> Bytes transferred =3D 810417 (c5db1 hex)=20
> ## Booting image at 00200000 ...=20
>    Image Name:   Linux-2.4.25=20
>    Created:      2004-12-03  11:35:18 UTC=20
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)=20
>    Data Size:    810353 Bytes =3D 791.4 kB=20
>    Load Address: 00000000=20
>    Entry Point:  00000000=20
>    Verifying Checksum ... OK=20
>    Uncompressing Kernel Image ... OK=20
> Memory BAT mapping: BAT2=3D128Mb, BAT3=3D0Mb, residual: 0Mb=20
> Linux version 2.4.25 (jonb@tux.marel.is) (gcc version 3.2.2 20030217
> (Yellow Dog=20
>  Linux 3.0 3.2.2-2a=5F1)) #4 F=F6s Des 3 11:34:35 UTC 2004=20
> On node 0 totalpages: 32768=20
> zone(0): 32768 pages.=20
> zone(1): 0 pages.=20
> zone(2): 0 pages.=20
> Kernel command line: root=3D/dev/nfs rw nfsroot=3D10.100.1.30:
> /opt/eldk/ppc=5F82xx ip=3D=20
> 10.100.50.68:10.100.1.30:10.100.254.254:255.255.0.0:ns4b:eth0:off=20
panic=3D1=20
> Calibrating delay loop... 263.78 BogoMIPS=20
> Memory: 127080k available (1396k kernel code, 464k data, 76k init, 0k=20
highmem)
> Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)=20
> Inode cache hash table entries: 8192 (order: 4, 65536 bytes)=20
> Mount cache hash table entries: 512 (order: 0, 4096 bytes)=20
> Buffer cache hash table entries: 8192 (order: 3, 32768 bytes)=20
> Page-cache hash table entries: 32768 (order: 5, 131072 bytes)=20
> POSIX conformance testing by UNIFIX=20
> PCI: Probing PCI hardware=20
> Linux NET4.0 for Linux 2.4=20
> Based upon Swansea University Computer Society NET3.039=20
> Initializing RT netlink socket=20
> Starting kswapd=20
> Journalled Block Device driver loaded=20
> JFFS2 version 2.2. (C) 2001-2003 Red Hat, Inc.=20
> i2c-core.o: i2c core module version 2.6.1 (20010830)=20
> i2c-dev.o: i2c /dev entries driver module version 2.6.1 (20010830)=20
> pty: 256 Unix98 ptys configured=20
> ttyS0 on PSC1=20
> ttyS1 on PSC2=20
> ttyS2 on PSC3=20
> PCF8563 Real-Time Clock Driver $Revision: 1.3 $ wd@denx.de=20
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize=20
> loop: loaded (max 8 devices)=20
> Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4=20
> ide: Assuming 33MHz system bus speed for PIO modes; override with=20
idebus=3Dxx=20
> Port Config is: 0x91050404=20
> ipb=3D66MHz, set clock period to 15=20
> GPIO config: 91050404=20
> ATA invalid: 00800000=20
> ATA hostcnf: 03000000=20
> ATA pio1   : 100a0a00=20
> ATA pio2   : 02040600=20
> XLB Arb cnf: 80002006=20
> mpc5xxx=5Fide: Setting up IDE interface ide0...=20
> Probing IDE interface ide0...=20
> hda: SanDisk SDCFBI-1024, ATA DISK drive=20
> hdb: probing with STATUS(0x00) instead of ALTSTATUS(0x7f)=20
> ide0: unexpected interrupt, status=3D0x00, count=3D1=20
>=20
> Here the boot process fails and the kernel hangs without further=20
> messages to the console.=20
>=20
> Actually I did get one bootup with this 1 GB SanDisk Industrial=20
> Grade card that succeeded  without this happening, where the card seemed =

to be
> properly identiified, but I have not been able to repeat that.=20
>=20
> Does anyone have a clue what might be causing this ?=20
>=20
>=20
> Thanks,=20
> Jon Benediktsson=20
> Marel hf.=20
