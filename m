Return-Path: <yogeshkumarm@tataelxsi.co.in>
Received: from mail.tataelxsi.co.in (mail.tataelxsi.co.in [203.200.1.48])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(Client CN "myname.my.domain",
	Issuer "www.mirapoint.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6754267B69
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Jul 2006 21:15:07 +1000 (EST)
From: Yogesh Kumar M <yogeshkumarm@tataelxsi.co.in>
To: <linuxppc-embedded@ozlabs.org>
Subject: FW: PCI Related issue please give us some solution
Date: Wed, 12 Jul 2006 16:38:23 +0530
Message-ID: <000001c6a5a3$7e144df0$4729320a@telxsi.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0001_01C6A5D1.97CC89F0"
Reply-To: Yogesh Kumar M <yogeshkumarm@tataelxsi.co.in>
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

------=_NextPart_000_0001_01C6A5D1.97CC89F0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi All,

          This is yogesh,we have a custom made board with

        1)MPC5200B(with host bridge support)
        2)PCI2PCI Bridge device from texas instruments TI2250 (PCI2250PCM)
        3)DM642 dsp based processor
        and other I/O devices like serial port,HDD interface,ethernet etc

        we have successfully ported U-BOOT 1.1.3 and linux-2.4.25 where all
resources are working fine we where able to commnuciate form HOST to TARGET
and from TARGET to HOST using PCI2PCI Bridge where MPC5200B is acting as
HOST and DM642 is TARGET

Now we have migrate from 2.4.25 to 2.6.11.7 where booting is happining but
we have problem in PCI where we are not able to do host to target or target
to host commnuciation we have added some fixup code for PCI but found
nothing useful

can you please tell what could be wrong and what is the major difference
2.4.25 to 2.6.11.7 pertaning to PCI

 find the attachment to the log files of both 2.4.25 and 2.6.11.7

please help out since we are struck with this problem for a long time.

when we tried 2.6.17.3 kernel source from kernel.org

we got the following log the kernel hangs after uncompressing
(LINUX-2.6.17.3)
/**********************log start**********************/
Filename 'uImage'.
Load address: 0x1000000
Loading:
        #################################################################
        #################################################################
        #################################################################
        ##########
done
Bytes transferred = 1045614 (ff46e hex)
## Booting image at 01000000 ...
   Image Name:   Linux-2.6.17.3
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1045550 Bytes = 1021 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Transferring control to Linux (at address 00000000) ...

/***********************log end***********************/

could you please give us some some suggestions to overcome this issue



thanks
regards
yogesh

yogeshkumarm@tataelxsi.co.in

------=_NextPart_000_0001_01C6A5D1.97CC89F0
Content-Type: text/plain;
	name="linux-2_4_25.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="linux-2_4_25.txt"

######## For 2.4.25 kernel from Freescale ##################=0A=
=0A=
U-Boot 1.1.3 (Freescale) (May 17 2006 - 08:00:07)=0A=
=0A=
CPU:   MPC5200 v2.2 at 396 MHz=0A=
       Bus 132 MHz, IPB 132 MHz, PCI 33 MHz=0A=
Board: Freescale MPC5200 (Lite5200B)=0A=
I2C:   85 kHz, ready=0A=
DRAM:  64 MB=0A=
Top of RAM usable for U-Boot at: 04000000=0A=
Reserving 524k for U-Boot at: 03f7c000=0A=
Reserving 191k for malloc() at: 03f4c008=0A=
Reserving 68 Bytes for Board Info at: 03f4bfc4=0A=
Reserving 56 Bytes for Global Data at: 03f4bf8c=0A=
Stack Pointer at: 03f4bf68=0A=
New Stack Pointer is: 03f4bf68=0A=
Now running in RAM - U-Boot at: 03f7c000=0A=
FLASH: Flash does not respond to CFI commands=0A=
flash_protect ON: from 0xFF000000 to 0xFF038FFF=0A=
protect on 0=0A=
protect on 1=0A=
protect on 2=0A=
protect on 3=0A=
flash_protect ON: from 0xFF040000 to 0xFF04FFF7=0A=
protect on 4=0A=
16 MB=0A=
basetask =3D 0, tasks =3D 2=0A=
task_org =3D 0x03fb3000=0A=
TDT start =3D 0x00000040, end =3D 0x000001b8=0A=
U-Boot : Doing PCI Initialization for MPC5200B =0A=
PCI:   Bus Dev VenId DevId Class Int=0A=
PCI:   Bus Dev VenId DevId Class Int=0A=
PCI Scan: Found Bus 0, Device 24, Function 0=0A=
        00  18  1057  5809  0680  00=0A=
PCI Scan: Found Bus 0, Device 26, Function 0=0A=
PCI Scan: Found Bus 1, Device 8, Function 0=0A=
        01  08  104c  9065  ff00  00=0A=
        00  1a  104c  ac23  0604  ff=0A=
In:    serial=0A=
Out:   serial=0A=
Err:   serial=0A=
U-Boot relocated to 03f7c000=0A=
### main_loop entered: bootdelay=3D5=0A=
=0A=
### main_loop: bootcmd=3D"run nfsargs addip;tftp 1000000 =
/tftpboot/uImage;bootm 1000000"=0A=
Hit any key to stop autoboot:  5 =08=08=08 4 =08=08=08 3 =08=08=08 2 =
=08=08=08 1 =08=08=08 0 =0A=
Net:   mpc5xxx_fec_init_phy... Begin=0A=
mpc5xxx_fec_init_phy... Done =0A=
FEC ETHERNET=0A=
Trying FEC ETHERNET=0A=
mpc5xxx_fec_init... Begin=0A=
mpc5xxx_fec_init_phy_complete... Begin=0A=
mpc5xxx_fec_init_phy_complete... Done =0A=
mpc5xxx_fec_init... Done =0A=
Using FEC ETHERNET device=0A=
TFTP from server 10.50.40.203; our IP address is 10.50.40.201=0A=
Filename '/tftpboot/uImage'.=0A=
Load address: 0x1000000=0A=
Loading: =0A=
=0A=
#########################################################################=
####=0A=
#########################################################################=
####=0A=
#########################################################################=
####=0A=
#########################################################################=
####=0A=
#########################=0A=
=0A=
done=0A=
Bytes transferred =3D 1000192 (f4300 hex)=0A=
Ethernet task stopped=0A=
## Booting image at 01000000 ...=0A=
   Image Name:   Linux-2.4.25=0A=
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)=0A=
   Data Size:    1000128 Bytes =3D 976.7 kB=0A=
   Load Address: 00000000=0A=
   Entry Point:  00000000=0A=
   Uncompressing Kernel Image ... OK=0A=
## Current stack ends at 0x03F4BBB8 =3D> set upper limit to 0x00800000=0A=
## cmdline at 0x007FFF00 ... 0x007FFF9E=0A=
bd address  =3D 0x03F4BFC4=0A=
memstart    =3D 0x00000000=0A=
memsize     =3D 0x04000000=0A=
flashstart  =3D 0xFF000000=0A=
flashsize   =3D 0x01000000=0A=
flashoffset =3D 0x00039000=0A=
sramstart   =3D 0x00000000=0A=
sramsize    =3D 0x00000000=0A=
bootflags   =3D 0x00000001=0A=
intfreq     =3D    396 MHz=0A=
busfreq     =3D    132 MHz=0A=
ethaddr     =3D 00:04:9F:AA:BB:CC=0A=
IP addr     =3D 10.50.40.201=0A=
baudrate    =3D 115200 bps=0A=
No initrd=0A=
## Transferring control to Linux (at address 00000000) ...=0A=
Memory BAT mapping: BAT2=3D64Mb, BAT3=3D0Mb, residual: 0Mb=0A=
Linux version 2.4.25 (root@localname) (gcc version 3.3.2) #22 Tue Jul 4 =
05:22:54 UTC 2006=0A=
On node 0 totalpages: 16384=0A=
zone(0): 16384 pages.=0A=
zone(1): 0 pages.=0A=
zone(2): 0 pages.=0A=
Kernel command line: console=3DttyS0,115200 root=3D/dev/nfs =
nfsroot=3D10.50.40.203:/tftpboot/5200B_test/rootfsdir =
ip=3D10.50.40.201:10.50.40.203:10.50.40.1:255.255.248.0::eth0:off =
panic=3D1=0A=
Console: colour dummy device 80x25=0A=
Calibrating delay loop... 263.78 BogoMIPS=0A=
Memory: 61928k available (1672k kernel code, 552k data, 96k init, 0k =
highmem)=0A=
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)=0A=
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)=0A=
Mount cache hash table entries: 512 (order: 0, 4096 bytes)=0A=
Buffer cache hash table entries: 4096 (order: 2, 16384 bytes)=0A=
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)=0A=
POSIX conformance testing by UNIFIX=0A=
PCI: Probing PCI hardware=0A=
pcibios_fixup_bus <1>: res->start =3D 50001000, res->end =3D 50001fff=0A=
pcibios_fixup_bus <1>: res->start =3D 40000000, res->end =3D 40ffffff=0A=
pcibios_fixup_bus <1>: res->start =3D 10000000, res->end =3D 100fffff=0A=
pcibios_fixup_bus <1>: res->start =3D 0, res->end =3D 0=0A=
PCI: bridge rsrc 50000000..50ffffff (100), parent c01dffd0=0A=
PCI: bridge rsrc 40000000..4fffffff (200), parent c01dffec=0A=
PCI: bridge rsrc 50001000..50001fff (101), parent c02d5038=0A=
PCI: bridge rsrc 40000000..40ffffff (200), parent c02d5054=0A=
PCI: bridge rsrc 10000000..100fffff (1200), parent 00000000=0A=
PCI: Cannot allocate resource region 2 of PCI bridge 1=0A=
PCI: bridge 1 resource 2 moved to 4ff00000..4fffffff=0A=
PCI: Cannot allocate resource region 0 of device 00:18.0=0A=
Linux NET4.0 for Linux 2.4=0A=
Based upon Swansea University Computer Society NET3.039=0A=
Initializing RT netlink socket=0A=
Starting kswapd=0A=
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).=0A=
JFFS2 version 2.2. (C) 2001-2003 Red Hat, Inc.=0A=
i2c-core.o: i2c core module version 2.6.1 (20010830)=0A=
i2c-dev.o: i2c /dev entries driver module version 2.6.1 (20010830)=0A=
i2c-proc.o version 2.6.1 (20010830)=0A=
MB86290: fb_init called.=0A=
MB86290: initialize called.=0A=
MB86290: pci_find_device failed(10cf, 2019).=0A=
MB86290: get pci addr failed.=0A=
MB86290: initialize_gdc failed.=0A=
MB86290: initialize_gdc failed.=0A=
pty: 256 Unix98 ptys configured=0A=
ttyS0 on PSC1=0A=
ttyS1 on PSC2=0A=
ttyS2 on PSC3=0A=
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize=0A=
loop: loaded (max 8 devices)=0A=
PPP generic driver version 2.4.2=0A=
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4=0A=
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx=0A=
Port Config is: 0x10050004=0A=
ipb=3D132MHz, set clock period to 7=0A=
GPIO config: 11050004=0A=
ATA invalid: 01000000=0A=
ATA hostcnf: 03000000=0A=
ATA pio1   : 100a0a00=0A=
ATA pio2   : 02040600=0A=
XLB Arb cnf: 0000a366=0A=
mpc5xxx_ide: Setting up IDE interface ide0...=0A=
Probing IDE interface ide0...=0A=
SCSI subsystem driver Revision: 1.00=0A=
Icecube Bank 0: Found 1 x16 devices at 0x0 in 8-bit mode=0A=
 Amd/Fujitsu Extended Query Table at 0x0040=0A=
Icecube Bank 0: CFI does not contain boot bank location. Assuming top.=0A=
number of CFI chips: 1=0A=
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.=0A=
Icecube flash bank 0: Using static image partition definition=0A=
Creating 5 MTD partitions on "Icecube Bank 0":=0A=
0x00000000-0x00040000 : "Bootloader"=0A=
0x00040000-0x00050000 : "Environment"=0A=
0x00050000-0x00e00000 : "Filesystem"=0A=
0x00e00000-0x00f00000 : "Kernel"=0A=
0x00f00000-0x01000000 : "dBUG"=0A=
usb.c: registered new driver usbdevfs=0A=
usb.c: registered new driver hub=0A=
host/usb-ohci.c: USB OHCI at membase 0xf0001000, IRQ 44=0A=
host/usb-ohci.c: usb-0, Built-In ohci=0A=
usb.c: new USB bus registered, assigned bus number 1=0A=
hub.c: USB hub found=0A=
hub.c: 2 ports detected=0A=
usb.c: registered new driver usbmouse=0A=
usbmouse.c: v1.6:USB HID Boot Protocol mouse driver=0A=
usb.c: registered new driver usbkbd=0A=
usbkbd.c: :USB HID Boot Protocol keyboard driver=0A=
Initializing USB Mass Storage driver...=0A=
usb.c: registered new driver usb-storage=0A=
USB Mass Storage support registered.=0A=
mice: PS/2 mouse device common for all mice=0A=
i2c-icecube.o: I2C module #2 installed=0A=
NET4: Linux TCP/IP 1.0 for NET4.0=0A=
IP Protocols: ICMP, UDP, TCP=0A=
IP: routing cache hash table of 512 buckets, 4Kbytes=0A=
TCP: Hash tables configured (established 4096 bind 8192)=0A=
eth0: Phy @ 0x0, type LXT971 (0x001378e2)=0A=
IP-Config: Complete:=0A=
      device=3Deth0, addr=3D10.50.40.201, mask=3D255.255.248.0, =
gw=3D10.50.40.1,=0A=
     host=3D10.50.40.201, domain=3D, nis-domain=3D(none),=0A=
     bootserver=3D10.50.40.203, rootserver=3D10.50.40.203, rootpath=3D=0A=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.=0A=
Looking up port of RPC 100003/2 on 10.50.40.203=0A=
Looking up port of RPC 100005/1 on 10.50.40.203=0A=
VFS: Mounted root (nfs filesystem).=0A=
Freeing unused kernel memory: 96k init=0A=
hub.c: new USB device 0-1, assigned address 2=0A=
usb.c: USB device not accepting new address=3D2 (error=3D-110)=0A=
Setting hostname=0A=
hostname: /etc/hostname: No such file or directory=0A=
Setting Date=0A=
Wed Sep 10 00:00:00 GMT 2003=0A=
Mounting proc=0A=
Remounting rootfs r/w=0A=
Mounting sysfs=0A=
hub.c: new USB device 0-1, assigned address 3=0A=
usb.c: USB device not accepting new address=3D3 (error=3D-110)=0A=
mount: Mounting sysfs on /sys failed: No such device=0A=
*** Running rc.modules=0A=
*** Running rc.serial=0A=
*** Attempting to start S15inet=0A=
Starting inetd=0A=
Done=0A=
*** Attempting to start S20network=0A=
Setting up link for loopback=0A=
Done=0A=
Setting up link for eth0=0A=
SIOCSIFNETMASK: Invalid argument=0A=
RTNETLINK answers: File exists=0A=
FAILED=0A=
*** Attempting to start S23portmap=0A=
Starting rpc.portmap=0A=
Done=0A=
*** Attempting to start S30ftp=0A=
Starting in.ftpd=0A=
Done=0A=
*** Attempting to start S30vsftpd=0A=
Starting vsftpd=0A=
Done=0A=
*** Attempting to start S90boa=0A=
bind: Address already in use=0A=
*** Running rc.local=0A=
=0A=
10.50.40.201 login: root=0A=
login[39]: root login  on `ttyS0'=0A=
=0A=
# =0A=
# =0A=
# =0A=
# =0A=
# =0A=
# cat /proc/bus/pci/devices =0A=
00c0	10575809	0	00000000	00000008	00000000	00000000	00000000	00000000	=
00000000	00040000	40000000	00000000	00000000	00000000	00000000	00000000	=0A=
00d0	104cac23	0	00000000	00000000	00000000	00000000	00000000	00000000	=
00000000	00000000	00000000	00000000	00000000	00000000	00000000	00000000	=0A=
0140	104c9065	0	40000008	40800000	50001001	00000000	00000000	00000000	=
00000000	00400000	00800000	00000010	00000000	00000000	00000000	00000000	=0A=
# =0A=

------=_NextPart_000_0001_01C6A5D1.97CC89F0
Content-Type: text/plain;
	name="linux-2_6_11_7.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="linux-2_6_11_7.txt"

######## For 2.6.11.7 kernel from Freescale ##################=0A=
U-Boot 1.1.3 (Freescale) (May 17 2006 - 08:00:07)=0A=
=0A=
CPU:   MPC5200 v2.2 at 396 MHz=0A=
       Bus 132 MHz, IPB 132 MHz, PCI 33 MHz=0A=
Board: Freescale MPC5200 (Lite5200B)=0A=
I2C:   85 kHz, ready=0A=
DRAM:  64 MB=0A=
Top of RAM usable for U-Boot at: 04000000=0A=
Reserving 524k for U-Boot at: 03f7c000=0A=
Reserving 191k for malloc() at: 03f4c008=0A=
Reserving 68 Bytes for Board Info at: 03f4bfc4=0A=
Reserving 56 Bytes for Global Data at: 03f4bf8c=0A=
Stack Pointer at: 03f4bf68=0A=
New Stack Pointer is: 03f4bf68=0A=
Now running in RAM - U-Boot at: 03f7c000=0A=
FLASH: Flash does not respond to CFI commands=0A=
flash_protect ON: from 0xFF000000 to 0xFF038FFF=0A=
protect on 0=0A=
protect on 1=0A=
protect on 2=0A=
protect on 3=0A=
flash_protect ON: from 0xFF040000 to 0xFF04FFF7=0A=
protect on 4=0A=
16 MB=0A=
basetask =3D 0, tasks =3D 2=0A=
task_org =3D 0x03fb3000=0A=
TDT start =3D 0x00000040, end =3D 0x000001b8=0A=
U-Boot : Doing PCI Initialization for MPC5200B =0A=
PCI:   Bus Dev VenId DevId Class Int=0A=
PCI:   Bus Dev VenId DevId Class Int=0A=
PCI Scan: Found Bus 0, Device 24, Function 0=0A=
        00  18  1057  5809  0680  00=0A=
PCI Scan: Found Bus 0, Device 26, Function 0=0A=
PCI Scan: Found Bus 1, Device 8, Function 0=0A=
        01  08  104c  9065  ff00  00=0A=
        00  1a  104c  ac23  0604  ff=0A=
In:    serial=0A=
Out:   serial=0A=
Err:   serial=0A=
U-Boot relocated to 03f7c000=0A=
### main_loop entered: bootdelay=3D5=0A=
=0A=
### main_loop: bootcmd=3D"run nfsargs addip;tftp 1000000 =
/tftpboot/uImage;bootm 1000000"=0A=
Hit any key to stop autoboot:  5 =08=08=08 4 =08=08=08 3 =08=08=08 2 =
=08=08=08 1 =08=08=08 0 =0A=
Net:   mpc5xxx_fec_init_phy... Begin=0A=
mpc5xxx_fec_init_phy... Done =0A=
FEC ETHERNET=0A=
Trying FEC ETHERNET=0A=
mpc5xxx_fec_init... Begin=0A=
mpc5xxx_fec_init_phy_complete... Begin=0A=
mpc5xxx_fec_init_phy_complete... Done =0A=
mpc5xxx_fec_init... Done =0A=
Using FEC ETHERNET device=0A=
TFTP from server 10.50.40.203; our IP address is 10.50.40.201=0A=
Filename '/tftpboot/uImage'.=0A=
Load address: 0x1000000=0A=
Loading: =0A=
#########################################################################=
###=0A=
#########################################################################=
###=0A=
#########################################################################=
###=0A=
#########################################################################=
###=0A=
#########################################################################=
###=0A=
#####################################=0A=
=0A=
Bytes transferred =3D 1471170 (1672c2 hex)=0A=
Ethernet task stopped=0A=
## Booting image at 01000000 ...=0A=
   Image Name:   Linux-2.6.11.7=0A=
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)=0A=
   Data Size:    1471106 Bytes =3D  1.4 MB=0A=
   Load Address: 00000000=0A=
   Entry Point:  00000000=0A=
   Uncompressing Kernel Image ... OK=0A=
## Current stack ends at 0x03F4BBB8 =3D> set upper limit to 0x00800000=0A=
## cmdline at 0x007FFF00 ... 0x007FFF9E=0A=
bd address  =3D 0x03F4BFC4=0A=
memstart    =3D 0x00000000=0A=
memsize     =3D 0x04000000=0A=
flashstart  =3D 0xFF000000=0A=
flashsize   =3D 0x01000000=0A=
flashoffset =3D 0x00039000=0A=
sramstart   =3D 0x00000000=0A=
sramsize    =3D 0x00000000=0A=
bootflags   =3D 0x00000001=0A=
intfreq     =3D    396 MHz=0A=
busfreq     =3D    132 MHz=0A=
ethaddr     =3D 00:04:9F:AA:BB:CC=0A=
IP addr     =3D 10.50.40.201=0A=
baudrate    =3D 115200 bps=0A=
No initrd=0A=
## Transferring control to Linux (at address 00000000) ...=0A=
Linux version 2.6.11.7 (root@localname) (gcc version 3.3.2) #25 Tue Jul =
11 12:00:47 UTC 2006=0A=
mpc52xx_find_bridges: isa_io_base =3D ef000000=0A=
mpc52xx_find_bridges: cfg_addr =3D 0=0A=
PCI Autoconfig: Found P2P bridge, device 26=0A=
Built 1 zonelists=0A=
Kernel command line: console=3DttyS0,115200 root=3D/dev/nfs =
nfsroot=3D10.50.40.203:/tftpboot/5200B_test/rootfsdir =
ip=3D10.50.40.201:10.50.40.203:10.50.40.1:255.255.248.0::eth0:off =
panic=3D1=0A=
PID hash table entries: 512 (order: 9, 8192 bytes)=0A=
Console: colour dummy device 80x25=0A=
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)=0A=
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)=0A=
Memory: 61568k available (2292k kernel code, 840k data, 140k init, 0k =
highmem)=0A=
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)=0A=
spawn_desched_task(00000000)=0A=
desched cpu_callback 3/00000000=0A=
ksoftirqd started up.=0A=
softirq RT prio: 24.=0A=
desched cpu_callback 2/00000000=0A=
desched thread 0 started up.=0A=
NET: Registered protocol family 16=0A=
PCI: Probing PCI hardware=0A=
******** In pcibios_fixup_resources ********=0A=
VendorId: 1057, DevId: 5809=0A=
For 1: res->start =3D 80000000, res->end =3D bfffffff=0A=
******** In pcibios_fixup_resources ********=0A=
VendorId: 104c, DevId: ac23=0A=
******** In pcibios_fixup_resources ********=0A=
VendorId: 104c, DevId: 9065=0A=
For 0: res->start =3D 7fc00000, res->end =3D 7fffffff=0A=
For 1: res->start =3D 7f000000, res->end =3D 7f7fffff=0A=
For 2: res->start =3D f003fff0, res->end =3D f003ffff=0A=
pci_read_bridge_base: VendorId: 104c, DevId =3D ac23=0A=
Bus Res Start =3D f003f000, Bus Res End =3D f003ffff=0A=
Bus Res Start =3D 7f000000, Bus Res End =3D 7fffffff=0A=
Bus Res Start =3D 7ef00000, Bus Res End =3D 7effffff=0A=
Bus Res Start =3D 0, Bus Res End =3D 0=0A=
PCI: bridge rsrc 0..ffffff (100), parent c02a290c=0A=
PCI: bridge rsrc 40000000..4fffffff (200), parent c02a2928=0A=
PCI: bridge rsrc f003f000..f003ffff (101), parent 00000000=0A=
PCI: Cannot allocate resource region 0 of PCI bridge 1=0A=
PCI: bridge 1 resource 0 moved to fff000..ffffff=0A=
PCI: bridge rsrc 7f000000..7fffffff (200), parent 00000000=0A=
PCI: Cannot allocate resource region 1 of PCI bridge 1=0A=
PCI: bridge 1 resource 1 moved to 4f000000..4fffffff=0A=
PCI: bridge rsrc 7ef00000..7effffff (1200), parent 00000000=0A=
PCI: Cannot allocate resource region 2 of PCI bridge 1=0A=
PCI: bridge 1 resource 2 moved to 4ef00000..4effffff=0A=
SCSI subsystem initialized=0A=
usbcore: registered new driver usbfs=0A=
usbcore: registered new driver hub=0A=
JFFS2 version 2.2. (C) 2001-2003 Red Hat, Inc.=0A=
ppdev: user-space parallel port driver=0A=
Serial: MPC52xx PSC driver=0A=
ttyS0 at MMIO 0xf0002000 (irq =3D 39) is a MPC52xx PSC=0A=
io scheduler noop registered=0A=
io scheduler anticipatory registered=0A=
io scheduler deadline registered=0A=
io scheduler cfq registered=0A=
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize=0A=
loop: loaded (max 8 devices)=0A=
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2=0A=
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx=0A=
mpc52xx_ide: Setting up IDE interface ide0...=0A=
ocp-ohci 02: new USB bus registered, assigned bus number 1=0A=
hub 1-0:1.0: USB hub found=0A=
hub 1-0:1.0: 2 ports detected=0A=
Initializing USB Mass Storage driver...=0A=
usbcore: registered new driver usb-storage=0A=
USB Mass Storage support registered.=0A=
usbcore: registered new driver usbhid=0A=
drivers/usb/input/hid-core.c: v2.0:USB HID core driver=0A=
mice: PS/2 mouse device common for all mice=0A=
i2c /dev entries driver=0A=
i2c-algo-52xx.o: scanning bus Lite5200 I2C module #1 interface...=0A=
.........................................................................=
.......................................................=0A=
i2c-lite5200.o: I2C module #1 installed=0A=
i2c-algo-52xx.o: scanning bus Lite5200 I2C module #2 interface...=0A=
.........................................................................=
......................................................(0x7f)=0A=
i2c-lite5200.o: I2C module #2 installed=0A=
Advanced Linux Sound Architecture Driver Version 1.0.8 (Thu Jan 13 =
09:39:32 2005 UTC).=0A=
ALSA device list:=0A=
  No soundcards found.=0A=
NET: Registered protocol family 2=0A=
IP: routing cache hash table of 512 buckets, 4Kbytes=0A=
TCP established hash table entries: 4096 (order: 3, 32768 bytes)=0A=
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)=0A=
TCP: Hash tables configured (established 4096 bind 4096)=0A=
NET: Registered protocol family 1=0A=
NET: Registered protocol family 17=0A=
usb 1-1: new full speed USB device using ocp-ohci and address 2=0A=
hub 1-1:1.0: USB hub found=0A=
hub 1-1:1.0: 4 ports detected=0A=
eth0: Phy @ 0x0, type LXT971 (0x001378e2)=0A=
IP-Config: Complete:=0A=
      device=3Deth0, addr=3D10.50.40.201, mask=3D255.255.248.0, =
gw=3D10.50.40.1,=0A=
     host=3D10.50.40.201, domain=3D, nis-domain=3D(none),=0A=
     bootserver=3D10.50.40.203, rootserver=3D10.50.40.203, rootpath=3D=0A=
Looking up port of RPC 100003/2 on 10.50.40.203=0A=
Looking up port of RPC 100005/1 on 10.50.40.203=0A=
VFS: Mounted root (nfs filesystem) readonly.=0A=
Freeing unused kernel memory: 140k init=0A=
Setting hostname=0A=
hostname: /etc/hostname: No such file or directory=0A=
Setting Date=0A=
Wed Sep 10 00:00:00 GMT 2003=0A=
Mounting proc=0A=
Remounting rootfs r/w=0A=
Mounting sysfs=0A=
*** Running rc.modules=0A=
*** Running rc.serial=0A=
*** Attempting to start S15inet=0A=
Starting inetd=0A=
Done=0A=
*** Attempting to start S20network=0A=
Setting up link for loopback=0A=
Done=0A=
Setting up link for eth0=0A=
SIOCSIFNETMASK: Invalid argument=0A=
RTNETLINK answers: File exists=0A=
FAILED=0A=
*** Attempting to start S23portmap=0A=
Starting rpc.portmap=0A=
Done=0A=
*** Attempting to start S30ftp=0A=
Starting in.ftpd=0A=
Done=0A=
*** Attempting to start S30vsftpd=0A=
Starting vsftpd=0A=
Done=0A=
*** Attempting to start S90boa=0A=
bind: Address already in use=0A=
*** Running rc.local=0A=
=0A=
10.50.40.201 login: root=0A=
login[47]: root login  on `ttyS0'=0A=
=0A=
# =0A=
# =0A=
# =0A=
# =0A=
# cat /proc/bus/pci/devices =0A=
00c0	10575809	0	40000000	00000000	00000000	00000000	00000000	00000000	=
00000000	00040000	00000000	00000000	00000000	00000000	00000000	00000000	=0A=
00d0	104cac23	0	00000000	00000000	00000000	00000000	00000000	00000000	=
00000000	00000000	00000000	00000000	00000000	00000000	00000000	00000000	=0A=
0140	104c9065	0	4f000008	4f800000	00fff001	00000000	00000000	00000000	=
00000000	00400000	00800000	00000010	00000000	00000000	00000000	00000000	=0A=
# =0A=
=0A=

------=_NextPart_000_0001_01C6A5D1.97CC89F0
Content-Disposition: inline

The information contained in this electronic message and any attachments to this message are intended for the exclusive use of the addressee(s)and may contain confidential or privileged information. If you are not the intended recipient, please notify the sender or administrator@tataelxsi.co.in
------=_NextPart_000_0001_01C6A5D1.97CC89F0--
