Return-Path: <mqy@263.net.cn>
From: "KylongMu" <mqy@263.net.cn>
To: "'Wolfgang Denk'" <wd@denx.de>
Date: Wed, 2 Nov 2005 21:49:57 +0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0000_01C5DFF7.5E850820"
In-Reply-To: <20050711142250.BC3253539FE@atlas.denx.de>
Message-Id: <20051102135009.27C46102A@smtp.263.net>
Cc: Linuxppc-embedded@ozlabs.org
Subject: About 2.6.14 on AMCC Yosemite board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0000_01C5DFF7.5E850820
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi, Denk
	I've got my Yosemite board today, it's shows very good by default
test.
I downloaded the 2.6.14 according the repository from your website by
cogito.
with default configure, I boot with the uImage, but the system halt,
attachment
is the message.
	I don't know what happen with it, pls help me.

Thanks a lot!

Kylong Mu

------=_NextPart_000_0000_01C5DFF7.5E850820
Content-Type: text/plain;
	name="make_command.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="make_command.txt"

  924  make yosemite_defconfig=0A=
  925  make menuconfig=0A=
  926  make uImage=0A=

------=_NextPart_000_0000_01C5DFF7.5E850820
Content-Type: text/plain;
	name="bootmessage.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="bootmessage.txt"

=0A=
U-Boot 1.1.3 (Sep  7 2005 - 09:03:02)=0A=
=0A=
IBM PowerPC 440 EP Rev. B=0A=
Board: AMCC YOSEMITE=0A=
        VCO: 1066 MHz=0A=
        CPU: 533 MHz=0A=
        PLB: 133 MHz=0A=
        OPB: 66 MHz=0A=
        PER: 66 MHz=0A=
        PCI: 66 MHz=0A=
I2C:   ready=0A=
DRAM:  256 MB=0A=
FLASH: 32 MB=0A=
PCI:   Bus Dev VenId DevId Class Int=0A=
        00  0c  105a  4d68  0180  0e=0A=
In:    serial=0A=
Out:   serial=0A=
Err:   serial=0A=
Net:   ppc_440x_eth0, ppc_440x_eth1=0A=
Hit any key to stop autoboot:  0=0A=
=3D> tftp 0x4000000 uImage=0A=
Waiting for PHY auto negotiation to complete.. done=0A=
Using ppc_440x_eth0 device=0A=
TFTP from server 192.168.0.93; our IP address is 192.168.0.66=0A=
Filename 'uImage'.=0A=
Load address: 0x4000000=0A=
Loading: =
#################################################################=0A=
         =
#################################################################=0A=
         =
#################################################################=0A=
         #############################################=0A=
done=0A=
Bytes transferred =3D 1225628 (12b39c hex)=0A=
=3D> bootm 0x4000000 fed40000=0A=
## Booting image at 04000000 ...=0A=
   Image Name:   Linux-2.6.14=0A=
   Created:      2005-11-02  13:20:24 UTC=0A=
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)=0A=
   Data Size:    1225564 Bytes =3D  1.2 MB=0A=
   Load Address: 00000000=0A=
   Entry Point:  00000000=0A=
   Verifying Checksum ... OK=0A=
   Uncompressing Kernel Image ... OK=0A=
## Loading RAMDisk Image at fed40000 ...=0A=
   Image Name:   Yosemite Ramdisk=0A=
   Created:      2005-08-30   2:13:49 UTC=0A=
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)=0A=
   Data Size:    17770706 Bytes =3D 16.9 MB=0A=
   Load Address: 00000000=0A=
   Entry Point:  00000000=0A=
   Verifying Checksum ... OK=0A=
   Loading Ramdisk to 0ee9b000, end 0ff8d8d2 ... OK=0A=
Linux version 2.6.14 (root@dxp) (gcc =EF=BF=BD.=EF=BF=BD 3.3.3 (DENX =
ELDK 3.1.1 3.3.3-10)) #2 Wed Nov 2 21:20:16 CST 2005=0A=
AMCC PowerPC 440EP Yosemite Platform=0A=
Built 1 zonelists=0A=
Kernel command line: ramdisk=3D49152 root=3D/dev/ram =
ip=3D192.168.1.62:::::eth0:off=0A=
PID hash table entries: 2048 (order: 11, 32768 bytes)=0A=
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)=0A=
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)=0A=
Memory: 239360k available (1876k kernel code, 708k data, 140k init, 0k =
highmem)=0A=
Mount-cache hash table entries: 512=0A=
checking if image is initramfs...it isn't (no cpio magic); looks like an =
initrd=0A=
softlockup thread 0 started up.=0A=
Freeing initrd memory: 17354k freed=0A=
NET: Registered protocol family 16=0A=
PCI: Probing PCI hardware=0A=
usbcore: registered new driver usbfs=0A=
usbcore: registered new driver hub=0A=
SCSI subsystem initialized=0A=
usbmon: debugfs is not available=0A=
ppc-soc-ohci ppc-soc-ohci.0: USB Host Controller=0A=
ppc-soc-ohci ppc-soc-ohci.0: new USB bus registered, assigned bus number =
1=0A=
ppc-soc-ohci ppc-soc-ohci.0: irq 40, io mem 0xef601000=0A=
usb usb1: Product: USB Host Controller=0A=
usb usb1: Manufacturer: Linux 2.6.14 ohci_hcd=0A=
usb usb1: SerialNumber: PPC-SOC USB=0A=
hub 1-0:1.0: USB hub found=0A=
hub 1-0:1.0: 2 ports detected=0A=
Initializing USB Mass Storage driver...=0A=
usbcore: registered new driver usb-storage=0A=
USB Mass Storage support registered.=0A=
pegasus: v0.6.12 (2005/01/13), Pegasus/Pegasus II USB Ethernet driver=0A=
usbcore: registered new driver pegasus=0A=
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled=0A=
ttyS0 at MMIO 0x0 (irq =3D 0) is a 16550A=0A=
ttyS1 at MMIO 0x0 (irq =3D 1) is a 16550A=0A=
io scheduler noop registered=0A=
io scheduler anticipatory registered=0A=
io scheduler deadline registered=0A=
io scheduler cfq registered=0A=
RAMDISK driver initialized: 16 RAM disks of 49152K size 1024 blocksize=0A=
PPC 4xx OCP EMAC driver, version 3.53=0A=
mal0: initialized, 4 TX channels, 2 RX channels=0A=
zmii0: bridge in RMII mode=0A=
eth0: emac0, MAC 00:10:ec:00:8f:aa=0A=
eth0: found Generic MII PHY (0x01)=0A=
eth1: emac1, MAC 00:10:ec:80:8f:aa=0A=
eth1: found Generic MII PHY (0x03)=0A=
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2=0A=
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx=0A=
yosemite: flash mapping: 4000000 at fc000000=0A=
Data machine check in kernel mode.=0A=
PLB0: BEAR=3D0x0000000000000000 ACR=3D  0x00000000 BESR=3D 0xfdffffff=0A=
POB0: BEAR=3D0xc27e319400000001 BESR0=3D0x00000000 BESR1=3D0x00000000=0A=
OPB0: BEAR=3D0x0000000000000151 BSTAT=3D0x00000000=0A=
Oops: machine check, sig: 7 [#1]=0A=
NIP: 00000000 LR: C015D7C8 SP: C0521E30 REGS: c0291f50 TRAP: 0202    Not =
tainted=0A=
MSR: 00000000 EE: 0 PR: 0 FP: 0 ME: 0 IR/DR: 00=0A=
TASK =3D cee98b10[1] 'swapper' THREAD: c0520000=0A=
Last syscall: 120=0A=
GPR00: 00000002 C0521E30 CEE98B10 C0242F18 00000000 00000000 C0521EE0 =
CEF0C3F8=0A=
GPR08: 000000FF 00000004 00000002 00000001 42254128 C0020028 0FFE6E00 =
00000001=0A=
GPR16: FFFFFFFF 007FFF00 0FFE1AD4 00000000 00000003 007FFE70 00800000 =
00000001=0A=
GPR24: 00000000 C0521EE0 C0242DB0 00000000 C0242F18 C0521EE0 00000000 =
C0242F18=0A=
NIP [00000000] 0x0=0A=
LR [c015d7c8] genprobe_new_chip+0xa8/0xc0=0A=
Call trace:=0A=
 [c015d7c8] genprobe_new_chip+0xa8/0xc0=0A=
 [c015d508] genprobe_ident_chips+0x3c/0x254=0A=
 [c015d444] mtd_do_chip_probe+0x18/0xa0=0A=
 [c01587b8] cfi_probe+0x18/0x28=0A=
 [c01570c4] do_map_probe+0x40/0xe0=0A=
 [c028594c] init_yosemite_flash+0x90/0xec=0A=
 [c026c728] do_initcalls+0x54/0xfc=0A=
 [c000137c] init+0x2c/0x13c=0A=
 [c0004630] kernel_thread+0x48/0x64=0A=
Data machine check in kernel mode.=0A=
PLB0: BEAR=3D0x0000000000000000 ACR=3D  0x00000000 BESR=3D 0xfdffffff=0A=
POB0: BEAR=3D0xc27e319400000001 BESR0=3D0x00000000 BESR1=3D0x00000000=0A=
OPB0: BEAR=3D0x0000000000000151 BSTAT=3D0x00000000=0A=
Oops: machine check, sig: 7 [#2]=0A=
NIP: 00000000 LR: C000229C SP: C0291E60 REGS: c0291f50 TRAP: 0202    Not =
tainted=0A=
MSR: 00000000 EE: 0 PR: 0 FP: 0 ME: 0 IR/DR: 00=0A=
TASK =3D cee98b10[1] 'swapper' THREAD: c0520000=0A=
Last syscall: 120=0A=
GPR00: 08000000 C0291E60 CEE98B10 C0291E70 000015D7 FFFFFFFF C0230000 =
C0290000=0A=
GPR08: C0230000 C000229C 00021002 C00036D0 CEE98CD8 C0020028 0FFE6E00 =
00000001=0A=
GPR16: FFFFFFFF 007FFF00 0FFE1AD4 00000000 00000003 007FFE70 00800000 =
00000001=0A=
GPR24: 00000000 C0521EE0 C0242DB0 00000000 C0242F18 C0521EE0 C0291F50 =
00000007=0A=
NIP [00000000] 0x0=0A=
LR [c000229c] ret_from_except+0x0/0x18=0A=
Kernel panic - not syncing: Attempted to kill init!=0A=
 <0>Rebooting in 180 seconds..=0A=

------=_NextPart_000_0000_01C5DFF7.5E850820--
