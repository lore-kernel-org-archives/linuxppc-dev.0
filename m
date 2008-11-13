Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id D994EDDDE7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Nov 2008 02:14:45 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1L0du6-0007FZ-MO
	for linuxppc-embedded@ozlabs.org; Thu, 13 Nov 2008 07:14:42 -0800
Message-ID: <20481642.post@talk.nabble.com>
Date: Thu, 13 Nov 2008 07:14:42 -0800 (PST)
From: saadia dhouib <saadia_dhouib@yahoo.fr>
To: linuxppc-embedded@ozlabs.org
Subject: ifconfig: SIOCSIFNETMASK: No such device (xupv2p+ppc+linux 2.6.27-rc)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all,
I have installed the latest linux 2.6 version from xilinx tree. 
I have selected the following networking options: 
http://www.nabble.com/file/p20481642/Screenshot-7.png Screenshot-7.png 
And selected : Network device support:  Ethernet (10 or 100Mbit)  ---> 
                                                                                                 
Generic Media Independent Interface device support   
                                                                                                 
Xilinx 10/100 OPB EMAC support
 Ethernet (1000 Mbit)  --->    
                                      Xilinx LLTEMAC 10/100/1000 Ethernet
MAC driver 

I booted the kernel with rfs on ramdisk:
zImage starting: loaded at 0x00400000 (sp: 0x006fdefc)
Allocating 0x3571b4 bytes for kernel ...
gunzipping (0x00000000 <- 0x0040c000:0x0058ccc3)...done 0x3345e8 bytes
Attached initrd image at 0x0058d000-0x006fcf20
initrd head: 0x1f8b0808

Linux/PowerPC load: console=ttyUL0,9600 root=/dev/ram rw ip=on
Finalizing device tree... flat tree at 0x40ae18
Using Xilinx Virtex machine description
Linux version 2.6.27-rc9 (dhouib@lo-lester-030) (gcc version 3.4.5) #34
PREEMPT Thu Nov 13 15:53:38 CET 2008
Found initrd at 0xc058d000:0xc06fcf20
Zone PFN ranges:
  DMA      0x00000000 -> 0x00010000
  Normal   0x00010000 -> 0x00010000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00010000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: console=ttyUL0,9600 root=/dev/ram rw ip=on
Xilinx intc at 0x41200000 mapped to 0xfdfff000
PID hash table entries: 1024 (order: 10, 4096 bytes)
clocksource: timebase mult[d55555] shift[22] registered
Console: colour dummy device 80x25
console [ttyUL0] enabled
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 254652k/262144k available (3124k kernel code, 7176k reserved, 128k
data, 136k bss, 156k init)
Calibrating delay loop... 598.01 BogoMIPS (lpj=1196032)
Mount-cache hash table entries: 512
net_namespace: 756 bytes
NET: Registered protocol family 16
PCI: Probing PCI hardware
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
NET: Registered protocol family 1
checking if image is initramfs...it isn't (no cpio magic); looks like an
initrd
Freeing initrd memory: 1471k freed
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
msgmni has been set to 500
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver4 ports, IRQ sharing disabled
40600000.serial: ttyUL0 at MMIO 0x40600003 (irq = 16) is a uartlite
brd: module loaded
loop: module loaded
Device Tree Probing 'ethernet'
xilinx_emac 40c00000.ethernet: no IRQ found.
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
IP-Config: No network devices available.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memor### Application running ...
root:~> ifconfig 
lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

root:~> ifconfig 172.25.49.123 netmask 255.255.255.0
ifconfig: SIOCSIFNETMASK: No such device
root:~> ### Application running ...



My question is: why I can't assign an IP address ??

Thanks
Saadia
                             
 


-- 
View this message in context: http://www.nabble.com/ifconfig%3A-SIOCSIFNETMASK%3A-No-such-device-%28xupv2p%2Bppc%2Blinux-2.6.27-rc%29-tp20481642p20481642.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
