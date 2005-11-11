Return-Path: <mqy@263.net.cn>
From: "KylongMu" <mqy@263.net.cn>
To: <wd@denx.de>
Date: Fri, 11 Nov 2005 10:04:14 +0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0000_01C5E6A7.46A9B0A0"
In-Reply-To: <20051102164644.6D167353A2C@atlas.denx.de>
Message-Id: <20051111020420.9644C1073@smtp.263.net>
Cc: Linuxppc-embedded@ozlabs.org
Subject: 11-11-05 2.6.14 on AMCC Yosemite board(boot error) 
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

------=_NextPart_000_0000_01C5E6A7.46A9B0A0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Denk:
	With today's update, I can make the kernel by Yosemite_defconfig,
but
When boot my board with this new kernel, it halt at boot time, the
attachment
Is the boot message.

Cordially,
Kylong Mu


------=_NextPart_000_0000_01C5E6A7.46A9B0A0
Content-Type: text/plain;
	name="bootmessage.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="bootmessage.txt"

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
In:    serial=0A=
Out:   serial=0A=
Err:   serial=0A=
Net:   ppc_440x_eth0, ppc_440x_eth1=0A=
Hit any key to stop autoboot:  0=0A=
=3D> tftp 0x400000 uImage=0A=
Waiting for PHY auto negotiation to complete.. done=0A=
Using ppc_440x_eth0 device=0A=
TFTP from server 192.168.0.93; our IP address is 192.168.0.66=0A=
Filename 'uImage'.=0A=
Load address: 0x400000=0A=
Loading: =
#################################################################=0A=
         =
#################################################################=0A=
         =
#################################################################=0A=
         ##########################################=0A=
done=0A=
Bytes transferred =3D 1212626 (1280d2 hex)=0A=
=3D> bootm 0x400000 0xfed40000=0A=
## Booting image at 00400000 ...=0A=
   Image Name:   Linux-2.6.14=0A=
   Created:      2005-11-11   1:51:20 UTC=0A=
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)=0A=
   Data Size:    1212562 Bytes =3D  1.2 MB=0A=
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
Linux version 2.6.14 (root@dxp) (gcc version 4.0.0) #1 Fri Nov 11 =
09:51:04 CST 2005=0A=
AMCC PowerPC 440EP Yosemite Platform=0A=
Built 1 zonelists=0A=
Kernel command line: ramdisk=3D49152 root=3D/dev/ram =
ip=3D192.168.1.62:::::eth0:off=0A=
PID hash table entries: 2048 (order: 11, 32768 bytes)=0A=
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)=0A=
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)=0A=
Memory: 239488k available (1852k kernel code, 604k data, 136k init, 0k =
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
io scheduler noop registered=0A=
io scheduler anticipatory registered=0A=
io scheduler deadline registered=0A=
io scheduler cfq registered=0A=
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
serial8250: ttyS0 at MMIO 0x0 (irq =3D 0) is a 16550A=0A=
serial8250: ttyS1 at MMIO 0x0 (irq =3D 1) is a 16550A=0A=
RAMDISK driver initialized: 16 RAM disks of 49152K size 1024 blocksize=0A=
PPC 4xx OCP EMAC driver, version 3.53=0A=
mal0: initialized, 4 TX channels, 2 RX channels=0A=
zmii0: bridge in RMII mode=0A=
eth0: emac0, MAC 00:10:ec:00:8f:aa=0A=
eth0: found Generic MII PHY (0x01)=0A=
eth1: emac1, MAC 00:10:ec:80:8f:aa=0A=
eth1: found Generic MII PHY (0x03)=0A=
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2=0A=
ide: Assuming 50MHz system bus speed for PIO modes; override with =
idebus=3Dxx=0A=
Data machine check in kernel mode.=0A=
PLB0: BEAR=3D0x0000000000000000 ACR=3D  0x00000000 BESR=3D 0xfdfff7ff=0A=
POB0: BEAR=3D0xc27e3194ffffffff BESR0=3D0x00000000 BESR1=3D0x00000000=0A=
OPB0: BEAR=3D0x0000000000000151 BSTAT=3D0x00000000=0A=
Oops: machine check, sig: 7 [#1]=0A=
NIP: 00000000 LR: C0157E9C SP: CFFA1EE0 REGS: c0270f50 TRAP: 0202    Not =
tainted=0A=
MSR: 00000000 EE: 0 PR: 0 FP: 0 ME: 0 IR/DR: 00=0A=
TASK =3D cee98b10[1] 'swapper' THREAD: cffa0000=0A=
Last syscall: 120=0A=
GPR00: 00000002 CFFA1EE0 CEE98B10 C022673C 00000000 00000000 CFFA1F18 =
00000000=0A=
GPR08: 00000002 00000002 00000002 00000001 000F1FFF 60000428 0FFE6E00 =
00000001=0A=
GPR16: FFFFFFFF 007FFF00 0FFE1AD4 00000000 00000003 007FFE70 00800000 =
00000001=0A=
GPR24: C01D0000 C01D0000 C0270000 00000000 C022673C CFFA1F18 00000000 =
C022673C=0A=
NIP [00000000] 0x0=0A=
LR [c0157e9c] mtd_do_chip_probe+0xdc/0x334=0A=
Call trace:=0A=
 [c0157e9c] mtd_do_chip_probe+0xdc/0x334=0A=
 [c0152214] cfi_probe+0x18/0x28=0A=
 [c0152160] do_map_probe+0x40/0xdc=0A=
 [c0265568] init_yosemite_flash+0xb4/0x110=0A=
 [c00013ac] init+0xb4/0x254=0A=
 [c00046c0] kernel_thread+0x48/0x64=0A=
Data machine check in kernel mode.=0A=
PLB0: BEAR=3D0x0000000000000000 ACR=3D  0x00000000 BESR=3D 0xfdfff7ff=0A=
POB0: BEAR=3D0xc27e3194ffffffff BESR0=3D0x00000000 BESR1=3D0x00000000=0A=
OPB0: BEAR=3D0x0000000000000151 BSTAT=3D0x00000000=0A=
Oops: machine check, sig: 7 [#2]=0A=
NIP: 00000000 LR: C000235C SP: C0270E70 REGS: c0270f50 TRAP: 0202    Not =
tainted=0A=
MSR: 00000000 EE: 0 PR: 0 FP: 0 ME: 0 IR/DR: 00=0A=
TASK =3D cee98b10[1] 'swapper' THREAD: cffa0000=0A=
Last syscall: 120=0A=
GPR00: 08000000 C0270E70 CEE98B10 C0270E80 00001529 FFFFFFFF C0270000 =
00004000=0A=
GPR08: C0270000 C000235C 00021002 C00039E8 CEE98CD8 60000428 0FFE6E00 =
00000001=0A=
GPR16: FFFFFFFF 007FFF00 0FFE1AD4 00000000 00000003 007FFE70 00800000 =
00000001=0A=
GPR24: C01D0000 C01D0000 C0270000 00000000 C022673C CFFA1F18 00000007 =
C0270F50=0A=
NIP [00000000] 0x0=0A=
LR [c000235c] ret_from_except+0x0/0x18=0A=
Kernel panic - not syncing: Attempted to kill init!=0A=
 <0>Rebooting in 180 seconds..=0A=

------=_NextPart_000_0000_01C5E6A7.46A9B0A0--
