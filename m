Return-Path: <stevewin@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F1CDDDDE39
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Jun 2007 05:02:16 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5PJ2DJt006787
	for <linuxppc-embedded@ozlabs.org>; Mon, 25 Jun 2007 15:02:13 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l5PJ2CI2226372
	for <linuxppc-embedded@ozlabs.org>; Mon, 25 Jun 2007 13:02:12 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l5PJ2B9N019009
	for <linuxppc-embedded@ozlabs.org>; Mon, 25 Jun 2007 13:02:11 -0600
Received: from d03nm125.boulder.ibm.com (d03nm125.boulder.ibm.com
	[9.17.195.151])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l5PJ2B92019002
	for <linuxppc-embedded@ozlabs.org>; Mon, 25 Jun 2007 13:02:11 -0600
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Subject: Katmai w/ DENX git - "init has generated signal 4" error
Message-ID: <OF6593F764.1D9AA110-ON87257305.0067371E-85257305.00688AB4@us.ibm.com>
From: Stephen Winiecki <stevewin@us.ibm.com>
Date: Mon, 25 Jun 2007 15:03:34 -0400
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm using the Denx linux-2.6-denx.git repository with a Katmai board.   I 
want to boot off a disk (initialized w/ Debian 4.0).  I've installed a 
Promise Ultra133 Tx2 IDE controller card in the PCI slot, and configured 
it in the kernel.    I boot this same disk w/ IDE card on other 4xx boards 
without a problem (Bamboo w/ Denx 4.1 for example).  I am getting an error 
"init has generated signal 4 but has no handler for it".

## Booting image at 00200000 ...
   Image Name:   Linux-2.6.22-rc5-gc8144983-dirty
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1328285 Bytes =  1.3 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.6.22-rc5-gc8144983-dirty (root@cellhost.raleigh.ibm.com) 
(gcc ve
rsion 4.0.0 (DENX ELDK 4.1 4.0.0)) #4 Mon Jun 25 13:59:54 EDT 2007
AMCC PowerPC 440SPe Katmai Platform
Zone PFN ranges:
  DMA             0 ->   131072
  Normal     131072 ->   131072
early_node_map[1] active PFN ranges
    0:        0 ->   131072
Built 1 zonelists.  Total pages: 130048
Kernel command line: console=ttyS0,115200 root=/dev/hde3 rw ip=dhcp
PID hash table entries: 2048 (order: 11, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 516864k available (2008k kernel code, 676k data, 160k init, 0k 
highmem)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
PCI: Probing PCI hardware
SCSI subsystem initialized
NET: Registered protocol family 2
IP route cache hash table entries: 16384 (order: 4, 65536 bytes)
TCP established hash table entries: 65536 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 65536 bind 65536)
TCP reno registered
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Generic RTC Driver v1.07
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at MMIO 0x0 (irq = 0) is a 16550A
serial8250: ttyS1 at MMIO 0x0 (irq = 1) is a 16550A
serial8250: ttyS2 at MMIO 0x0 (irq = 37) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
xsysace xsysace.0: Xilinx SystemACE revision 1.0.12
xsysace xsysace.0: capacity: 256512 sectors
 xsa: xsa1
Intel(R) PRO/1000 Network Driver - version 7.3.20-k2
Copyright (c) 1999-2006 Intel Corporation.
PPC 4xx OCP EMAC driver, version 3.54
mal0: initialized, 1 TX channels, 1 RX channels
eth0: emac0, MAC 00:01:73:77:55:27
eth0: found Generic MII PHY (0x01)
e100: Intel(R) PRO/100 Network Driver, 3.5.17-k4-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
PDC20269: IDE controller at PCI slot 0000:00:01.0
PDC20269: chipset revision 2
PDC20269: ROM enabled at 0x000dc000
PDC20269: PLL input clock is 33309 kHz
PDC20269: 100% native mode on irq 52
    ide2: BM-DMA at 0xffd0-0xffd7, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xffd8-0xffdf, BIOS settings: hdg:pio, hdh:pio
hde: FUJITSU MHT2040AH, ATA DISK drive
hde: host side 80-wire cable detection failed, limiting max speed to 
UDMA33
ide2 at 0xfff8-0xffff,0xfff6 on irq 52
hde: max request size: 128KiB
hde: 78140160 sectors (40007 MB) w/8192KiB Cache, CHS=65535/16/63, 
UDMA(33)
hde: cache flushes supported
 hde: hde1 hde2 hde3
i2c /dev entries driver
IBM IIC driver v2.1
ibm-iic0: using standard (100 kHz) mode
ds1307 1-0068: rtc core: registered ds1307 as rtc0
ibm-iic1: using standard (100 kHz) mode
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
ds1307 1-0068: setting the system clock to 2000-04-30 08:13:25 (957082405)
eth0: link is up, 100 FDX
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 255.255.255.255, my address is 
9.27.218.226
IP-Config: Complete:
      device=eth0, addr=9.27.218.226, mask=255.255.255.128, 
gw=9.27.218.129,
     host=9.27.218.226, domain=raleigh.ibm.com, nis-domain=(none),
     bootserver=255.255.255.255, rootserver=255.255.255.255, rootpath=
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hde3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem).
Freeing unused kernel memory: 160k init
init has generated signal 4 but has no handler for it
Kernel panic - not syncing: Attempted to kill init!
Rebooting in 180 seconds..

Not sure if I'm missing something obvious - any help appreciated.

Thanks,

Steve
