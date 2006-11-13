Return-Path: <pradeepsampath@yahoo.com>
Received: from web83204.mail.mud.yahoo.com (web83204.mail.mud.yahoo.com
	[216.252.101.48]) by ozlabs.org (Postfix) with SMTP id A947F67DF7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Nov 2006 04:42:16 +1100 (EST)
Message-ID: <20061113174214.56102.qmail@web83204.mail.mud.yahoo.com>
Date: Mon, 13 Nov 2006 09:42:14 -0800 (PST)
From: Pradeep Sampath <pradeepsampath@yahoo.com>
Subject: PLB TEMAC, irq issue
To: robert corley <rdcorle@yahoo.com>, linuxppc-embedded@ozlabs.org
In-Reply-To: <20061110152840.12653.qmail@web56301.mail.re3.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1463345045-1163439734=:55734"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1463345045-1163439734=:55734
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Robert,
   
  Hope you had a chance to look at my earlier email. 
   
    I see that xtenet_init is getting called. But xtenet_probe function is not getting called in adapter.c. How do i make sure that the device is getting registered with the OS. Or the OS is recognizing the presence of the plb TEMAC device? I see that the IRQ is getting generated on line 1 for the uartlite. But my guess is its not getting generated on line 0 for the Xilinx TEMAC. How should i bebug this problem? 
  
# Start Loading the 2.6.18.1 Linux Kernel
loaded at:     00400000 006A2138
board data at: 006A0120 006A0138
relocated to:  00404060 00404078
zimage at:     00404E15 0050861B
initrd at:     00509000 0069F280
avail ram:     006A3000 04000000
  Linux/PPC load: console=ttyUL0 single ip=onfiltered=/dev/ram rw
Uncompressing Linux...done.
Now booting the kernel
[    0.000000] Linux version 2.6.18.1 (psampath@psampath-test) (gcc version 3.4.
1) #9 Sat Nov 11 20:36:43 PST 2006
[    0.000000] Xilinx ML403 Reference System (Virtex-4 FX)
[    0.000000] Built 1 zonelists.  Total pages: 16384
[    0.000000] Kernel command line: console=ttyUL0 single ip=onfiltered=/dev/ram rw
[    0.000000] Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFF000
[    0.000000] PID hash table entries: 512 (order: 9, 2048 bytes)
[    0.000326] Console: colour dummy device 80x25
[    0.001389] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.002932] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.029900] Memory: 60884k available (1688k kernel code, 600k data, 84k init,
 0k highmem)
[    0.216360] Security Framework v1.0.0 initialized
[    0.216473] SELinux:  Disabled at boot.
[    0.216704] Mount-cache hash table entries: 512
[    0.221480] checking if image is initramfs...it isn't (no cpio magic); looks
like an initrd
[    1.342111] Freeing initrd memory: 1624k freed
[    1.349021] NET: Registered protocol family 16
[    1.369816] NET: Registered protocol family 2
[    1.436868] IP route cache hash table entries: 512 (order: -1, 2048 bytes)
[    1.438739] TCP established hash table entries: 2048 (order: 1, 8192 bytes)
[    1.439039] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
[    1.439195] TCP: Hash tables configured (established 2048 bind 1024)
[    1.439231] TCP reno registered
[    1.456095] audit: initializing netlink socket (disabled)
[    1.456377] audit(1.456:1): initialized
[    1.459462] VFS: Disk quotas dquot_6.5.1
[    1.460253] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.461601] Initializing Cryptographic API
[    1.461733] io scheduler noop registered
[    1.461902] io scheduler anticipatory registered
[    1.461998] io scheduler deadline registered
[    1.462188] io scheduler cfq registered (default)
[    2.724917] uartlite.0: ttyUL0 at MMIO 0x40600000 (irq = 1) is a uartlite
[    2.928511] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 bloc
ksize
[    2.948314] loop: loaded (max 8 devices)
[    2.954686] Entering xtenet_init
[    2.963619] i8042.c: No controller found.
[    2.969055] TCP bic registered
[    2.972280] NET: Registered protocol family 8
[    2.976663] NET: Registered protocol family 20
[    2.983519] RAMDISK: Compressed image found at block 0
[    4.588127] VFS: Mounted root (ext2 filesystem).
[    4.593419] Freeing unused kernel memory: 84k init
  
BusyBox v1.1.0 (2006.09.30-21:14+0000) Built-in shell (ash)
Enter 'help' for a list of built-in commands.
  -sh: can't access tty; job control turned off
#
   
  -Pradeep
   
     



--0-1463345045-1163439734=:55734
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Robert,</div>  <div>&nbsp;</div>  <div>Hope you had a chance to look at my earlier email. </div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; COLOR: navy; FONT-FAMILY: Arial"><?xml:namespace prefix = o ns = "urn:schemas-microsoft-com:office:office" /><o:p>&nbsp;</o:p></SPAN></div>  <div>  <div>I see that xtenet_init is getting called. But xtenet_probe function is not getting called in adapter.c. How do i make sure that the device is getting registered with the OS. Or the OS is recognizing the presence of the plb TEMAC device?&nbsp;I see that the IRQ is getting&nbsp;generated on line 1&nbsp;for the uartlite. But&nbsp;my guess is its&nbsp;not getting generated on line 0 for the Xilinx TEMAC. How should i bebug this problem?&nbsp;</div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; LINE-HEIGHT: 14.4pt"><SPAN style="FONT-SIZE: 10pt; COLOR: black; FONT-FAMILY: Arial"><BR># Start Loading the 2.6.18.1 Linux Kernel<BR>loaded
 at:&nbsp;&nbsp;&nbsp;&nbsp; 00400000 006A2138<BR>board data at: 006A0120 006A0138<BR>relocated to:&nbsp; 00404060 00404078<BR>zimage at:&nbsp;&nbsp;&nbsp;&nbsp; 00404E15 0050861B<BR>initrd at:&nbsp;&nbsp;&nbsp;&nbsp; 00509000 0069F280<BR>avail ram:&nbsp;&nbsp;&nbsp;&nbsp; 006A3000 04000000<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; LINE-HEIGHT: 14.4pt"><SPAN style="FONT-SIZE: 10pt; COLOR: black; FONT-FAMILY: Arial">Linux/PPC load: console=ttyUL0 single ip=onfiltered=/dev/ram rw<BR>Uncompressing Linux...done.<BR>Now booting the kernel<BR>[&nbsp;&nbsp;&nbsp; 0.000000] Linux version 2.6.18.1 (<A href="http://us.f832.mail.yahoo.com/ym/Compose?To=psampath@psampath-test" target=_blank _>psampath@psampath-test</A>) (gcc version 3.4.<BR>1) #9 Sat Nov 11 20:36:43 PST 2006<BR>[&nbsp;&nbsp;&nbsp; 0.000000] Xilinx ML403 Reference System (Virtex-4 FX)<BR>[&nbsp;&nbsp;&nbsp; 0.000000] Built 1 zonelists.&nbsp; Total pages: 16384<BR>[&nbsp;&nbsp;&nbsp;
 0.000000] Kernel command line: console=ttyUL0 single ip=onfiltered=/dev/ram rw<BR>[&nbsp;&nbsp;&nbsp; 0.000000] Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFF000<BR>[&nbsp;&nbsp;&nbsp; 0.000000] PID hash table entries: 512 (order: 9, 2048 bytes)<BR>[&nbsp;&nbsp;&nbsp; 0.000326] Console: colour dummy device 80x25<BR>[&nbsp;&nbsp;&nbsp; 0.001389] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)<BR>[&nbsp;&nbsp;&nbsp; 0.002932] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)<BR>[&nbsp;&nbsp;&nbsp; 0.029900] Memory: 60884k available (1688k kernel code, 600k data, 84k init,<BR>&nbsp;0k highmem)<BR>[&nbsp;&nbsp;&nbsp; 0.216360] Security Framework v1.0.0 initialized<BR>[&nbsp;&nbsp;&nbsp; 0.216473] SELinux:&nbsp; Disabled at boot.<BR>[&nbsp;&nbsp;&nbsp; 0.216704] Mount-cache hash table entries: 512<BR>[&nbsp;&nbsp;&nbsp; 0.221480] checking if image is initramfs...it isn't (no cpio magic); looks<BR>like an initrd<BR>[&nbsp;&nbsp;&nbsp; 1.342111] Freeing
 initrd memory: 1624k freed<BR>[&nbsp;&nbsp;&nbsp; 1.349021] NET: Registered protocol family 16<BR>[&nbsp;&nbsp;&nbsp; 1.369816] NET: Registered protocol family 2<BR>[&nbsp;&nbsp;&nbsp; 1.436868] IP route cache hash table entries: 512 (order: -1, 2048 bytes)<BR>[&nbsp;&nbsp;&nbsp; 1.438739] TCP established hash table entries: 2048 (order: 1, 8192 bytes)<BR>[&nbsp;&nbsp;&nbsp; 1.439039] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)<BR>[&nbsp;&nbsp;&nbsp; 1.439195] TCP: Hash tables configured (established 2048 bind 1024)<BR>[&nbsp;&nbsp;&nbsp; 1.439231] TCP <?xml:namespace prefix = st1 ns = "urn:schemas-microsoft-com:office:smarttags" /><st1:City w:st="on"><st1:place w:st="on">reno</st1:place></st1:City> registered<BR>[&nbsp;&nbsp;&nbsp; 1.456095] audit: initializing netlink socket (disabled)<BR>[&nbsp;&nbsp;&nbsp; 1.456377] audit(1.456:1): initialized<BR>[&nbsp;&nbsp;&nbsp; 1.459462] VFS: Disk quotas dquot_6.5.1<BR>[&nbsp;&nbsp;&nbsp; 1.460253] Dquot-cache hash
 table entries: 1024 (order 0, 4096 bytes)<BR>[&nbsp;&nbsp;&nbsp; 1.461601] Initializing Cryptographic API<BR>[&nbsp;&nbsp;&nbsp; 1.461733] io scheduler noop registered<BR>[&nbsp;&nbsp;&nbsp; 1.461902] io scheduler anticipatory registered<BR>[&nbsp;&nbsp;&nbsp; 1.461998] io scheduler deadline registered<BR>[&nbsp;&nbsp;&nbsp; 1.462188] io scheduler cfq registered (default)<BR>[&nbsp;&nbsp;&nbsp; 2.724917] uartlite.0: ttyUL0 at MMIO 0x40600000 (irq = 1) is a uartlite<BR>[&nbsp;&nbsp;&nbsp; 2.928511] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 bloc<BR>ksize<BR>[&nbsp;&nbsp;&nbsp; 2.948314] loop: loaded (max 8 devices)<BR>[&nbsp;&nbsp;&nbsp; 2.954686] Entering xtenet_init<BR>[&nbsp;&nbsp;&nbsp; 2.963619] i8042.c: No controller found.<BR>[&nbsp;&nbsp;&nbsp; 2.969055] TCP bic registered<BR>[&nbsp;&nbsp;&nbsp; 2.972280] NET: Registered protocol family 8<BR>[&nbsp;&nbsp;&nbsp; 2.976663] NET: Registered protocol family 20<BR>[&nbsp;&nbsp;&nbsp; 2.983519] RAMDISK:
 Compressed image found at block 0<BR>[&nbsp;&nbsp;&nbsp; 4.588127] VFS: Mounted root (ext2 filesystem).<BR>[&nbsp;&nbsp;&nbsp; 4.593419] Freeing unused kernel memory: 84k init<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; LINE-HEIGHT: 14.4pt"><SPAN style="FONT-SIZE: 10pt; COLOR: black; FONT-FAMILY: Arial"><BR>BusyBox v1.1.0 (2006.09.30-21:14+0000) Built-in shell (ash)<BR>Enter 'help' for a list of built-in commands.<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; LINE-HEIGHT: 14.4pt"><SPAN style="FONT-SIZE: 10pt; COLOR: black; FONT-FAMILY: Arial">-sh: can't access tty; job control turned off<BR>#<o:p></o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; LINE-HEIGHT: 14.4pt"><SPAN style="FONT-SIZE: 10pt; COLOR: black; FONT-FAMILY: Arial"><o:p>&nbsp;</o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt; LINE-HEIGHT: 14.4pt"><SPAN style="FONT-SIZE: 10pt; COLOR: black; FONT-FAMILY:
 Arial"><o:p>-Pradeep</o:p></SPAN></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN style="FONT-SIZE: 10pt; COLOR: navy; FONT-FAMILY: Arial"><o:p>&nbsp;</o:p></SPAN></div>  <div>  <div>&nbsp;</div></div></div>
--0-1463345045-1163439734=:55734--
