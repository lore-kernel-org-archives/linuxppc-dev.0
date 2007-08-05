Return-Path: <poorbeyond@163.com>
Received: from m5-84.163.com (unknown [202.108.5.84])
	by ozlabs.org (Postfix) with SMTP id D6CBCDDE08
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  5 Aug 2007 21:09:14 +1000 (EST)
Date: Sun, 5 Aug 2007 18:54:33 +0800
From: "poorbeyond" <poorbeyond@163.com>
To: "Linux-ppc mail list" <linuxppc-embedded@ozlabs.org>
Subject: my cpu is MPC860, kernel version is 2.6.20.14,
	the kernel start info in the mail. why does the kernel panic?
Message-ID: <200708051854252184131@163.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=====003_Dragon215417630081_====="
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

--=====003_Dragon215417630081_=====
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

^_^=>bootm 300000

## Booting image at 00300000 ...
   Image Name:   Linux-2.6.20.14
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1038351 Bytes = 1014 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x01D5DB10 => set upper limit to 0x00800000
No initrd
## Transferring control to Linux (at address 00000000) ...
bootm1
Linux version 2.6.20.14 (root@localhost.localdomain) (gcc version 4.0.0 (DENX ELDK 4.0 4.0.0)) #1 PREEMPT Sun Aug 5 18:23:18 CST 2007

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

Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)in

Memory: 5732k available (1592k kernel code, 688k data, 92k init, 0k highmem)

Security Framework v1.0.0 initialized

SELinux:  Initializing.

SELinux:  Starting in permissive mode

selinux_register_security:  Registering secondary module capability

Capability LSM initialized as secondary

Mount-cache hash table entries: 512

------------[ cut here ]------------

Badness at 00200880 [verbose debug info unavailable]

Call Trace:

[00285E60] [00008E24]  (unreliable)

[00285E90] [000EBA14] 

[00285EA0] [00003D88] 

[00285ED0] [000030EC] 

[00285F90] [00202E98] 

[00285FA0] [000022DC] 

[00285FF0] [00004BA0] 

NET: Registered protocol family 16

Generic PHY: Registered new driver

NET: Registered protocol family 2

IP route cache hash table entries: 1024 (order: 0, 4096 bytes)

TCP established hash table entries: 256 (order: 0, 4096 bytes)

TCP bind hash table entries: 128 (order: -1, 2560 bytes)

TCP: Hash tables configured (established 256 bind 128)

TCP reno registered

audit: initializing netlink socket (disabled)

audit(4160749566.303:1): initialized

VFS: Disk quotas dquot_6.5.1

Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)

SELinux:  Registering netfilter hooks

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

Kernel BUG at 000056a4 [verbose debug info unavailable]

Oops: Exception in kernel mode, sig: 5 [#1]

PREEMPT 

NIP: 000056A4 LR: 00005658 CTR: 00000000

REGS: 00285e90 TRAP: 0700   Not tainted  (2.6.20.14)

MSR: 00029032 <EE,ME,IR,DR>  CR: 44000042  XER: 2000107F

TASK = 00282bd0[1] 'swapper' THREAD: 00284000

GPR00: 00400165 00285F40 00282BD0 0025B104 00000000 00000BDA 00306FFC 00000000 

GPR08: 001C1648 00000001 00401000 00400164 00000000 40000001 02000000 00000001 

GPR16: 00000000 01FFFA54 FFFFFFFF 00000000 00800000 007FFF00 01FFAA14 00285F78 

GPR24: 005FF000 001C0000 00000000 0025B0E0 00001000 00252000 002FF820 0025B0C0 

Call Trace:

[00285F40] [00005628]  (unreliable)

[00285F70] [0020AAB0] 

[00285FA0] [000022DC] 

[00285FF0] [00004BA0] 

Instruction dump:

38631658 48186b4d 7fc3f378 48055c05 7fe3fb78 7f44d378 48045895 48000078 

801d0000 5400066e 3160ffff 7d2b0110 <0f090000> 38000400 7d20f828 7d290378 

Kernel panic - not syncing: Attempted to kill init!

 <0>Rebooting in 180 seconds..





poorbeyond
2007-08-05

--=====003_Dragon215417630081_=====
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<META content="MSHTML 6.00.2900.3132" name=GENERATOR></HEAD>
<BODY>
<DIV><FONT face=Verdana><FONT size=2>^_^=&gt;bootm 300000</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>## Booting image at 00300000 
...<BR>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.20.14<BR>&nbsp;&nbsp; 
Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip 
compressed)<BR>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1038351 Bytes = 1014 
kB<BR>&nbsp;&nbsp; Load Address: 00000000<BR>&nbsp;&nbsp; Entry Point:&nbsp; 
00000000<BR>&nbsp;&nbsp; Verifying Checksum ... OK<BR>&nbsp;&nbsp; Uncompressing 
Kernel Image ... OK<BR>## Current stack ends at 0x01D5DB10 =&gt; set upper limit 
to 0x00800000<BR>No initrd<BR>## Transferring control to Linux (at address 
00000000) ...<BR>bootm1<BR>Linux version 2.6.20.14 (<A 
href="mailto:root@localhost.localdomain">root@localhost.localdomain</A>) (gcc 
version 4.0.0 (DENX ELDK 4.0 4.0.0)) #1 PREEMPT Sun Aug 5 18:23:18 CST 
2007</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>I2C/SPI/SMC1 microcode patch 
installed.</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>Zone PFN ranges:</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>&nbsp; 
DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 
-&gt;&nbsp;&nbsp;&nbsp;&nbsp; 2048</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>&nbsp; 
Normal&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2048 -&gt;&nbsp;&nbsp;&nbsp;&nbsp; 
2048</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>early_node_map[1] active PFN 
ranges</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>&nbsp;&nbsp;&nbsp; 
0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 -&gt;&nbsp;&nbsp;&nbsp;&nbsp; 
2048</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>Built 1 zonelists.&nbsp; Total pages: 
2032</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>Kernel command line: </FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>PID hash table entries: 32 (order: 5, 128 
bytes)</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>Decrementer Frequency = 
187500000/60</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>Warning: real time clock seems 
stuck!</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>cpm_uart: console: compat 
mode</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>Dentry cache hash table entries: 1024 
(order: 0, 4096 bytes)</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>Inode-cache hash table entries: 1024 
(order: 0, 4096 bytes)in</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>Memory: 5732k available (1592k kernel code, 
688k data, 92k init, 0k highmem)</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>Security Framework v1.0.0 
initialized</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>SELinux:&nbsp; 
Initializing.</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>SELinux:&nbsp; Starting in permissive 
mode</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>selinux_register_security:&nbsp; 
Registering secondary module capability</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>Capability LSM initialized as 
secondary</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>Mount-cache hash table entries: 
512</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>------------[ cut here 
]------------</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>Badness at 00200880 [verbose debug info 
unavailable]</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>Call Trace:</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>[00285E60] [00008E24]&nbsp; 
(unreliable)</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>[00285E90] [000EBA14] </FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>[00285EA0] [00003D88] </FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>[00285ED0] [000030EC] </FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>[00285F90] [00202E98] </FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>[00285FA0] [000022DC] </FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>[00285FF0] [00004BA0] </FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>NET: Registered protocol family 
16</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>Generic PHY: Registered new 
driver</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>NET: Registered protocol family 
2</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>IP route cache hash table entries: 1024 
(order: 0, 4096 bytes)</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>TCP established hash table entries: 256 
(order: 0, 4096 bytes)</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>TCP bind hash table entries: 128 (order: 
-1, 2560 bytes)</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>TCP: Hash tables configured (established 
256 bind 128)</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>TCP reno registered</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>audit: initializing netlink socket 
(disabled)</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>audit(4160749566.303:1): 
initialized</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>VFS: Disk quotas 
dquot_6.5.1</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>Dquot-cache hash table entries: 1024 (order 
0, 4096 bytes)</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>SELinux:&nbsp; Registering netfilter 
hooks</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>io scheduler noop registered 
(default)</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>Serial: CPM driver $Revision: 0.02 
$</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>cpm_uart: WARNING: no UART devices found on 
platform bus!</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>cpm_uart: the driver will guess 
configuration, but this mode is no longer supported.</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>ttyCPM0 at MMIO 0xff000a80 (irq = 20) is a 
CPM UART</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>RAMDISK driver initialized: 16 RAM disks of 
16384K size 1024 blocksize</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>LXT970: Registered new 
driver</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>LXT971: Registered new 
driver</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>fs_enet.c:v1.0 (Aug 8, 
2005)</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>------------[ cut here 
]------------</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>Kernel BUG at 000056a4 [verbose debug info 
unavailable]</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>Oops: Exception in kernel mode, sig: 5 
[#1]</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>PREEMPT </FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>NIP: 000056A4 LR: 00005658 CTR: 
00000000</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>REGS: 00285e90 TRAP: 0700&nbsp;&nbsp; Not 
tainted&nbsp; (2.6.20.14)</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>MSR: 00029032 &lt;EE,ME,IR,DR&gt;&nbsp; CR: 
44000042&nbsp; XER: 2000107F</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>TASK = 00282bd0[1] 'swapper' THREAD: 
00284000</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>GPR00: 00400165 00285F40 00282BD0 0025B104 
00000000 00000BDA 00306FFC 00000000 </FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>GPR08: 001C1648 00000001 00401000 00400164 
00000000 40000001 02000000 00000001 </FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>GPR16: 00000000 01FFFA54 FFFFFFFF 00000000 
00800000 007FFF00 01FFAA14 00285F78 </FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>GPR24: 005FF000 001C0000 00000000 0025B0E0 
00001000 00252000 002FF820 0025B0C0 </FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>Call Trace:</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>[00285F40] [00005628]&nbsp; 
(unreliable)</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>[00285F70] [0020AAB0] </FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>[00285FA0] [000022DC] </FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>[00285FF0] [00004BA0] </FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>Instruction dump:</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>38631658 48186b4d 7fc3f378 48055c05 
7fe3fb78 7f44d378 48045895 48000078 </FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>801d0000 5400066e 3160ffff 7d2b0110 
&lt;0f090000&gt; 38000400 7d20f828 7d290378 </FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>Kernel panic - not syncing: Attempted to 
kill init!</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>&nbsp;&lt;0&gt;Rebooting in 180 
seconds..</FONT></FONT></DIV>
<DIV><FONT face=Verdana><FONT size=2></FONT>&nbsp;</DIV>
<DIV><FONT size=2></FONT>&nbsp;</DIV>
<DIV align=left><FONT size=2>
<HR style="WIDTH: 122px; HEIGHT: 2px" SIZE=2>
</FONT></DIV>
<DIV><FONT color=#c0c0c0><FONT size=2>poorbeyond</FONT></DIV>
<DIV><FONT size=2>2007-08-05</FONT></FONT></DIV></FONT></BODY></HTML>

--=====003_Dragon215417630081_=====--
