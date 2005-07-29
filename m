Return-Path: <deboralh@fel.com.cn>
Received: from sina37-40.sina.com.cn (sina37-40.sina.net [202.108.37.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "securemail.sina.net",
	Issuer "VeriSign Trust Network" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1B5A467DE0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Jul 2005 20:31:24 +1000 (EST)
Date: Fri, 29 Jul 2005 18:27:45 +0800
From: "Debora Liu" <deboralh@fel.com.cn>
To: "linuxppc-embedde" <Linuxppc-embedded@ozlabs.org>
Message-Id: <20050729103124.1B5A467DE0@ozlabs.org>
Subject: mpc8245-300M MIPS
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

linuxppc-embeddeHi ALL,
	I am porting MPC8245 kernel-2.4.25 from ELDK version 3.1.1.
	This CPU(MPC8245) is 300MHz, kernel calibrate MIPS is 200.
	Do anyone know this MIPS is right?


U-Boot 1.1.2 (Jan 25 2005 - 14:55:00) [svm]

CPU:   MPC8245 Revision 1.1 at 299.999 MHz: 16 kB I-Cache 16 kB D-Cache
Board: SVM_SC8245 Local Bus at 99.999 MHz
I2C:   ready
DRAM:  Scan SDRAM memory........................
64 MB
Top of RAM usable for U-Boot at: 04000000
Reserving 460k for U-Boot at: 03f8c000
Reserving 128k for malloc() at: 03f6c000
Reserving 56 Bytes for Board Info at: 03f6bfc8
Reserving 48 Bytes for Global Data at: 03f6bf98
Stack Pointer at: 03f6bf78
New Stack Pointer is: 03f6bf78
Now running in RAM - U-Boot at: 03f8c000
FLASH: 512 kB
PCI Scan: Found Bus 0, Device 22, Function 0
PCI Config: I/O=0x80000000, Memory=0x80000000, Command=0x7
       00  16  10ec  8139  0200  0b
PCI Scan: Found Bus 0, Device 23, Function 0
PCI Config: I/O=0x81000000, Memory=0x81000000, Command=0x7
       00  17  8086  1209  0200  0c
PCI Scan: Found Bus 0, Device 24, Function 0
       00  18  8086  1209  0200  0e
In:    serial
Out:   serial
Err:   serial
U-Boot relocated to 03f8c000
DOC:   No DiskOnChip found
Net:   rtl8139: REALTEK RTL8139 @0x80000000(80000000)
i82559#0
Warning: i82559#0 MAC addresses don't match:
Address in SROM is         00:AA:00:91:6D:94
Address in environment is  EE:CC:7C:7E:65:97
, i82559#1, RTL8139#0
### main_loop entered: bootdelay=2

### main_loop: bootcmd="tftpboot 0x210000 kernel-sc82xx-2.4.25-eldk;bootm 0x2100
00"
Hit any key to stop autoboot:  0
Trying i82559#0
Using i82559#0 device
TFTP from server 192.168.0.82; our IP address is 192.168.0.215
Filename 'kernel-sc82xx-2.4.25-eldk'.
Load address: 0x210000
Loading: #################################################################
        #################################################################
        ###########
done
Bytes transferred = 718901 (af835 hex)
## Booting image at 00210000 ...
  Image Name:   Linux-2.4.25
  Created:      2005-07-29   5:42:02 UTC
  Image Type:   PowerPC Linux Kernel Image (gzip compressed)
  Data Size:    718837 Bytes = 702 kB
  Load Address: 00000000
  Entry Point:  00000000
  Verifying Checksum ... OK
  Uncompressing Kernel Image ... OK
## Current stack ends at 0x03F6BBE8 => set upper limit to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFF7E
bd address  = 0x03F6BFC8
memstart    = 0x00000000
memsize     = 0x04000000
flashstart  = 0xFFF00000
flashsize   = 0x00080000
flashoffset = 0x00068000
sramstart   = 0x00000000
sramsize    = 0x00000000
bootflags   = 0x00000001
intfreq     = 299.999 MHz
busfreq     = 99.999 MHz
ethaddr     = EE:CC:7C:7E:65:97
IP addr     = 192.168.0.215
baudrate    = 115200 bps
No initrd
## Transferring control to Linux (at address 00000000) ...
Memory BAT mapping: BAT2=64Mb, BAT3=0Mb, residual: 0Mb
Linux version 2.4.25 (liu@bighead) (gcc version 3.3.3 (DENX ELDK 3.1.1 3.3.3-9))
#2 ? 7? 29 13:41:52 CST 2005
sc82xx_setup_arch:Reserved 0x10000 memory at 0xc01b4000
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw nfsroot=192.168.0.82:/prj/sc8245/root cons
ole=ttyS0,115200 ip=192.168.0.215:192.168.0.82:::itogether:eth0:off
OpenPIC Version 1.2 (1 CPUs and 7 IRQ sources) at fdfd0000
bi_intfreq:299999997  bi_busfreq:99999999
Calibrating delay loop... 199.88 BogoMIPS

        Debora Liu
        deboralh@fel.com.cn
          2005-07-29
