Return-Path: <stonepine@126.com>
Received: from m15-9.126.com (m15-9.126.com [220.181.15.9])
	by ozlabs.org (Postfix) with SMTP id 86C04679A6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Sep 2006 14:19:54 +1000 (EST)
MIME-Version: 1.0
Message-ID: <45077EA4.000010.14180@bj126app9.126.com>
Date: Wed, 13 Sep 2006 11:44:36 +0800 (CST)
From: "Stephen Yee" <stonepine@126.com>
To: "kylongmu" <mqy@263.net.cn>
Subject: Re: 11-16-05 2.6.14 on AMCC Yosemite boar d(PCI-IDE card boot error)
Content-Type: Multipart/mixed;
	boundary="Boundary-=_zxhekmnqpknQOYnWwEvOyPNJBRak"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--Boundary-=_zxhekmnqpknQOYnWwEvOyPNJBRak
Content-Type: Multipart/Alternative; boundary="Boundary-1=_zxhekmnqpknQOYnWwEvOyPNJBRa"

--Boundary-1=_zxhekmnqpknQOYnWwEvOyPNJBRa
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Hi Mr. KylongMu & all,

Have you solved the issues about PCI-IDE card?

  I also have tested two PCI-IDE cards and a PCI-SATA card with
2.6.13(packaged in AMCC CD) and 2.6.14(ELDK ) kernel on Yosemite board,
this issues are the same with Mr. KylongMu. the PCI-SATA is work fine.
but the two PCI-IDE  cards, ITE8212 and PDC20269 failed, the panic
message was  similar with Mr. KylongMu. the attached file is the
ITE8212 module driver OOPS log.

=20

would you please give me some advice about it?

Thanks and Best regards,

stephen



KylongMu wrote:



> Dear Denk,

>

> Thanks for your help; it makes my Yosemite run up! I'm try to add a=20

> PCI-IDE

>

> Card on it. I test my Promise-PDC20268 card and AEC6280 (ATP865-B chip=20

> type) card,

>

> Both of them all failed with same error, the boot message included in=20

> the attachment.

>

> The kernel configure is based on the Yosemite_defconfig, add with:

>

> Device Drivers-->

>

> ATA/ATAPI/MFM/RLL support-->

>

> [*]AEC62XX Chipset support

>

> [*]PROMISE PDC202{68|69|70|71|75|76|77} SUPPORT

>

> Both of the PCI-IDE cards can work with X86PC+FEDORA4 configure, I=20

> don=A1=AFt know

>

> What cause them fail on Yosemite with final 2.6.14 kernel.

>

> About my 2.6.14 tree, I type with =A1=B0cg-log =A8Cs=A1=B1 command it s=
hows:

>

> 99a21389c2b0e55f30b6cf6550cb492b87dbaa3b Heiko Schocher 2005-11-11=20

> 12:47 [PATCH] ppc32: fix Kernel Panic for PM82x Board with gcc-4.0.

>

> ff1df84b3c3154ffdb646941e1c70d17554e3042 Wolfgang Denk 2005-11-10=20

> 00:41 Merge with /home/wd/git/linux-2.6/stefan_roese

>

> It only shows 2.6.14 on the kernel message, I don=A1=AFt know why it=20

> doesn=A1=AFt show the message as you told.

>

> But it can work, and fixed the bugs on Yosemite.

>

> Cordially,

>

> Kylong Mu

>

>------------------------------------------------------------------------

>

>U-Boot 1.1.4 (Nov 11 2005 - 19:35:30)

>

>AMCC PowerPC 440EP Rev. B

>Board: Yosemite - AMCC PPC440EP Evaluation Board

>        VCO: 1066 MHz

>        CPU: 533 MHz

>        PLB: 133 MHz

>        OPB: 66 MHz

>        EPB: 66 MHz

>        PCI: 66 MHz

>I2C:   ready

>DRAM:  256 MB

>FLASH: 64 MB

>PCI:   Bus Dev VenId DevId Class Int

>        00  0c  1191  0009  0180  00

>In:    serial

>Out:   serial

>Err:   serial

>Net:   ppc_4xx_eth0, ppc_4xx_eth1

>

>Type "run flash_nfs" to mount root filesystem over NFS

>

>Hit any key to stop autoboot:  0

>=3D> tftp 400000 uImage

>ENET Speed is 100 Mbps - FULL duplex connection

>Using ppc_4xx_eth0 device

>TFTP from server 192.168.0.93; our IP address is 192.168.0.66

>Filename 'uImage'.

>Load address: 0x400000

>Loading: ###############################################################=
##

>         ###############################################################=
##

>         ###############################################################=
##

>         ###########################################

>done

>Bytes transferred =3D 1217393 (129371 hex)

>=3D> bootram

>Unknown command 'bootram' - try 'help'

>=3D> run bootram

>## Booting image at 00400000 ...

>   Image Name:   Linux-2.6.14

>   Image Type:   PowerPC Linux Kernel Image (gzip compressed)

>   Data Size:    1217329 Bytes =3D  1.2 MB

>   Load Address: 00000000

>   Entry Point:  00000000

>   Verifying Checksum ... OK

>   Uncompressing Kernel Image ... OK

>## Loading RAMDisk Image at fed40000 ...

>   Image Name:   Yosemite Ramdisk

>   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)

>   Data Size:    17770706 Bytes =3D 16.9 MB

>   Load Address: 00000000

>   Entry Point:  00000000

>   Verifying Checksum ... OK

>   Loading Ramdisk to 0ee47000, end 0ff398d2 ... OK

>Linux version 2.6.14 (root@dxp) (gcc version 4.0.0) #7 Sun Nov 13 21:59:=
01 CST 2005

>AMCC PowerPC 440EP Yosemite Platform

>Built 1 zonelists

>Kernel command line: ramdisk_size=3D49152 root=3D/dev/ram rw
ip=3D192.168.0.66:192.168.0.93::255.255.255.0:yosemite:eth0:off panic=3D1
console=3DttyS0,115200

>PID hash table entries: 2048 (order: 11, 32768 bytes)

>Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)

>Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)

>Memory: 239616k available (1860k kernel code, 596k data, 140k init, 0k h=
ighmem)

>Mount-cache hash table entries: 512

>checking if image is initramfs...it isn't (no cpio magic); looks like an=
 initrd

>softlockup thread 0 started up.

>Freeing initrd memory: 17354k freed

>NET: Registered protocol family 16

>PCI: Probing PCI hardware

>usbcore: registered new driver usbfs

>usbcore: registered new driver hub

>SCSI subsystem initialized

>io scheduler noop registered

>io scheduler anticipatory registered

>io scheduler deadline registered

>io scheduler cfq registered

>usbmon: debugfs is not available

>ppc-soc-ohci ppc-soc-ohci.0: USB Host Controller

>ppc-soc-ohci ppc-soc-ohci.0: new USB bus registered, assigned bus number=
 1

>ppc-soc-ohci ppc-soc-ohci.0: irq 40, io mem 0xef601000

>usb usb1: Product: USB Host Controller

>usb usb1: Manufacturer: Linux 2.6.14 ohci_hcd

>usb usb1: SerialNumber: PPC-SOC USB

>hub 1-0:1.0: USB hub found

>hub 1-0:1.0: 2 ports detected

>Initializing USB Mass Storage driver...

>usbcore: registered new driver usb-storage

>USB Mass Storage support registered.

>pegasus: v0.6.12 (2005/01/13), Pegasus/Pegasus II USB Ethernet driver

>usbcore: registered new driver pegasus

>Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled

>serial8250: ttyS0 at MMIO 0x0 (irq =3D 0) is a 16550A

>serial8250: ttyS1 at MMIO 0x0 (irq =3D 1) is a 16550A

>RAMDISK driver initialized: 16 RAM disks of 49152K size 1024 blocksize

>PPC 4xx OCP EMAC driver, version 3.53

>mal0: initialized, 4 TX channels, 2 RX channels

>zmii0: bridge in RMII mode

>eth0: emac0, MAC 00:10:ec:00:87:40

>eth0: found Generic MII PHY (0x01)

>eth1: emac1, MAC 00:10:ec:00:87:47

>eth1: found Generic MII PHY (0x03)

>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2

>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=
=3Dxx

>Data machine check in kernel mode.

>PLB0: BEAR=3D0x0000000000000000 ACR=3D  0x00000000 BESR=3D 0xfffff7ff

>POB0: BEAR=3D0xc27e3194ffffffff BESR0=3D0x00000000 BESR1=3D0x00000000

>OPB0: BEAR=3D0x0000000000000151 BSTAT=3D0x00000000

>Oops: machine check, sig: 7 [#1]

>NIP: 00000000 LR: C0263628 SP: CFF41F40 REGS: c0271f50 TRAP: 0202    Not=
 tainted

>MSR: 00000000 EE: 0 PR: 0 FP: 0 ME: 0 IR/DR: 00

>TASK =3D c04f8b10[1] 'swapper' THREAD: cff40000

>Last syscall: 120

>GPR00: FDFFEF02 CFF41F40 C04F8B10 C04FC000 C026C6B4 C04FC000 00000009 CF=
F41EF4

>GPR08: C04F9F70 00000000 00004000 C0270000 24254322 61000408 0FFB6800 00=
000001

>GPR16: 00800000 0FFCEAD4 FFFFFFFF 00000000 007FFF00 0FFB1210 00000003 00=
000002

>GPR24: C01D0000 C01D0000 C0270000 C01D0000 C0270000 C0223E10 C026C6B4 C0=
4FC000

>NIP [00000000] 0x0

>LR [c0263628] aec62xx_init_one+0x38/0x48

>Call trace:

> [c0263628] aec62xx_init_one+0x38/0x48

> [c02649b8] ide_scan_pcidev+0x68/0xb0

> [c0264a34] ide_scan_pcibus+0x34/0xe8

> [c026492c] ide_init+0x68/0x8c

> [c00013ac] init+0xb4/0x254

> [c00046c0] kernel_thread+0x48/0x64

>Data machine check in kernel mode.

>PLB0: BEAR=3D0x0000000000000000 ACR=3D  0x00000000 BESR=3D 0xfffff7ff

>POB0: BEAR=3D0xc27e3194ffffffff BESR0=3D0x00000000 BESR1=3D0x00000000

>OPB0: BEAR=3D0x0000000000000151 BSTAT=3D0x00000000

>Oops: machine check, sig: 7 [#2]

>NIP: 00000000 LR: C000235C SP: C0271E70 REGS: c0271f50 TRAP: 0202    Not=
 tainted

>MSR: 00000000 EE: 0 PR: 0 FP: 0 ME: 0 IR/DR: 00

>TASK =3D c04f8b10[1] 'swapper' THREAD: cff40000

>Last syscall: 120

>GPR00: 08000000 C0271E70 C04F8B10 C0271E80 00001568 FFFFFFFF C0270000 00=
004000

>GPR08: C0270000 C000235C 00021002 C00039E8 C04F8CD8 61000408 0FFB6800 00=
000001

>GPR16: 00800000 0FFCEAD4 FFFFFFFF 00000000 007FFF00 0FFB1210 00000003 00=
000002

>GPR24: C01D0000 C01D0000 C0270000 C01D0000 C0270000 C0223E10 00000007 C0=
271F50

>NIP [00000000] 0x0

>LR [c000235c] ret_from_except+0x0/0x18

>Kernel panic - not syncing: Attempted to kill init!

> <0>Rebooting in 1 seconds..

>

> =20

>

>------------------------------------------------------------------------

>

>_______________________________________________

>Linuxppc-embedded mailing list

>Linuxppc-embedded@ozlabs.org

>https://ozlabs.org/mailman/listinfo/linuxppc-embedded

>







   =20
--Boundary-1=_zxhekmnqpknQOYnWwEvOyPNJBRa
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Hi Mr. KylongMu &amp; all,<br>
Have you solved the issues about PCI-IDE card?<br>
&nbsp; I also have tested two PCI-IDE cards and a PCI-SATA card with
2.6.13(packaged in AMCC CD) and 2.6.14(ELDK ) kernel on Yosemite board,
this issues are the same with Mr. KylongMu. the PCI-SATA is work fine.
but the two PCI-IDE&nbsp; cards, ITE8212 and PDC20269 failed, the panic
message was&nbsp; similar with Mr. KylongMu. the attached file is the
ITE8212 module driver OOPS log.<br>
&nbsp;<br>
would you please give me some advice about it?<br>
Thanks and Best regards,<br>
stephen<br>
<br>
KylongMu wrote:<br>
<br>
&gt; Dear Denk,<br>
&gt;<br>
&gt; Thanks for your help; it makes my Yosemite run up! I'm try to add a =
<br>
&gt; PCI-IDE<br>
&gt;<br>
&gt; Card on it. I test my Promise-PDC20268 card and AEC6280 (ATP865-B ch=
ip <br>
&gt; type) card,<br>
&gt;<br>
&gt; Both of them all failed with same error, the boot message included i=
n <br>
&gt; the attachment.<br>
&gt;<br>
&gt; The kernel configure is based on the Yosemite_defconfig, add with:<b=
r>
&gt;<br>
&gt; Device Drivers--&gt;<br>
&gt;<br>
&gt; ATA/ATAPI/MFM/RLL support--&gt;<br>
&gt;<br>
&gt; [*]AEC62XX Chipset support<br>
&gt;<br>
&gt; [*]PROMISE PDC202{68|69|70|71|75|76|77} SUPPORT<br>
&gt;<br>
&gt; Both of the PCI-IDE cards can work with X86PC+FEDORA4 configure, I <=
br>
&gt; don=A1=AFt know<br>
&gt;<br>
&gt; What cause them fail on Yosemite with final 2.6.14 kernel.<br>
&gt;<br>
&gt; About my 2.6.14 tree, I type with =A1=B0cg-log =A8Cs=A1=B1 command i=
t shows:<br>
&gt;<br>
&gt; 99a21389c2b0e55f30b6cf6550cb492b87dbaa3b Heiko Schocher 2005-11-11 <=
br>
&gt; 12:47 [PATCH] ppc32: fix Kernel Panic for PM82x Board with gcc-4.0.<=
br>
&gt;<br>
&gt; ff1df84b3c3154ffdb646941e1c70d17554e3042 Wolfgang Denk 2005-11-10 <b=
r>
&gt; 00:41 Merge with /home/wd/git/linux-2.6/stefan_roese<br>
&gt;<br>
&gt; It only shows 2.6.14 on the kernel message, I don=A1=AFt know why it=
 <br>
&gt; doesn=A1=AFt show the message as you told.<br>
&gt;<br>
&gt; But it can work, and fixed the bugs on Yosemite.<br>
&gt;<br>
&gt; Cordially,<br>
&gt;<br>
&gt; Kylong Mu<br>
&gt;<br>
&gt;---------------------------------------------------------------------=
---<br>
&gt;<br>
&gt;U-Boot 1.1.4 (Nov 11 2005 - 19:35:30)<br>
&gt;<br>
&gt;AMCC PowerPC 440EP Rev. B<br>
&gt;Board: Yosemite - AMCC PPC440EP Evaluation Board<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VCO: 1066 MHz<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPU: 533 MHz<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PLB: 133 MHz<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OPB: 66 MHz<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; EPB: 66 MHz<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PCI: 66 MHz<br>
&gt;I2C:&nbsp;&nbsp; ready<br>
&gt;DRAM:&nbsp; 256 MB<br>
&gt;FLASH: 64 MB<br>
&gt;PCI:&nbsp;&nbsp; Bus Dev VenId DevId Class Int<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00&nbsp; 0c&nbsp; 1191&nbs=
p; 0009&nbsp; 0180&nbsp; 00<br>
&gt;In:&nbsp;&nbsp;&nbsp; serial<br>
&gt;Out:&nbsp;&nbsp; serial<br>
&gt;Err:&nbsp;&nbsp; serial<br>
&gt;Net:&nbsp;&nbsp; ppc_4xx_eth0, ppc_4xx_eth1<br>
&gt;<br>
&gt;Type "run flash_nfs" to mount root filesystem over NFS<br>
&gt;<br>
&gt;Hit any key to stop autoboot:&nbsp; 0<br>
&gt;=3D&gt; tftp 400000 uImage<br>
&gt;ENET Speed is 100 Mbps - FULL duplex connection<br>
&gt;Using ppc_4xx_eth0 device<br>
&gt;TFTP from server 192.168.0.93; our IP address is 192.168.0.66<br>
&gt;Filename 'uImage'.<br>
&gt;Load address: 0x400000<br>
&gt;Loading: ############################################################=
#####<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ####################=
#############################################<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ####################=
#############################################<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ####################=
#######################<br>
&gt;done<br>
&gt;Bytes transferred =3D 1217393 (129371 hex)<br>
&gt;=3D&gt; bootram<br>
&gt;Unknown command 'bootram' - try 'help'<br>
&gt;=3D&gt; run bootram<br>
&gt;## Booting image at 00400000 ...<br>
&gt;&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.14<br>
&gt;&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip=
 compressed)<br>
&gt;&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1217329 Bytes =3D&nbsp; 1.2=
 MB<br>
&gt;&nbsp;&nbsp; Load Address: 00000000<br>
&gt;&nbsp;&nbsp; Entry Point:&nbsp; 00000000<br>
&gt;&nbsp;&nbsp; Verifying Checksum ... OK<br>
&gt;&nbsp;&nbsp; Uncompressing Kernel Image ... OK<br>
&gt;## Loading RAMDisk Image at fed40000 ...<br>
&gt;&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Yosemite Ramdisk<br>
&gt;&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux RAMDisk Image (gzi=
p compressed)<br>
&gt;&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 17770706 Bytes =3D 16.9 MB<=
br>
&gt;&nbsp;&nbsp; Load Address: 00000000<br>
&gt;&nbsp;&nbsp; Entry Point:&nbsp; 00000000<br>
&gt;&nbsp;&nbsp; Verifying Checksum ... OK<br>
&gt;&nbsp;&nbsp; Loading Ramdisk to 0ee47000, end 0ff398d2 ... OK<br>
&gt;Linux version 2.6.14 (root@dxp) (gcc version 4.0.0) #7 Sun Nov 13 21:=
59:01 CST 2005<br>
&gt;AMCC PowerPC 440EP Yosemite Platform<br>
&gt;Built 1 zonelists<br>
&gt;Kernel command line: ramdisk_size=3D49152 root=3D/dev/ram rw
ip=3D192.168.0.66:192.168.0.93::255.255.255.0:yosemite:eth0:off panic=3D1
console=3DttyS0,115200<br>
&gt;PID hash table entries: 2048 (order: 11, 32768 bytes)<br>
&gt;Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)<br>
&gt;Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)<br>
&gt;Memory: 239616k available (1860k kernel code, 596k data, 140k init, 0=
k highmem)<br>
&gt;Mount-cache hash table entries: 512<br>
&gt;checking if image is initramfs...it isn't (no cpio magic); looks like=
 an initrd<br>
&gt;softlockup thread 0 started up.<br>
&gt;Freeing initrd memory: 17354k freed<br>
&gt;NET: Registered protocol family 16<br>
&gt;PCI: Probing PCI hardware<br>
&gt;usbcore: registered new driver usbfs<br>
&gt;usbcore: registered new driver hub<br>
&gt;SCSI subsystem initialized<br>
&gt;io scheduler noop registered<br>
&gt;io scheduler anticipatory registered<br>
&gt;io scheduler deadline registered<br>
&gt;io scheduler cfq registered<br>
&gt;usbmon: debugfs is not available<br>
&gt;ppc-soc-ohci ppc-soc-ohci.0: USB Host Controller<br>
&gt;ppc-soc-ohci ppc-soc-ohci.0: new USB bus registered, assigned bus num=
ber 1<br>
&gt;ppc-soc-ohci ppc-soc-ohci.0: irq 40, io mem 0xef601000<br>
&gt;usb usb1: Product: USB Host Controller<br>
&gt;usb usb1: Manufacturer: Linux 2.6.14 ohci_hcd<br>
&gt;usb usb1: SerialNumber: PPC-SOC USB<br>
&gt;hub 1-0:1.0: USB hub found<br>
&gt;hub 1-0:1.0: 2 ports detected<br>
&gt;Initializing USB Mass Storage driver...<br>
&gt;usbcore: registered new driver usb-storage<br>
&gt;USB Mass Storage support registered.<br>
&gt;pegasus: v0.6.12 (2005/01/13), Pegasus/Pegasus II USB Ethernet driver=
<br>
&gt;usbcore: registered new driver pegasus<br>
&gt;Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enab=
led<br>
&gt;serial8250: ttyS0 at MMIO 0x0 (irq =3D 0) is a 16550A<br>
&gt;serial8250: ttyS1 at MMIO 0x0 (irq =3D 1) is a 16550A<br>
&gt;RAMDISK driver initialized: 16 RAM disks of 49152K size 1024 blocksiz=
e<br>
&gt;PPC 4xx OCP EMAC driver, version 3.53<br>
&gt;mal0: initialized, 4 TX channels, 2 RX channels<br>
&gt;zmii0: bridge in RMII mode<br>
&gt;eth0: emac0, MAC 00:10:ec:00:87:40<br>
&gt;eth0: found Generic MII PHY (0x01)<br>
&gt;eth1: emac1, MAC 00:10:ec:00:87:47<br>
&gt;eth1: found Generic MII PHY (0x03)<br>
&gt;Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2<br>
&gt;ide: Assuming 33MHz system bus speed for PIO modes; override with ide=
bus=3Dxx<br>
&gt;Data machine check in kernel mode.<br>
&gt;PLB0: BEAR=3D0x0000000000000000 ACR=3D&nbsp; 0x00000000 BESR=3D 0xfff=
ff7ff<br>
&gt;POB0: BEAR=3D0xc27e3194ffffffff BESR0=3D0x00000000 BESR1=3D0x00000000=
<br>
&gt;OPB0: BEAR=3D0x0000000000000151 BSTAT=3D0x00000000<br>
&gt;Oops: machine check, sig: 7 [#1]<br>
&gt;NIP: 00000000 LR: C0263628 SP: CFF41F40 REGS: c0271f50 TRAP: 0202&nbs=
p;&nbsp;&nbsp; Not tainted<br>
&gt;MSR: 00000000 EE: 0 PR: 0 FP: 0 ME: 0 IR/DR: 00<br>
&gt;TASK =3D c04f8b10[1] 'swapper' THREAD: cff40000<br>
&gt;Last syscall: 120<br>
&gt;GPR00: FDFFEF02 CFF41F40 C04F8B10 C04FC000 C026C6B4 C04FC000 00000009=
 CFF41EF4<br>
&gt;GPR08: C04F9F70 00000000 00004000 C0270000 24254322 61000408 0FFB6800=
 00000001<br>
&gt;GPR16: 00800000 0FFCEAD4 FFFFFFFF 00000000 007FFF00 0FFB1210 00000003=
 00000002<br>
&gt;GPR24: C01D0000 C01D0000 C0270000 C01D0000 C0270000 C0223E10 C026C6B4=
 C04FC000<br>
&gt;NIP [00000000] 0x0<br>
&gt;LR [c0263628] aec62xx_init_one+0x38/0x48<br>
&gt;Call trace:<br>
&gt; [c0263628] aec62xx_init_one+0x38/0x48<br>
&gt; [c02649b8] ide_scan_pcidev+0x68/0xb0<br>
&gt; [c0264a34] ide_scan_pcibus+0x34/0xe8<br>
&gt; [c026492c] ide_init+0x68/0x8c<br>
&gt; [c00013ac] init+0xb4/0x254<br>
&gt; [c00046c0] kernel_thread+0x48/0x64<br>
&gt;Data machine check in kernel mode.<br>
&gt;PLB0: BEAR=3D0x0000000000000000 ACR=3D&nbsp; 0x00000000 BESR=3D 0xfff=
ff7ff<br>
&gt;POB0: BEAR=3D0xc27e3194ffffffff BESR0=3D0x00000000 BESR1=3D0x00000000=
<br>
&gt;OPB0: BEAR=3D0x0000000000000151 BSTAT=3D0x00000000<br>
&gt;Oops: machine check, sig: 7 [#2]<br>
&gt;NIP: 00000000 LR: C000235C SP: C0271E70 REGS: c0271f50 TRAP: 0202&nbs=
p;&nbsp;&nbsp; Not tainted<br>
&gt;MSR: 00000000 EE: 0 PR: 0 FP: 0 ME: 0 IR/DR: 00<br>
&gt;TASK =3D c04f8b10[1] 'swapper' THREAD: cff40000<br>
&gt;Last syscall: 120<br>
&gt;GPR00: 08000000 C0271E70 C04F8B10 C0271E80 00001568 FFFFFFFF C0270000=
 00004000<br>
&gt;GPR08: C0270000 C000235C 00021002 C00039E8 C04F8CD8 61000408 0FFB6800=
 00000001<br>
&gt;GPR16: 00800000 0FFCEAD4 FFFFFFFF 00000000 007FFF00 0FFB1210 00000003=
 00000002<br>
&gt;GPR24: C01D0000 C01D0000 C0270000 C01D0000 C0270000 C0223E10 00000007=
 C0271F50<br>
&gt;NIP [00000000] 0x0<br>
&gt;LR [c000235c] ret_from_except+0x0/0x18<br>
&gt;Kernel panic - not syncing: Attempted to kill init!<br>
&gt; &lt;0&gt;Rebooting in 1 seconds..<br>
&gt;<br>
&gt; &nbsp;<br>
&gt;<br>
&gt;---------------------------------------------------------------------=
---<br>
&gt;<br>
&gt;_______________________________________________<br>
&gt;Linuxppc-embedded mailing list<br>
&gt;Linuxppc-embedded@ozlabs.org<br>
&gt;https://ozlabs.org/mailman/listinfo/linuxppc-embedded<br>
&gt;<br>
<br>
<br>
<br>
<div>&nbsp;</div><div>&nbsp;</div><div>&nbsp;</div><div>&nbsp;</div><br><=
!-- footer --><br>
--Boundary-1=_zxhekmnqpknQOYnWwEvOyPNJBRa--

--Boundary-=_zxhekmnqpknQOYnWwEvOyPNJBRak
Content-Type: text/plain; name="pci-ide-card-oops.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="pci-ide-card-oops.txt"

cm9vdEAxOTIuMTY4LjcuNjc6L2xpYi9tb2R1bGVzLzIuNi4xMy9rZXJuZWwvZHJpdmVycy9p
ZGUvcGNpIyBpbnNtb2QgaXQ4MjF4LmtvClQ4MjEyOiBJREUgY29udHJvbGxlciBhdCBQQ0kg
c2xvdCAwMDAwOjAwOjBjLjAKSVQ4MjEyOiBjaGlwc2V0IHJldmlzaW9uIDE3Cml0ODIxMjog
Zm9yY2luZyBieXBhc3MgbW9kZS4KaXQ4MjF4OiBjb250cm9sbGVyIGluIHBhc3MgdGhyb3Vn
aCBtb2RlLgpJVDgyMTI6IDEwMCUgbmF0aXZlIG1vZGUgb24gaXJxIDI1CkRhdGEgbWFjaGlu
ZSBjaGVjayBpbiBrZXJuZWwgbW9kZS4KUExCMDogQkVBUj0weDAwMDAwMDAwMDAwMDAwMDAg
QUNSPSAgMHgwMDAwMDAwMCBCRVNSPSAweGZmZmJmZmJmClBPQjA6IEJFQVI9MHhjMjdlMzE5
NGZmZmJmZmZmIEJFU1IwPTB4MDAwMDAwMDAgQkVTUjE9MHgwMDAwMDAwMApPUEIwOiBCRUFS
PTB4MDAwMDAwMDAwMDAwMDE1MSBCU1RBVD0weDAwMDAwMDAwCk9vcHM6IG1hY2hpbmUgY2hl
Y2ssIHNpZzogNyBbIzFdCk5JUDogMDAwMDAwMDAgTFI6IEMwMTMzMTM4IFNQOiBDRjQ5REQ1
MCBSRUdTOiBjMDJjOGY1MCBUUkFQOiAwMjAyICAgIE5vdCB0YWludGVkCk1TUjogMDAwMDAw
MDAgRUU6IDAgUFI6IDAgRlA6IDAgTUU6IDAgSVIvRFI6IDAwClRBU0sgPSBjMDI5NWI5MFsx
ODRdICdpbnNtb2QnIFRIUkVBRDogY2Y0OWMwMDAKTGFzdCBzeXNjYWxsOiAxMjgKR1BSMDA6
IEZERkZFRkQyIENGNDlERDUwIEMwMjk1QjkwIDAwMDAwMDAwIDAwMDAwMDYwIEZERkVFMDA0
IDAwMDAwMDAyIENGNDlERDM4CkdQUjA4OiAwMDAwMDAwMCBDMDJDMDAwMCAwMDAwMDAwOCBG
REZFRTAwNCAwMDAwMDAwMCAxMDAxOTUzOCBDMDJENUIzOCBDMDJENUIzOApHUFIxNjogQzAy
RDVCMzggMDAwMDAwMTkgMDAwMDAwMDAgQzAyRDVCMzggQzAyRDVCMzggQzA1NjUwMDAgQ0Y0
OURERTggQzA1NjUwMDAKR1BSMjQ6IEQxMDJGOEQyIEMwNTY1MDAwIDAwMDAwMDAwIDAwMDBG
RkQwIEQxMDJGOEIwIDQwMDAwMDAwIEMwMkQ1QjM4IEMwMkQ1QjM4Ck5JUCBbMDAwMDAwMDBd
IDB4MApMUiBbYzAxMzMxMzhdIGlkZV9wY2lfc2V0dXBfcG9ydHMrMHg2MWMvMHg3MTgKQ2Fs
bCB0cmFjZToKIFtjMDEzMzQ1MF0gZG9faWRlX3NldHVwX3BjaV9kZXZpY2UrMHgyMWMvMHg0
NmMKIFtjMDEzMzZjMF0gaWRlX3NldHVwX3BjaV9kZXZpY2UrMHgyMC8weDljCiBbZDEwMmY1
NzRdIGl0ODIxeF9pbml0X29uZSsweDI0LzB4MzggW2l0ODIxeF0KIFtjMDBmMWFmNF0gcGNp
X2RldmljZV9wcm9iZSsweDgwLzB4YTAKIFtjMDEwYTg4MF0gZHJpdmVyX3Byb2JlX2Rldmlj
ZSsweDUwLzB4ZjQKIFtjMDEwYWE4OF0gX19kcml2ZXJfYXR0YWNoKzB4ODQvMHhjNAogW2Mw
MTA5ZTE0XSBidXNfZm9yX2VhY2hfZGV2KzB4NTQvMHg5OAogW2MwMTBhYWVjXSBkcml2ZXJf
YXR0YWNoKzB4MjQvMHgzNAogW2MwMTBhMzg4XSBidXNfYWRkX2RyaXZlcisweDg4LzB4MTU4
CiBbYzAxMGIwMDRdIGRyaXZlcl9yZWdpc3RlcisweDM4LzB4NGMKIFtjMDBmMThmNF0gcGNp
X3JlZ2lzdGVyX2RyaXZlcisweDdjLzB4OGMKIFtjMDEzMzg2NF0gaWRlX3BjaV9yZWdpc3Rl
cl9kcml2ZXIrMHg1NC8weDZjCiBbZDEwMmY1ZGNdIGl0ODIxeF9pZGVfaW5pdCsweDU0LzB4
MzI4IFtpdDgyMXhdCiBbYzAwMzUxNGNdIHN5c19pbml0X21vZHVsZSsweDIzMC8weDMzYwog
W2MwMDAxYzc0XSByZXRfZnJvbV9zeXNjYWxsKzB4MC8weDQ4CkRhdGEgbWFjaGluZSBjaGVj
ayBpbiBrZXJuZWwgbW9kZS4KUExCMDogQkVBUj0weDAwMDAwMDAwMDAwMDAwMDAgQUNSPSAg
MHgwMDAwMDAwMCBCRVNSPSAweGZmZmJmZmJmClBPQjA6IEJFQVI9MHhjMjdlMzE5NGZmZmJm
ZmZmIEJFU1IwPTB4MDAwMDAwMDAgQkVTUjE9MHgwMDAwMDAwMApPUEIwOiBCRUFSPTB4MDAw
MDAwMDAwMDAwMDE1MSBCU1RBVD0weDAwMDAwMDAwCk9vcHM6IG1hY2hpbmUgY2hlY2ssIHNp
ZzogNyBbIzJdCk5JUDogMDAwMDAwMDAgTFI6IEMwMDAyMzdDIFNQOiBDMDJDOEU3MCBSRUdT
OiBjMDJjOGY1MCBUUkFQOiAwMjAyICAgIE5vdCB0YWludGVkCk1TUjogMDAwMDAwMDAgRUU6
IDAgUFI6IDAgRlA6IDAgTUU6IDAgSVIvRFI6IDAwClRBU0sgPSBjMDI5NWI5MFsxODRdICdp
bnNtb2QnIFRIUkVBRDogY2Y0OWMwMDAKTGFzdCBzeXNjYWxsOiAxMjgKR1BSMDA6IDA4MDAw
MDAwIEMwMkM4RTcwIEMwMjk1QjkwIEMwMkM4RTgwIDAwMDAxRTM0IEZGRkZGRkZGIEMwMjMw
MDAwIEMwMjM3MjQ0CkdQUjA4OiBDMDIzMDAwMCBDMDAwMjM3QyAwMDAyMTAwMiBDMDAwMzc3
NCBDMDI5NUQ1OCAxMDAxOTUzOCBDMDJENUIzOCBDMDJENUIzOApHUFIxNjogQzAyRDVCMzgg
MDAwMDAwMTkgMDAwMDAwMDAgQzAyRDVCMzggQzAyRDVCMzggQzA1NjUwMDAgQ0Y0OURERTgg
QzA1NjUwMDAKR1BSMjQ6IEQxMDJGOEQyIEMwNTY1MDAwIDAwMDAwMDAwIDAwMDBGRkQwIEQx
MDJGOEIwIDQwMDAwMDAwIEMwMkM4RjUwIDAwMDAwMDA3Ck5JUCBbMDAwMDAwMDBdIDB4MApM
UiBbYzAwMDIzN2NdIHJldF9mcm9tX2V4Y2VwdCsweDAvMHgxOApEYXRhIG1hY2hpbmUgY2hl
Y2sgaW4ga2VybmVsIG1vZGUuClBMQjA6IEJFQVI9MHgwMDAwMDAwMDAwMDAwMDAwIEFDUj0g
IDB4MDAwMDAwMDAgQkVTUj0gMHhmZmZiZmZiZgpQT0IwOiBCRUFSPTB4YzI3ZTMxOTRmZmZi
ZmZmZiBCRVNSMD0weDAwMDAwMDAwIEJFU1IxPTB4MDAwMDAwMDAKT1BCMDogQkVBUj0weDAw
MDAwMDAwMDAwMDAxNTEgQlNUQVQ9MHgwMDAwMDAwMApPb3BzOiBtYWNoaW5lIGNoZWNrLCBz
aWc6IDcgWyMzXQpOSVA6IDAwMDAwMDAwIExSOiBDMDAwNDgzNCBTUDogQ0ZBMERFMzAgUkVH
UzogYzAyYzhmNTAgVFJBUDogMDIwMiAgICBOb3QgdGFpbnRlZApNU1I6IDAwMDAwMDAwIEVF
OiAwIFBSOiAwIEZQOiAwIE1FOiAwIElSL0RSOiAwMApUQVNLID0gYzAyOTU3ZjBbMTQ0XSAn
a2xvZ2QnIFRIUkVBRDogY2ZhMGMwMDAKTGFzdCBzeXNjYWxsOiAzCkdQUjAwOiAyMjAwMjRF
NCBDRkEwREUzMCBDMDI5NTdGMCBDMDI5NUI5MCBDMDAwNDgzNCBDMDJDOTIwMCBDMDJDMjhD
MCAwMDAwMDAwMApHUFIwODogMTY1QTIyNzIgQzAyQzAwMDAgMjIwNDQyODQgMDAwMDAwMDAg
MDAwMDI3MEIgMTAwMUQxM0MgN0ZFQUI4NDQgNjU3ODY1NjMKR1BSMTY6IDEwMDAwMDAwIDdG
RUFCODgwIDEwMDEwMDAwIDEwMDAwMDAwIDEwMDEwMDAwIEMwMkQwMDAwIEMwMkQwMDAwIEMw
Mjk1OTFDCkdQUjI0OiAwMDAwMEY1RiBDMDJDQjUwMCBDMDJDQjUwMCBDMDJDMjhDMCBGOEY2
REYxNiBDMDI5NTQ1MCBDMDI5NTdGMCAwMDAyMTAwMApOSVAgWzAwMDAwMDAwXSAweDAKTFIg
W2MwMDA0ODMKCg==
--Boundary-=_zxhekmnqpknQOYnWwEvOyPNJBRak--
