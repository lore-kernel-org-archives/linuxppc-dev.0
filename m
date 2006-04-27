Return-Path: <npk_0@yahoo.co.in>
Received: from web8907.mail.in.yahoo.com (web8907.mail.in.yahoo.com
	[203.84.221.139]) by ozlabs.org (Postfix) with SMTP id 9B171679F0
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 16:13:22 +1000 (EST)
Message-ID: <20060427060639.56542.qmail@web8907.mail.in.yahoo.com>
Date: Thu, 27 Apr 2006 07:06:39 +0100 (BST)
From: Prakash N <npk_0@yahoo.co.in>
Subject: linux 2.4.26 bummer problem
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-513996594-1146117999=:54568"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0-513996594-1146117999=:54568
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi, 
  Iam trying to run linux 2.4.26 from mvista in xilinx XUPV2P board. 
  During booting I get this error message, 
 
 Mounted devfs on /dev 
  . 
  Freeing unused kernel memory: 60k init 
  init started:  BusyBox v1.1.2 (2006.04.24-13:20+0000) multi-call binary 
  Starting pid 11, console /dev/console: '/etc/init.d/rcS' 
  Bummer, could not run '/etc/init.d/rcS': No such file or directory 
  Bummer, could not run 
  ML300 powerpc linux 2.4.21-pre7 E.I.S. edition 
  (none) login: 
  . 
  But I could see in the generated root file system this file is there. 
  Even its not logging with anything. 
   My inittab file is 
 ::sysinit:/etc/init.d/rcS 
 #::askfirst:-/bin/sh 
 ::ctrlaltdel:/sbin/reboot 
 ::shutdown:/sbin/swapoff -a 
 ::shutdown:/bin/umount -a -r 
 ::restart:/sbin/init 
 ::respawn:/sbin/getty 9600 tts/0 
 
 Without init options specified in busybox configuration I got, 
 . 
 NET4: Unix domain sockets 1.0/SMP for Linux NET4.0. 
 EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended 
 VFS: Mounted root (ext2 filesystem). 
 mount_devfs_fs(): unable to mount devfs, err: -5 
 Freeing unused kernel memory: 60k init 
 Warning: unable to open an initial console. 
 Kernel panic: No init found.  Try passing init= option to kernel. 
 Some replies in usenet, which I answered,
 
 - x bits set for this shell script? 
 SInce Iam new to this embedded linux, could you tell whats that x bits means, is it exec permission (if so for whom,root?). 
 
  - does a shell run? 
 Iam not clear why does it say /etc/init.d/rcS is not there, while its definitely there.
 I feel shell is not running. I want to just put what I get in minicom
 ----------------------------------------------------------------------------------------------------------------------------------------
 loaded at:     00400000 004C11E4
 board data at: 004BE13C 004BE154
 relocated to:  00405634 0040564C
 zimage at:     00405BF9 004BDD33
 avail ram:     004C2000 10000000
 
 Linux/PPC load: console=ttyS0,9600 root=/dev/xsysace/disc0/part2 rw
 Uncompressing Linux...done.
 Now booting the kernel
 Linux version 2.4.26 (root@edvl28.cedt.iisc.ernet.in) (gcc version 3.4.1) #16 Sat Apr 22 15:19:6Xilinx Virtex-II Pro port (C) 2002 MontaVista Software, Inc. (source@mvista.com)
 On node 0 totalpages: 65536
 zone(0): 65536 pages.
 zone(1): 0 pages.
 zone(2): 0 pages.
 Kernel command line: console=ttyS0,9600 root=/dev/xsysace/disc0/part2 rw
 Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFE000
 Calibrating delay loop... 299.00 BogoMIPS
 Memory: 257332k available (1284k kernel code, 380k data, 60k init, 0k highmem)
 Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
 Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
 Mount cache hash table entries: 512 (order: 0, 4096 bytes)
 Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
 Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
 POSIX conformance testing by UNIFIX
 Linux NET4.0 for Linux 2.4
 Based upon Swansea University Computer Society NET3.039
 Initializing RT netlink socket
 Starting kswapd
 devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
 devfs: boot_options: 0x1
 JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis Communications AB.
 pty: 256 Unix98 ptys configured
 Serial driver version 5.05c (2001-07-08) with no serial options enabled
 ttyS00 at 0xfdfff003 (irq = 29) is a 16550A
 RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
 loop: loaded (max 8 devices)
 Partition check:
  xsysacea: p1 p2
 System ACE at 0x41800000 mapped to 0xD1070000, irq=30, 250880KB
 eth0: using fifo mode.
 eth0: No PHY detected.  Assuming a PHY at address 0.
 eth0: Xilinx EMAC #0 at 0x40C00000 mapped to 0xD1083000, irq=31
 eth0: id 2.0h; block id 7, type 1
 SCSI subsystem driver Revision: 1.00
 NET4: Linux TCP/IP 1.0 for NET4.0
 IP Protocols: ICMP, UDP, TCP, IGMP
 IP: routing cache hash table of 2048 buckets, 16Kbytes
 TCP: Hash tables configured (established 16384 bind 32768)
 NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
 EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
 VFS: Mounted root (ext2 filesystem).
 Mounted devfs on /dev
 Freeing unused kernel memory: 60k init
 init started:  BusyBox v1.1.2 (2006.04.27-03:52+0000) multi-call binary
 Starting pid 11, console /dev/console: '/etc/init.d/rcS'
 Bummer, could not run '/etc/init.d/rcS': No such file or directory
 Bummer, could not run '/etc/init.d/rcS': No such file
 ML300 powerpc linux 2.4.21-pre7 E.I.S. edition
 (none) login:
 -----------------------------------------------------------------------------------------------------------------------------------
 Here If I type su or root or whatever it asks password but always says incorrect login.
 
 - try init=/bin/sh as a kernel parameter. Does it run?
 My init tab file is 
 ----------------------------------------------------------------------------------------------------------------------------
 ::init=/bin/sh
 ::sysinit:/etc/init.d/rcS
 #::askfirst:-/bin/sh
 ::ctrlaltdel:/sbin/reboot
 ::shutdown:/sbin/swapoff -a
 ::shutdown:/bin/umount -a -r
 ::restart:/sbin/init
 ::respawn:/sbin/getty 9600 tts/0
 ------------------------------------------------------------------------------------------------------------------------------
 
 The log is 
 ..........
 VFS: Mounted root (ext2 filesystem).
 mount_devfs_fs(): unable to mount devfs, err: -5
 Freeing unused kernel memory: 60k init
 Warning: unable to open an initial console.
 Kernel panic: No init found.  Try passing init= option to kernel.
  <0>Rebooting in 180 seconds..
 -----------------------------------------------------------------------------------------------------------------
 
  - all needed libraries to run available on your target?
 I feel yes, as I could see these in lib folder of my RFS.
 
 ld-2.3.3.so               libdl.so.2              libnss_dns.so.2          libpthread.so.0
 ld.so.1                   libgcc_s_nof.so.1       libnss_files-2.3.3.so    libresolv-2.3.3.so
 libanl-2.3.3.so           libgcc_s.so.1           libnss_files.so.2        libresolv.so.2
 libanl.so.1               libm-2.3.3.so           libnss_hesiod-2.3.3.so   librt-2.3.3.so
 libBrokenLocale-2.3.3.so  libmemusage.so          libnss_hesiod.so.2       librt.so.1
 libBrokenLocale.so.1      libm.so.6               libnss_nis-2.3.3.so      libSegFault.so
 libc-2.3.3.so             libnsl-2.3.3.so         libnss_nisplus-2.3.3.so  libstdc++.so.6
 libcrypt-2.3.3.so         libnsl.so.1             libnss_nisplus.so.2      libthread_db-1.0.so
 libcrypt.so.1             libnss_compat-2.3.3.so  libnss_nis.so.2          libthread_db.so.1
 libc.so.6                 libnss_compat.so.2      libpcprofile.so          libutil-2.3.3.so
 libdl-2.3.3.so            libnss_dns-2.3.3.so     libpthread-0.10.so       libutil.so.1
 
 guide me where Iam wrong
 Prakash
 
 
				
---------------------------------
 Jiyo cricket on Yahoo! India cricket
Yahoo! Messenger Mobile Stay in touch with your buddies all the time.
--0-513996594-1146117999=:54568
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi, <br>  Iam trying to run linux 2.4.26 from mvista in xilinx XUPV2P board. <br>  During booting I get this error message, <br> <br> Mounted devfs on /dev <br>  . <br>  Freeing unused kernel memory: 60k init <br>  init started: &nbsp;BusyBox v1.1.2 (2006.04.24-13:20+0000) multi-call binary <br>  Starting pid 11, console /dev/console: '/etc/init.d/rcS' <br>  Bummer, could not run '/etc/init.d/rcS': No such file or directory <br>  Bummer, could not run <br>  ML300 powerpc linux 2.4.21-pre7 E.I.S. edition <br>  (none) login: <br>  . <br>  But I could see in the generated root file system this file is there. <br>  Even its not logging with anything. <br>   <div>My inittab file is <br> ::sysinit:/etc/init.d/rcS <br> #::askfirst:-/bin/sh <br> ::ctrlaltdel:/sbin/reboot <br> ::shutdown:/sbin/swapoff -a <br> ::shutdown:/bin/umount -a -r <br> ::restart:/sbin/init <br> ::respawn:/sbin/getty 9600 tts/0 <br> </div> <div>Without init options specified in busybox configuration I got,
 <br> . <br> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0. <br> EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended <br> VFS: Mounted root (ext2 filesystem). <br> mount_devfs_fs(): unable to mount devfs, err: -5 <br> Freeing unused kernel memory: 60k init <br> Warning: unable to open an initial console. <br> Kernel panic: No init found. &nbsp;Try passing init= option to kernel. </div> Some replies in usenet, which I answered,<br> <br> - x bits set for this shell script? <br> SInce Iam new to this embedded linux, could you tell whats that x bits means, is it exec permission (if so for whom,root?). <br> <br> &nbsp;- does a shell run? <br> Iam not clear why does it say /etc/init.d/rcS is not there, while its definitely there.<br> I feel shell is not running. I want to just put what I get in minicom<br> ----------------------------------------------------------------------------------------------------------------------------------------<br> loaded
 at:&nbsp;&nbsp;&nbsp;&nbsp; 00400000 004C11E4<br> board data at: 004BE13C 004BE154<br> relocated to:&nbsp; 00405634 0040564C<br> zimage at:&nbsp;&nbsp;&nbsp;&nbsp; 00405BF9 004BDD33<br> avail ram:&nbsp;&nbsp;&nbsp;&nbsp; 004C2000 10000000<br> <br> Linux/PPC load: console=ttyS0,9600 root=/dev/xsysace/disc0/part2 rw<br> Uncompressing Linux...done.<br> Now booting the kernel<br> Linux version 2.4.26 (root@edvl28.cedt.iisc.ernet.in) (gcc version 3.4.1) #16 Sat Apr 22 15:19:6Xilinx Virtex-II Pro port (C) 2002 MontaVista Software, Inc. (source@mvista.com)<br> On node 0 totalpages: 65536<br> zone(0): 65536 pages.<br> zone(1): 0 pages.<br> zone(2): 0 pages.<br> Kernel command line: console=ttyS0,9600 root=/dev/xsysace/disc0/part2 rw<br> Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFE000<br> Calibrating delay loop... 299.00 BogoMIPS<br> Memory: 257332k available (1284k kernel code, 380k data, 60k init, 0k highmem)<br> Dentry cache hash table entries: 32768 (order: 6, 262144
 bytes)<br> Inode cache hash table entries: 16384 (order: 5, 131072 bytes)<br> Mount cache hash table entries: 512 (order: 0, 4096 bytes)<br> Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)<br> Page-cache hash table entries: 65536 (order: 6, 262144 bytes)<br> POSIX conformance testing by UNIFIX<br> Linux NET4.0 for Linux 2.4<br> Based upon Swansea University Computer Society NET3.039<br> Initializing RT netlink socket<br> Starting kswapd<br> devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)<br> devfs: boot_options: 0x1<br> JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis Communications AB.<br> pty: 256 Unix98 ptys configured<br> Serial driver version 5.05c (2001-07-08) with no serial options enabled<br> ttyS00 at 0xfdfff003 (irq = 29) is a 16550A<br> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize<br> loop: loaded (max 8 devices)<br> Partition check:<br> &nbsp;xsysacea: p1 p2<br> System ACE at 0x41800000 mapped to
 0xD1070000, irq=30, 250880KB<br> eth0: using fifo mode.<br> eth0: No PHY detected.&nbsp; Assuming a PHY at address 0.<br> eth0: Xilinx EMAC #0 at 0x40C00000 mapped to 0xD1083000, irq=31<br> eth0: id 2.0h; block id 7, type 1<br> SCSI subsystem driver Revision: 1.00<br> NET4: Linux TCP/IP 1.0 for NET4.0<br> IP Protocols: ICMP, UDP, TCP, IGMP<br> IP: routing cache hash table of 2048 buckets, 16Kbytes<br> TCP: Hash tables configured (established 16384 bind 32768)<br> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.<br> EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended<br> VFS: Mounted root (ext2 filesystem).<br> Mounted devfs on /dev<br> Freeing unused kernel memory: 60k init<br> init started:&nbsp; BusyBox v1.1.2 (2006.04.27-03:52+0000) multi-call binary<br> Starting pid 11, console /dev/console: '/etc/init.d/rcS'<br> Bummer, could not run '/etc/init.d/rcS': No such file or directory<br> Bummer, could not run '/etc/init.d/rcS': No such file<br> ML300
 powerpc linux 2.4.21-pre7 E.I.S. edition<br> (none) login:<br> -----------------------------------------------------------------------------------------------------------------------------------<br> Here If I type su or root or whatever it asks password but always says incorrect login.<br> <br> - try init=/bin/sh as a kernel parameter. Does it run?<br> My init tab file is <br> ----------------------------------------------------------------------------------------------------------------------------<br> ::init=/bin/sh<br> ::sysinit:/etc/init.d/rcS<br> #::askfirst:-/bin/sh<br> ::ctrlaltdel:/sbin/reboot<br> ::shutdown:/sbin/swapoff -a<br> ::shutdown:/bin/umount -a -r<br> ::restart:/sbin/init<br> ::respawn:/sbin/getty 9600 tts/0<br> ------------------------------------------------------------------------------------------------------------------------------<br> <br> The log is <br> ..........<br> VFS: Mounted root (ext2 filesystem).<br> mount_devfs_fs(): unable to mount
 devfs, err: -5<br> Freeing unused kernel memory: 60k init<br> Warning: unable to open an initial console.<br> Kernel panic: No init found.&nbsp; Try passing init= option to kernel.<br> &nbsp;&lt;0&gt;Rebooting in 180 seconds..<br> -----------------------------------------------------------------------------------------------------------------<br> <br> &nbsp;- all needed libraries to run available on your target?<br> I feel yes, as I could see these in lib folder of my RFS.<br> <br> ld-2.3.3.so&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; libdl.so.2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; libnss_dns.so.2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; libpthread.so.0<br> ld.so.1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; libgcc_s_nof.so.1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; libnss_files-2.3.3.so&nbsp;&nbsp;&nbsp;
 libresolv-2.3.3.so<br> libanl-2.3.3.so&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; libgcc_s.so.1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; libnss_files.so.2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; libresolv.so.2<br> libanl.so.1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; libm-2.3.3.so&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; libnss_hesiod-2.3.3.so&nbsp;&nbsp; librt-2.3.3.so<br> libBrokenLocale-2.3.3.so&nbsp; libmemusage.so&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; libnss_hesiod.so.2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; librt.so.1<br> libBrokenLocale.so.1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; libm.so.6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; libnss_nis-2.3.3.so&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; libSegFault.so<br> libc-2.3.3.so&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 libnsl-2.3.3.so&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; libnss_nisplus-2.3.3.so&nbsp; libstdc++.so.6<br> libcrypt-2.3.3.so&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; libnsl.so.1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; libnss_nisplus.so.2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; libthread_db-1.0.so<br> libcrypt.so.1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; libnss_compat-2.3.3.so&nbsp; libnss_nis.so.2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; libthread_db.so.1<br> libc.so.6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; libnss_compat.so.2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; libpcprofile.so&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; libutil-2.3.3.so<br> libdl-2.3.3.so&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; libnss_dns-2.3.3.so&nbsp;&nbsp;&nbsp;&nbsp; libpthread-0.10.so&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; libutil.so.1<br>
 <br> guide me where Iam wrong<br> Prakash<br> <br> <p>
	

	
		<hr size=1> 
Jiyo cricket on <a href="http://us.rd.yahoo.com/mail/in/mailcricket/*http://in.sports.yahoo.com/cricket/">Yahoo! India cricket</a><br>
<a href="http://us.rd.yahoo.com/mail/in/mailmobilemessenger/*http://in.mobile.yahoo.com/new/messenger/">Yahoo! Messenger Mobile</a> Stay in touch with your buddies all the time.
--0-513996594-1146117999=:54568--
