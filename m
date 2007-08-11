Return-Path: <poorbeyond@163.com>
Received: from m5-81.163.com (m5-81.163.com [202.108.5.81])
	by ozlabs.org (Postfix) with SMTP id EE5CCDDF4A
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 12 Aug 2007 00:28:35 +1000 (EST)
Date: Sat, 11 Aug 2007 22:13:51 +0800
From: "poorbeyond" <poorbeyond@163.com>
To: "Linux-ppc mail list" <linuxppc-embedded@ozlabs.org>
Subject: my kernel start info prompt: "Badness at
	arch/ppc/kernel/dma-mapping.c:345", inside the mail is the detail
Message-ID: <200708112213490314532@163.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=====003_Dragon301211423074_====="
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

--=====003_Dragon301211423074_=====
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

my cpu is mpc860, kernel is 2.6.20.14, use arch/ppc.

the attachment is my kernel config file, is something wrong?

the following is kernel start info:


^_^=>bootm 300000

## Booting image at 00300000 ...
   Image Name:   Linux-2.6.20.14
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    840127 Bytes = 820.4 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x01D5DB10 => set upper limit to 0x00800000
No initrd
## Transferring control to Linux (at address 00000000) ...
bootm1
Linux version 2.6.20.14 (root@localhost.localdomain) (gcc version 4.0.0 (DENX ELDK 4.0 4.0.0)) #1 PREEMPT Sat Aug 11 19:58:59 CST 2007
I2C/SPI/SMC1 microcode patch installed.
Zone PFN ranges:
  DMA             0 ->     2048
  Normal       2048 ->     2048
early_node_map[1] active PFN ranges
    0:        0 ->     2048
Built 1 zonelists.  Total pages: 2032
Kernel command line: 
PID hash table entries: 32 (order: 5, 128 bytes)
Decrementer Frequency = 187500000/60
Warning: real time clock seems stuck!
cpm_uart: console: compat mode
Dentry cache hash table entries: 1024 (order: 0, 4096 bytes)
Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
Memory: 6220k available (1264k kernel code, 536k data, 84k init, 0k highmem)
Mount-cache hash table entries: 512
Zq001: start_kernel
------------[ cut here ]------------
Badness at arch/ppc/kernel/dma-mapping.c:345
Call Trace:
[00205E60] [00008DB0]  (unreliable)
[00205E90] [000A38D8] 
[00205EA0] [00003D28] 
[00205ED0] [0000308C] 
[00205F90] [001A4600] 
[00205FA0] [000022DC] 
[00205FF0] [00004B40] 
NET: Registered protocol family 16
Generic PHY: Registered new driver
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 256 (order: 0, 4096 bytes)
TCP bind hash table entries: 128 (order: -1, 2560 bytes)
TCP: Hash tables configured (established 256 bind 128)
TCP reno registered
audit: initializing netlink socket (disabled)
audit(4294836223.222:1): initialized
audit: cannot initialize inotify handle
io scheduler noop registered (default)
Serial: CPM driver $Revision: 0.02 $
cpm_uart: WARNING: no UART devices found on platform bus!
cpm_uart: the driver will guess configuration, but this mode is no longer supported.
ttyCPM0 at MMIO 0xff000a80 (irq = 20) is a CPM UART
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
LXT970: Registered new driver
LXT971: Registered new driver
fs_enet.c:v1.0 (Aug 8, 2005)
------------[ cut here ]------------
kernel BUG at arch/ppc/kernel/dma-mapping.c:233!
Oops: Exception in kernel mode, sig: 5 [#1]
PREEMPT 
NIP: 00005644 LR: 000055F8 CTR: 00000000
REGS: 00205e90 TRAP: 0700   Not tainted  (2.6.20.14)
MSR: 00029032 <EE,ME,IR,DR>  CR: 55222253  XER: A000247F
TASK = 00202ba0[1] 'swapper' THREAD: 00204000
GPR00: 00400165 00205F40 00202BA0 001DFBA4 00000000 00000BDA 0025BFFC 00000000 
GPR08: 00162648 00000001 00401000 00400164 00000000 41082205 02000000 00000001 
GPR16: 00000000 01FFFA54 FFFFFFFF 00000000 00800000 007FFF00 01FFAA14 00205F78 
GPR24: 005FF000 00160000 00000000 001DFB80 00001000 001D8000 00223F60 001DFB60 
Call Trace:
[00205F40] [000055C8]  (unreliable)
[00205F70] [001A51C4] 
[00205FA0] [000022DC] 
[00205FF0] [00004B40] 
Instruction dump:
38632658 481348c5 7fc3f378 480521fd 7fe3fb78 7f44d378 48042929 48000078 
801d0000 5400066e 3160ffff 7d2b0110 <0f090000> 38000400 7d20f828 7d290378 
Kernel panic - not syncing: Attempted to kill init!
 <0>Rebooting in 180 seconds..






poorbeyond
2007-08-11

--=====003_Dragon301211423074_=====
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<META content="MSHTML 6.00.2900.3132" name=GENERATOR></HEAD>
<BODY>
<DIV><FONT face=Verdana><FONT size=2>my cpu is mpc860, kernel is 2.6.20.14, use 
arch/ppc.</FONT></FONT></DIV>
<DIV><FONT face=Verdana size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>the attachment is my kernel config file, is 
something wrong?</FONT></DIV>
<DIV><FONT size=2></FONT>&nbsp;</DIV>
<DIV><FONT size=2>the following is kernel start info:</FONT></DIV>
<DIV><FONT size=2></FONT>&nbsp;</DIV>
<DIV><FONT size=2></FONT>&nbsp;</DIV>
<DIV><FONT size=2>^_^=&gt;bootm 300000</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=2>## Booting image at 00300000 ...<BR>&nbsp;&nbsp; Image 
Name:&nbsp;&nbsp; Linux-2.6.20.14<BR>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; 
PowerPC Linux Kernel Image (gzip compressed)<BR>&nbsp;&nbsp; Data 
Size:&nbsp;&nbsp;&nbsp; 840127 Bytes = 820.4 kB<BR>&nbsp;&nbsp; Load Address: 
00000000<BR>&nbsp;&nbsp; Entry Point:&nbsp; 00000000<BR>&nbsp;&nbsp; Verifying 
Checksum ... OK<BR>&nbsp;&nbsp; Uncompressing Kernel Image ... OK<BR>## Current 
stack ends at 0x01D5DB10 =&gt; set upper limit to 0x00800000<BR>No initrd<BR>## 
Transferring control to Linux (at address 00000000) ...<BR>bootm1<BR>Linux 
version 2.6.20.14 (<A 
href="mailto:root@localhost.localdomain">root@localhost.localdomain</A>) (gcc 
version 4.0.0 (DENX ELDK 4.0 4.0.0)) #1 PREEMPT Sat Aug 11 19:58:59 CST 
2007<BR>I2C/SPI/SMC1 microcode patch installed.<BR>Zone PFN ranges:<BR>&nbsp; 
DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 
-&gt;&nbsp;&nbsp;&nbsp;&nbsp; 2048<BR>&nbsp; 
Normal&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2048 -&gt;&nbsp;&nbsp;&nbsp;&nbsp; 
2048<BR>early_node_map[1] active PFN ranges<BR>&nbsp;&nbsp;&nbsp; 
0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 -&gt;&nbsp;&nbsp;&nbsp;&nbsp; 
2048<BR>Built 1 zonelists.&nbsp; Total pages: 2032<BR>Kernel command line: 
<BR>PID hash table entries: 32 (order: 5, 128 bytes)<BR>Decrementer Frequency = 
187500000/60<BR>Warning: real time clock seems stuck!<BR>cpm_uart: console: 
compat mode<BR>Dentry cache hash table entries: 1024 (order: 0, 4096 
bytes)<BR>Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)<BR>Memory: 
6220k available (1264k kernel code, 536k data, 84k init, 0k 
highmem)<BR>Mount-cache hash table entries: 512<BR>Zq001: 
start_kernel<BR>------------[ cut here ]------------<BR>Badness at 
arch/ppc/kernel/dma-mapping.c:345<BR>Call Trace:<BR>[00205E60] [00008DB0]&nbsp; 
(unreliable)<BR>[00205E90] [000A38D8] <BR>[00205EA0] [00003D28] <BR>[00205ED0] 
[0000308C] <BR>[00205F90] [001A4600] <BR>[00205FA0] [000022DC] <BR>[00205FF0] 
[00004B40] <BR>NET: Registered protocol family 16<BR>Generic PHY: Registered new 
driver<BR>NET: Registered protocol family 2<BR>IP route cache hash table 
entries: 1024 (order: 0, 4096 bytes)<BR>TCP established hash table entries: 256 
(order: 0, 4096 bytes)<BR>TCP bind hash table entries: 128 (order: -1, 2560 
bytes)<BR>TCP: Hash tables configured (established 256 bind 128)<BR>TCP reno 
registered<BR>audit: initializing netlink socket 
(disabled)<BR>audit(4294836223.222:1): initialized<BR>audit: cannot initialize 
inotify handle<BR>io scheduler noop registered (default)<BR>Serial: CPM driver 
$Revision: 0.02 $<BR>cpm_uart: WARNING: no UART devices found on platform 
bus!<BR>cpm_uart: the driver will guess configuration, but this mode is no 
longer supported.<BR>ttyCPM0 at MMIO 0xff000a80 (irq = 20) is a CPM 
UART<BR>RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 
blocksize<BR>LXT970: Registered new driver<BR>LXT971: Registered new 
driver<BR>fs_enet.c:v1.0 (Aug 8, 2005)<BR>------------[ cut here 
]------------<BR>kernel BUG at arch/ppc/kernel/dma-mapping.c:233!<BR>Oops: 
Exception in kernel mode, sig: 5 [#1]<BR>PREEMPT <BR>NIP: 00005644 LR: 000055F8 
CTR: 00000000<BR>REGS: 00205e90 TRAP: 0700&nbsp;&nbsp; Not tainted&nbsp; 
(2.6.20.14)<BR>MSR: 00029032 &lt;EE,ME,IR,DR&gt;&nbsp; CR: 55222253&nbsp; XER: 
A000247F<BR>TASK = 00202ba0[1] 'swapper' THREAD: 00204000<BR>GPR00: 00400165 
00205F40 00202BA0 001DFBA4 00000000 00000BDA 0025BFFC 00000000 <BR>GPR08: 
00162648 00000001 00401000 00400164 00000000 41082205 02000000 00000001 
<BR>GPR16: 00000000 01FFFA54 FFFFFFFF 00000000 00800000 007FFF00 01FFAA14 
00205F78 <BR>GPR24: 005FF000 00160000 00000000 001DFB80 00001000 001D8000 
00223F60 001DFB60 <BR>Call Trace:<BR>[00205F40] [000055C8]&nbsp; 
(unreliable)<BR>[00205F70] [001A51C4] <BR>[00205FA0] [000022DC] <BR>[00205FF0] 
[00004B40] <BR>Instruction dump:<BR>38632658 481348c5 7fc3f378 480521fd 7fe3fb78 
7f44d378 48042929 48000078 <BR>801d0000 5400066e 3160ffff 7d2b0110 
&lt;0f090000&gt; 38000400 7d20f828 7d290378 <BR>Kernel panic - not syncing: 
Attempted to kill init!<BR>&nbsp;&lt;0&gt;Rebooting in 180 
seconds..</FONT></DIV>
<DIV><FONT size=2></FONT>&nbsp;</DIV>
<DIV><FONT size=2></FONT>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV align=left><FONT size=2>
<HR style="WIDTH: 122px; HEIGHT: 2px" SIZE=2>
</FONT></DIV>
<DIV><FONT color=#c0c0c0><FONT size=2>poorbeyond</FONT></DIV>
<DIV><FONT size=2>2007-08-11</FONT></FONT></DIV></FONT></BODY></HTML>

--=====003_Dragon301211423074_=====--
