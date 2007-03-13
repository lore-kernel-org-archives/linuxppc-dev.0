Return-Path: <Hengmeej@linsys.ca>
Received: from linsys.ca (205-200-74-130.static.mts.net [205.200.74.130])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3F808DDD04
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Mar 2007 14:04:08 +1100 (EST)
Received: from WorldClient by linsys.ca (MDaemon PRO v9.5.6)
	with ESMTP id md50000147582.msg
	for <linuxppc-embedded@ozlabs.org>; Tue, 13 Mar 2007 15:28:57 -0600
Date: Tue, 13 Mar 2007 15:28:53 -0600
From: "Jantira Hengmeechai (Tai)" <Hengmeej@linsys.ca>
To: linuxppc-embedded@ozlabs.org
Subject: UartLite for MontaVista - virtex4
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="_0313-1528-53-PART-BREAK"
Message-ID: <WorldClient-F200703131528.AA28530025@linsys.ca>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--_0313-1528-53-PART-BREAK
Content-Type: text/plain; charset=us-ascii

 
Hi all,
 
I am implementing the MontaVista linux previewkit a 2.4 Linux kernel for a 
PowerPC405 
on  a custom board based on ML403. Our design used Uartlite instead of Uart, 
I set the 
boot parameter in the kernel to console=ttl0,9600. The system uses a ramdisk 
image.
The problem is after linux trying to boot, there are error messages as shown 
below:
 
 
loaded at: 00400000 005E41E0
board data at: 005E1138 005E1150
relocated to: 0040530C 00405324
zimage at: 004058D7 0047B4A3
initrd at: 0047C000 005E0591
avail ram: 005E5000 04000000
 
Linux/PPC load: root=/dev/ram rw console=ttl0,9600 console=/dev/ttl0
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.4.20_mvl31-ml300 (devel@localhost.localdomain) (gcc version 
3.3.1 (MontaVista 3.3.1-3.0.10.0300532 2003-12-24)) #23 Tue Mar 13 14:53:19 
EDT 2007
Xilinx Virtex-II Pro port (C) 2002 MontaVista Software, Inc. 
(source@mvista.com)
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram rw console=ttl0,9600 console=/dev/ttl0
Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFF000
Calibrating delay loop... 296.55 BogoMIPS
Memory: 62164k available (868k kernel code, 252k data, 48k init, 0k highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Disabling the Out Of Memory Killer
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
Tracer: Initialization complete 
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
IP-Config: No network devices available.
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 1425k freed
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 48k init
serial console detected. Disabling virtual terminals.
Xilinx OS Independent Code XAssert: xuartlite.c:195
Code may crash due to unhandled errors.
Xilinx OS Independent Code XAssert: xuartlite.c:195
Code may crash due to unhandled errors.
Xilinx OS Independent Code XAssert: xuartlite.c:195
Code may crash due to unhandled errors.
Xilinx OS Independent Code XAssert: xuartlite.c:195
Code may crash due to unhandled errors.
 
 
We don't know what is causing the problem, any help would be appreciated.
 
Thanks,
Tai.
 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jantira Hengmeechai (Tai)
Embedded Software Developer
 
Linear Systems Ltd.
1717 Dublin Avenue, Unit 1
Winnipeg., MB., R3H 0H2, Canada 
Phone: 1 204 632 4300 ext.23, Fax: 1 204 697 2417

--_0313-1528-53-PART-BREAK
Content-Type: text/html; charset=us-ascii

<HTML>
<HEAD> <META http-equiv=Content-Type content="text/html; charset=us-ascii"> 
<STYLE title="table borders">.htmtableborders, .htmtableborders td, 
.htmtableborders th {border : 1px dashed lightgrey ! important;}  </STYLE>  
<STYLE type=text/css>html, body { border: 0px; }  span.macro, span.macro ul, 
span.macro div, span.macro p {background : #CCCCCC;} </STYLE>  <STYLE 
type=text/css> p{margin-bottom: 0.15em;margin-top: 
0.15em;}body{font-family:;font-size:10pt;}; </STYLE> </HEAD> <BODY><FONT 
style="FONT-SIZE: 10pt; FONT-FAMILY: "> <DIV> </DIV> <DIV>Hi all,</DIV> <DIV>
&nbsp;</DIV> <DIV>I am implementing 
the&nbsp;MontaVista&nbsp;linux&nbsp;previewkit a 2.4 Linux kernel for a 
PowerPC405 </DIV> <DIV>on &nbsp;a custom board based on ML403. Our design 
used Uartlite instead of Uart, I set the </DIV> <DIV>boot parameter in the 
kernel to console=ttl0,9600. The system uses a ramdisk image.</DIV> <DIV>The 
problem is after linux trying to boot, there are error messages as shown 
below:</DIV> <DIV>&nbsp;</DIV><FONT size=2> <DIV>&nbsp;</DIV> <DIV>loaded 
at: 00400000 005E41E0</DIV> <DIV>board data at: 005E1138 005E1150</DIV> <DIV>
relocated to: 0040530C 00405324</DIV> <DIV>zimage at: 004058D7 0047B4A3</DIV>
 <DIV>initrd at: 0047C000 005E0591</DIV> <DIV>avail ram: 005E5000 
04000000</DIV> <DIV>&nbsp;</DIV> <DIV>Linux/PPC load: root=/dev/ram rw 
console=ttl0,9600 console=/dev/ttl0</DIV> <DIV>Uncompressing 
Linux...done.</DIV> <DIV>Now booting the kernel</DIV> <DIV>Linux version 
2.4.20_mvl31-ml300 (devel@localhost.localdomain) (gcc version 3.3.1 
(MontaVista 3.3.1-3.0.10.0300532 2003-12-24)) #23 Tue Mar 13 14:53:19 EDT 
2007</DIV> <DIV>Xilinx Virtex-II Pro port (C) 2002 MontaVista Software, Inc. 
(source@mvista.com)</DIV> <DIV>On node 0 totalpages: 16384</DIV> <DIV>
zone(0): 16384 pages.</DIV> <DIV>zone(1): 0 pages.</DIV> <DIV>zone(2): 0 
pages.</DIV> <DIV>Kernel command line: root=/dev/ram rw console=ttl0,9600 
console=/dev/ttl0</DIV> <DIV>Xilinx INTC #0 at 0x41200000 mapped to 
0xFDFFF000</DIV> <DIV>Calibrating delay loop... 296.55 BogoMIPS</DIV> <DIV>
Memory: 62164k available (868k kernel code, 252k data, 48k init, 0k 
highmem)</DIV> <DIV>Dentry cache hash table entries: 8192 (order: 4, 65536 
bytes)</DIV> <DIV>Inode cache hash table entries: 4096 (order: 3, 32768 
bytes)</DIV> <DIV>Mount-cache hash table entries: 1024 (order: 1, 8192 
bytes)</DIV> <DIV>Buffer-cache hash table entries: 4096 (order: 2, 16384 
bytes)</DIV> <DIV>Page-cache hash table entries: 16384 (order: 4, 65536 
bytes)</DIV> <DIV>POSIX conformance testing by UNIFIX</DIV> <DIV>Linux 
NET4.0 for Linux 2.4</DIV> <DIV>Based upon Swansea University Computer 
Society NET3.039</DIV> <DIV>Initializing RT netlink socket</DIV> <DIV>
Starting kswapd</DIV> <DIV>Disabling the Out Of Memory Killer</DIV> <DIV>
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)</DIV> <DIV>
devfs: boot_options: 0x1</DIV> <DIV>pty: 256 Unix98 ptys configured</DIV> 
<DIV>RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 
blocksize</DIV> <DIV>loop: loaded (max 8 devices)</DIV> <DIV>Tracer: 
Initialization complete </DIV> <DIV>NET4: Linux TCP/IP 1.0 for NET4.0</DIV> 
<DIV>IP Protocols: ICMP, UDP, TCP, IGMP</DIV> <DIV>IP: routing cache hash 
table of 512 buckets, 4Kbytes</DIV> <DIV>TCP: Hash tables configured 
(established 4096 bind 8192)</DIV> <DIV>IP-Config: No network devices 
available.</DIV> <DIV>NET4: Unix domain sockets 1.0/SMP for Linux 
NET4.0.</DIV> <DIV>RAMDISK: Compressed image found at block 0</DIV> <DIV>
Freeing initrd memory: 1425k freed</DIV> <DIV>VFS: Mounted root (ext2 
filesystem).</DIV> <DIV>Mounted devfs on /dev</DIV> <DIV>Freeing unused 
kernel memory: 48k init</DIV> <DIV>serial console detected. Disabling 
virtual terminals.</DIV> <DIV>Xilinx OS Independent Code XAssert: 
xuartlite.c:195</DIV> <DIV>Code may crash due to unhandled errors.</DIV> 
<DIV>Xilinx OS Independent Code XAssert: xuartlite.c:195</DIV> <DIV>Code may 
crash due to unhandled errors.</DIV> <DIV>Xilinx OS Independent Code 
XAssert: xuartlite.c:195</DIV> <DIV>Code may crash due to unhandled 
errors.</DIV> <DIV>Xilinx OS Independent Code XAssert: xuartlite.c:195</DIV> 
<DIV>Code may crash due to unhandled errors.</DIV></FONT> <DIV>&nbsp;</DIV> 
<DIV>&nbsp;</DIV> <DIV>We don't know what is causing the problem, any help 
would be appreciated.</DIV> <DIV>&nbsp;</DIV> <DIV>Thanks,</DIV> <DIV>
Tai.</DIV> <DIV>&nbsp;</DIV> <DIV></FONT>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</DIV> <DIV>Jantira Hengmeechai 
(Tai)</DIV> <DIV>Embedded Software Developer</DIV> <DIV>&nbsp;</DIV> <DIV>
Linear Systems Ltd.<BR>1717 Dublin Avenue, Unit 1</DIV> <DIV>Winnipeg., MB., 
R3H 0H2, Canada </DIV> <DIV>Phone: 1 204 632 4300 ext.23, Fax: 1 204 697 
2417</DIV></BODY>
</HTML>

--_0313-1528-53-PART-BREAK--
