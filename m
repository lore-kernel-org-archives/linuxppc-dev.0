Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc2-s16.bay0.hotmail.com (bay0-omc2-s16.bay0.hotmail.com
	[65.54.246.152]) by ozlabs.org (Postfix) with ESMTP id 87C17DE076
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Apr 2008 01:16:46 +1100 (EST)
Message-ID: <BAY138-W7044A57F2CF37F5DB50F6B2F50@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_22c3817e-0c93-4b05-8295-7077997f810a_"
From: MingLiu <eemingliu@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: xilinx Ml405 NFS mount problem
Date: Tue, 1 Apr 2008 14:11:30 +0000
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--_22c3817e-0c93-4b05-8295-7077997f810a_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Dear friends,I am bringing up my kernel from Xilinx git tree. Unfortunately I met some
problem when mounting the root file system. Here is the information
listed. I will appreciate a lot if someone can help me out of the trouble. 
Thanks a lot!


loaded at:     00400000 0059F19C
board data at: 0059D120 0059D19C
relocated to:  004050C8 00405144
zimage at:     00405F3F 0059C025
avail ram:     005A0000 08000000

Linux/PPC load: root=/dev/nfs
ip=192.168.0.4:192.168.0.3:192.168.0.3:255.255.255.0 rw
nfsroot=192.168.0.3:/home/mingliu/ml403_rootfs console=ttyUL0,38400
mem=32M
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.6.24-rc8-xlnx-g1db182b8-dirty (mingliu@cca01) (gcc version
3.4.1) #7 Tue Apr 1 14:55:25 CEST 2008
Xilinx Generic PowerPC board support package (Xilinx ML405) (Virtex-4 FX)
Zone PFN ranges:
  DMA             0 ->     8192
  Normal       8192 ->     8192
  HighMem      8192 ->     8192
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->     8192
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 8128
Kernel command line: root=/dev/nfs
ip=192.168.0.4:192.168.0.3:192.168.0.3:255.255.255.0 rw
nfsroot=192.168.0.3:/home/mingliu/ml403_rootfs console=ttyUL0,38400
mem=32M
Xilinx INTC #0 at 0x81800000 mapped to 0xFDFFF000
PID hash table entries: 128 (order: 7, 512 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 28884k available (2552k kernel code, 944k data, 84k init, 0k highmem)
SLUB: Genslabs=11, HWalign=32, Order=0-1, MinObjects=4, CPUs=1, Nodes=1
Mount-cache hash table entries: 512
net_namespace: 64 bytes
NET: Registered protocol family 16
Registering device uartlite:0
Fixup MAC address for xilinx_lltemac:0
Registering device xilinx_lltemac:0
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 1024 (order: 1, 8192 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
TCP reno registered
sysctl table check failed: /kernel/l2cr .1.31 Missing strategy
Call Trace:
[c1c0fe50] [c0008b70] show_stack+0x40/0x194 (unreliable)
[c1c0fe90] [c003aed4] set_fail+0x68/0x80
[c1c0feb0] [c003b4ec] sysctl_check_table+0x600/0x77c
[c1c0fef0] [c003b4d4] sysctl_check_table+0x5e8/0x77c
[c1c0ff30] [c002605c] register_sysctl_table+0x64/0xb4
[c1c0ff50] [c034579c] register_ppc_htab_sysctl+0x18/0x2c
[c1c0ff60] [c034482c] kernel_init+0x94/0x2bc
[c1c0fff0] [c0004d58] kernel_thread+0x44/0x60
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
fuse init (API version 7.9)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
uartlite.0: ttyUL0 at MMIO 0x84000003 (irq = 3) is a uartlite
console [ttyUL0] enabled
loop: module loaded
nbd: registered device at major 43
xilinx_lltemac xilinx_lltemac.0: MAC address is now  0: a:35: 1: 2: 3
xilinx_lltemac xilinx_lltemac.0: XLlTemac: using DMA mode.
XLlTemac: Dma base address: phy: 0x84600100, virt: 0xc3008100
XLlTemac: buffer descriptor size: 32768 (0x8000)
XLlTemac: Allocating DMA descriptors with kmalloc<6>XLlTemac:
(buffer_descriptor_init) phy: 0x1d18000, virt: 0xc1d18000, size: 0x8000
XTemac: PHY detected at address 7.
xilinx_lltemac xilinx_lltemac.0: eth0: Xilinx TEMAC at 0x81C00000 mapped
to 0xC3004000, irq=2
console [netcon0] enabled
Linux version 2.6.24-rc8-xlnx-g1db182b8-dirty (mingliu@cca01) (gcc version
3.4.1) #7 Tue Apr 1 14:55:25 CEST 2008
Xilinx Generic PowerPC board support package (Xilinx ML405) (Virtex-4 FX)
Zone PFN ranges:
  DMA             0 ->     8192
  Normal       8192 ->     8192
  HighMem      8192 ->     8192
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->     8192
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 8128
Kernel command line: root=/dev/nfs
ip=192.168.0.4:192.168.0.3:192.168.0.3:255.255.255.0 rw
nfsroot=192.168.0.3:/home/mingliu/ml403_rootfs console=ttyUL0,38400
mem=32M
Xilinx INTC #0 at 0x81800000 mapped to 0xFDFFF000
PID hash table entries: 128 (order: 7, 512 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 28884k available (2552k kernel code, 944k data, 84k init, 0k highmem)
SLUB: Genslabs=11, HWalign=32, Order=0-1, MinObjects=4, CPUs=1, Nodes=1
Mount-cache hash table entries: 512
net_namespace: 64 bytes
NET: Registered protocol family 16
Registering device uartlite:0
Fixup MAC address for xilinx_lltemac:0
Registering device xilinx_lltemac:0
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 1024 (order: 1, 8192 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
TCP reno registered
sysctl table check failed: /kernel/l2cr .1.31 Missing strategy
Call Trace:
[c1c0fe50] [c0008b70] show_stack+0x40/0x194 (unreliable)
[c1c0fe90] [c003aed4] set_fail+0x68/0x80
[c1c0feb0] [c003b4ec] sysctl_check_table+0x600/0x77c
[c1c0fef0] [c003b4d4] sysctl_check_table+0x5e8/0x77c
[c1c0ff30] [c002605c] register_sysctl_table+0x64/0xb4
[c1c0ff50] [c034579c] register_ppc_htab_sysctl+0x18/0x2c
[c1c0ff60] [c034482c] kernel_init+0x94/0x2bc
[c1c0fff0] [c0004d58] kernel_thread+0x44/0x60
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
fuse init (API version 7.9)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
uartlite.0: ttyUL0 at MMIO 0x84000003 (irq = 3) is a uartlite
console [ttyUL0] enabled
loop: module loaded
nbd: registered device at major 43
xilinx_lltemac xilinx_lltemac.0: MAC address is now  0: a:35: 1: 2: 3
xilinx_lltemac xilinx_lltemac.0: XLlTemac: using DMA mode.
XLlTemac: Dma base address: phy: 0x84600100, virt: 0xc3008100
XLlTemac: buffer descriptor size: 32768 (0x8000)
XLlTemac: Allocating DMA descriptors with kmalloc<6>XLlTemac:
(buffer_descriptor_init) phy: 0x1d18000, virt: 0xc1d18000, size: 0x8000
XTemac: PHY detected at address 7.
xilinx_lltemac xilinx_lltemac.0: eth0: Xilinx TEMAC at 0x81C00000 mapped
to 0xC3004000, irq=2
console [netcon0] enabled
netconsole: network logging started
Generic platform RAM MTD, (c) 2004 Simtec Electronics
mice: PS/2 mouse device common for all mice
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
eth0: XLlTemac: Options: 0x3fa
eth0: XLlTemac: allocating interrupt 0 for dma mode tx.
eth0: XLlTemac: allocating interrupt 1 for dma mode rx.
eth0: XLlTemac: speed set to 1000Mb/s
eth0: XLlTemac: Send Threshold = 24, Receive Threshold = 4
eth0: XLlTemac: Send Wait bound = 254, Receive Wait bound = 254
IP-Config: Complete:
      device=eth0, addr=192.168.0.4, mask=255.255.255.0, gw=192.168.0.3,
     host=192.168.0.4, domain=, nis-domain=(none),
     bootserver=192.168.0.3, rootserver=192.168.0.3, rootpath=
Looking up port of RPC 100003/2 on 192.168.0.3
rpcbind: server 192.168.0.3 not responding, timed out
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 192.168.0.3
rpcbind: server 192.168.0.3 not responding, timed out
Root-NFS: Unable to get mountd port number from server, using default
mount: server 192.168.0.3 not responding, timed out
Root-NFS: Server returned error -5 while mounting /home/mingliu/ml403_rootfs
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "nfs" or unknown-block(2,0)
Please append a correct "root=" boot option; here are the available
partitions:
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(2,0)
Rebooting in 180 seconds..


BR
Ming
_________________________________________________________________
用手机MSN聊天写邮件看空间，无限沟通，分享精彩！
http://mobile.msn.com.cn/
--_22c3817e-0c93-4b05-8295-7077997f810a_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
FONT-SIZE: 9pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body class='hmmessage'>
Dear friends,<BR><PRE>I am bringing up my kernel from Xilinx git tree. Unfortunately I met some
problem when mounting the root file system. Here is the information
listed. I will appreciate a lot if someone can help me out of the trouble. 
</PRE><PRE>Thanks a lot!


loaded at:     00400000 0059F19C
board data at: 0059D120 0059D19C
relocated to:  004050C8 00405144
zimage at:     00405F3F 0059C025
avail ram:     005A0000 08000000

Linux/PPC load: root=/dev/nfs
ip=192.168.0.4:192.168.0.3:192.168.0.3:255.255.255.0 rw
nfsroot=192.168.0.3:/home/mingliu/ml403_rootfs console=ttyUL0,38400
mem=32M
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.6.24-rc8-xlnx-g1db182b8-dirty (mingliu@cca01) (gcc version
3.4.1) #7 Tue Apr 1 14:55:25 CEST 2008
Xilinx Generic PowerPC board support package (Xilinx ML405) (Virtex-4 FX)
Zone PFN ranges:
  DMA             0 -&gt;     8192
  Normal       8192 -&gt;     8192
  HighMem      8192 -&gt;     8192
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 -&gt;     8192
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 8128
Kernel command line: root=/dev/nfs
ip=192.168.0.4:192.168.0.3:192.168.0.3:255.255.255.0 rw
nfsroot=192.168.0.3:/home/mingliu/ml403_rootfs console=ttyUL0,38400
mem=32M
Xilinx INTC #0 at 0x81800000 mapped to 0xFDFFF000
PID hash table entries: 128 (order: 7, 512 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 28884k available (2552k kernel code, 944k data, 84k init, 0k highmem)
SLUB: Genslabs=11, HWalign=32, Order=0-1, MinObjects=4, CPUs=1, Nodes=1
Mount-cache hash table entries: 512
net_namespace: 64 bytes
NET: Registered protocol family 16
Registering device uartlite:0
Fixup MAC address for xilinx_lltemac:0
Registering device xilinx_lltemac:0
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 1024 (order: 1, 8192 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
TCP reno registered
sysctl table check failed: /kernel/l2cr .1.31 Missing strategy
Call Trace:
[c1c0fe50] [c0008b70] show_stack+0x40/0x194 (unreliable)
[c1c0fe90] [c003aed4] set_fail+0x68/0x80
[c1c0feb0] [c003b4ec] sysctl_check_table+0x600/0x77c
[c1c0fef0] [c003b4d4] sysctl_check_table+0x5e8/0x77c
[c1c0ff30] [c002605c] register_sysctl_table+0x64/0xb4
[c1c0ff50] [c034579c] register_ppc_htab_sysctl+0x18/0x2c
[c1c0ff60] [c034482c] kernel_init+0x94/0x2bc
[c1c0fff0] [c0004d58] kernel_thread+0x44/0x60
Installing knfsd (copyright (C) 1996 <A href="https://webmail.sys.kth.se/src/compose.php?send_to=okir%40monad.swb.de"><U><FONT color=#0000ff>okir@monad.swb.de</FONT></U></A>).
fuse init (API version 7.9)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
uartlite.0: ttyUL0 at MMIO 0x84000003 (irq = 3) is a uartlite
console [ttyUL0] enabled
loop: module loaded
nbd: registered device at major 43
xilinx_lltemac xilinx_lltemac.0: MAC address is now  0: a:35: 1: 2: 3
xilinx_lltemac xilinx_lltemac.0: XLlTemac: using DMA mode.
XLlTemac: Dma base address: phy: 0x84600100, virt: 0xc3008100
XLlTemac: buffer descriptor size: 32768 (0x8000)
XLlTemac: Allocating DMA descriptors with kmalloc&lt;6&gt;XLlTemac:
(buffer_descriptor_init) phy: 0x1d18000, virt: 0xc1d18000, size: 0x8000
XTemac: PHY detected at address 7.
xilinx_lltemac xilinx_lltemac.0: eth0: Xilinx TEMAC at 0x81C00000 mapped
to 0xC3004000, irq=2
console [netcon0] enabled
Linux version 2.6.24-rc8-xlnx-g1db182b8-dirty (mingliu@cca01) (gcc version
3.4.1) #7 Tue Apr 1 14:55:25 CEST 2008
Xilinx Generic PowerPC board support package (Xilinx ML405) (Virtex-4 FX)
Zone PFN ranges:
  DMA             0 -&gt;     8192
  Normal       8192 -&gt;     8192
  HighMem      8192 -&gt;     8192
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 -&gt;     8192
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 8128
Kernel command line: root=/dev/nfs
ip=192.168.0.4:192.168.0.3:192.168.0.3:255.255.255.0 rw
nfsroot=192.168.0.3:/home/mingliu/ml403_rootfs console=ttyUL0,38400
mem=32M
Xilinx INTC #0 at 0x81800000 mapped to 0xFDFFF000
PID hash table entries: 128 (order: 7, 512 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 28884k available (2552k kernel code, 944k data, 84k init, 0k highmem)
SLUB: Genslabs=11, HWalign=32, Order=0-1, MinObjects=4, CPUs=1, Nodes=1
Mount-cache hash table entries: 512
net_namespace: 64 bytes
NET: Registered protocol family 16
Registering device uartlite:0
Fixup MAC address for xilinx_lltemac:0
Registering device xilinx_lltemac:0
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 1024 (order: 1, 8192 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
TCP reno registered
sysctl table check failed: /kernel/l2cr .1.31 Missing strategy
Call Trace:
[c1c0fe50] [c0008b70] show_stack+0x40/0x194 (unreliable)
[c1c0fe90] [c003aed4] set_fail+0x68/0x80
[c1c0feb0] [c003b4ec] sysctl_check_table+0x600/0x77c
[c1c0fef0] [c003b4d4] sysctl_check_table+0x5e8/0x77c
[c1c0ff30] [c002605c] register_sysctl_table+0x64/0xb4
[c1c0ff50] [c034579c] register_ppc_htab_sysctl+0x18/0x2c
[c1c0ff60] [c034482c] kernel_init+0x94/0x2bc
[c1c0fff0] [c0004d58] kernel_thread+0x44/0x60
Installing knfsd (copyright (C) 1996 <A href="https://webmail.sys.kth.se/src/compose.php?send_to=okir%40monad.swb.de"><U><FONT color=#0000ff>okir@monad.swb.de</FONT></U></A>).
fuse init (API version 7.9)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
uartlite.0: ttyUL0 at MMIO 0x84000003 (irq = 3) is a uartlite
console [ttyUL0] enabled
loop: module loaded
nbd: registered device at major 43
xilinx_lltemac xilinx_lltemac.0: MAC address is now  0: a:35: 1: 2: 3
xilinx_lltemac xilinx_lltemac.0: XLlTemac: using DMA mode.
XLlTemac: Dma base address: phy: 0x84600100, virt: 0xc3008100
XLlTemac: buffer descriptor size: 32768 (0x8000)
XLlTemac: Allocating DMA descriptors with kmalloc&lt;6&gt;XLlTemac:
(buffer_descriptor_init) phy: 0x1d18000, virt: 0xc1d18000, size: 0x8000
XTemac: PHY detected at address 7.
xilinx_lltemac xilinx_lltemac.0: eth0: Xilinx TEMAC at 0x81C00000 mapped
to 0xC3004000, irq=2
console [netcon0] enabled
netconsole: network logging started
Generic platform RAM MTD, (c) 2004 Simtec Electronics
mice: PS/2 mouse device common for all mice
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
eth0: XLlTemac: Options: 0x3fa
eth0: XLlTemac: allocating interrupt 0 for dma mode tx.
eth0: XLlTemac: allocating interrupt 1 for dma mode rx.
eth0: XLlTemac: speed set to 1000Mb/s
eth0: XLlTemac: Send Threshold = 24, Receive Threshold = 4
eth0: XLlTemac: Send Wait bound = 254, Receive Wait bound = 254
IP-Config: Complete:
      device=eth0, addr=192.168.0.4, mask=255.255.255.0, gw=192.168.0.3,
     host=192.168.0.4, domain=, nis-domain=(none),
     bootserver=192.168.0.3, rootserver=192.168.0.3, rootpath=
Looking up port of RPC 100003/2 on 192.168.0.3
rpcbind: server 192.168.0.3 not responding, timed out
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 192.168.0.3
rpcbind: server 192.168.0.3 not responding, timed out
Root-NFS: Unable to get mountd port number from server, using default
mount: server 192.168.0.3 not responding, timed out
Root-NFS: Server returned error -5 while mounting /home/mingliu/ml403_rootfs
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "nfs" or unknown-block(2,0)
Please append a correct "root=" boot option; here are the available
partitions:
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(2,0)
Rebooting in 180 seconds..


BR
Ming</PRE><br /><hr />Windows Live Writer，支持离线撰写博客内容，随时随地想写就写。 <a href='http://get.live.cn/product/writer.html' target='_new'>立即使用！</a></body>
</html>
--_22c3817e-0c93-4b05-8295-7077997f810a_--
