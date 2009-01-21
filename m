Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 04B63DDDFF
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 05:37:58 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LPhxa-0004Q6-4J
	for linuxppc-dev@ozlabs.org; Wed, 21 Jan 2009 10:37:54 -0800
Message-ID: <21589420.post@talk.nabble.com>
Date: Wed, 21 Jan 2009 10:37:54 -0800 (PST)
From: wael showair <showair2003@yahoo.com>
To: linuxppc-dev@ozlabs.org
Subject: eth0: Could not attach to PHY
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi All,
i have a board with MPC8555 processor
uboot version 1.1.6
linux kernel 2.6.19-rc5
ltib version: 6.2.2-sv
gcc 3.4.3

it boots successfully
i want to upgrade my linux kernel to 2.6.27
i upgraded the following:
ltib version 8.1.2-sv
gcc 4.1
linux kernel 2.6.27
& i kept the uboot with the same version 1.1.6

the kernel booting stucks as follows:

*****************************************************************************
U-Boot 1.1.6 (Feb  8 2007 - 14:00:17)

CPU:   8555, Version: 1.1, (0x80790011)
Core:  E500, Version: 2.0, (0x80200020)
Clock Configuration:
       CPU: 833 MHz, CCB: 333 MHz,
       DDR: 166 MHz, LBC:  83 MHz
L1:    D-cache 32 kB enabled
       I-cache 32 kB enabled
Board: MPC8555AMC
I2C:   ready
DRAM:  Initializing
    DDR: 256 MB
FLASH: 16 MB
L2 cache 256KB: enabled
In:    serial
Out:   serial
Err:   serial
Net:   TSEC0, TSEC1
Hit any key to stop autoboot:  0
Speed: 100, full duplex
Using TSEC0 device
TFTP from server 172.25.25.146; our IP address is 172.25.25.150
Filename 'zImage'.
Load address: 0x1000000
Loading: #################################################################
         #################################################################
         #################################################################
         ##############################################
done
Bytes transferred = 1229983 (12c49f hex)
## Booting image at 01000000 ...
   Image Name:   Linux-2.6.27
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1229919 Bytes =  1.2 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
   Booting using flat device tree at 0xfff60000
   Loading Device Tree to 007fd000, end 007fdbad ... Using MPC85xx AMC
machine description
Memory CAM mapping: CAM0=256Mb, CAM1=0Mb, CAM2=0Mb residual: 0Mb
Linux version 2.6.27 (test@linux-i869) (gcc version 4.1.2 (Sourcery G++ Lite
4.1-78)) #1 Wed Jan 21 22:52:58 EET 2009
Found legacy serial port 0 for /soc8555@e0000000/serial@4500
  mem=e0004500, taddr=e0004500, irq=0, clk=333330000, speed=0
console [udbg0] enabled
setup_arch: bootmem
mpc85xx_amc_setup_arch()
MPC85xx AMC board from Freescale Semiconductor
arch: exit
Top of RAM: 0x10000000, Total RAM: 0x10000000
Memory hole size: 0MB
Zone PFN ranges:
  DMA      0x00000000 -> 0x00010000
  Normal   0x00010000 -> 0x00010000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00010000
On node 0 totalpages: 65536
free_area_init_node: node 0, pgdat c0278be4, node_mem_map c0297000
  DMA zone: 65024 pages, LIFO batch:15
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: root=/dev/nfs rw
nfsroot=172.25.25.146:/exports/freescale1_rootfs ip=dhcp
console=ttyS0,115200
mpic: Setting up MPIC " OpenPIC  " version 1.2 at e0040000, max 1 CPUs
mpic: ISU size: 4, shift: 2, mask: 3
mpic: Initializing for 60 sources
PID hash table entries: 1024 (order: 10, 4096 bytes)
time_init: decrementer frequency = 41.666250 MHz
time_init: processor frequency   = 833.325000 MHz
clocksource: timebase mult[60003ef] shift[22] registered
clockevent: decrementer mult[aaa] shift[16] cpu[0]
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 256896k/262144k available (2440k kernel code, 4936k reserved, 96k
data, 88k bss, 140k init)
Calibrating delay loop... 83.20 BogoMIPS (lpj=166400)
Mount-cache hash table entries: 512
device-tree: Duplicate name in /, renamed to "chosen#1"
net_namespace: 288 bytes
NET: Registered protocol family 16

rstcr compatible register does not exist!
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
NET: Registered protocol family 1
JFFS2 version 2.2. (NAND)  2001-2006 Red Hat, Inc.
msgmni has been set to 502
io scheduler noop registered (default)
Generic RTC Driver v1.07
Serial: 8250/16550 driver4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 26) is a 16550A
                                                             console
handover: boot [udbg0] -> real [ttyS0]
brd: module loaded
loop: module loaded
eth0: Gianfar Ethernet Controller Version 1.2, 00:14:85:a7:72:1b
eth0: Running with NAPI enabled
eth0: 256/256 RX/TX BD ring size
eth1: Gianfar Ethernet Controller Version 1.2, 00:00:00:00:00:00
eth1: Running with NAPI enabled
eth1: 256/256 RX/TX BD ring size
physmap platform flash device: 01000000 at ff000000
physmap-flash.0: Found 2 x16 devices at 0x0 in 32-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
physmap-flash.0: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
RedBoot partition parsing not available
i2c /dev entries driver
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
24520:10 not found
eth0: Could not attach to PHY
IP-Config: Failed to open eth0
IP-Config: Failed to open eth1
IP-Config: No network devices available.
Looking up port of RPC 100003/2 on 172.25.25.146
rpcbind: server 172.25.25.146 not responding, timed out

******************************************************************************

i have seen this error message across the mailing list but i reached
nothing,
i m sure the dts is correct since i boot kernel version 2.6.19-rc5
successfully
i did not change the dts & ikeep it
is there any hint to solve this bug?

thanks in advance for ur help

-- 
View this message in context: http://www.nabble.com/eth0%3A-Could-not-attach-to-PHY-tp21589420p21589420.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
