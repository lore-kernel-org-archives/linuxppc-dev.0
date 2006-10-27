Return-Path: <pradeepsampath@yahoo.com>
Received: from web83212.mail.mud.yahoo.com (web83212.mail.mud.yahoo.com
	[216.252.101.68]) by ozlabs.org (Postfix) with SMTP id 6661667E3A
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Oct 2006 05:20:27 +1000 (EST)
Message-ID: <20061027192025.26161.qmail@web83212.mail.mud.yahoo.com>
Date: Fri, 27 Oct 2006 12:20:25 -0700 (PDT)
From: Pradeep Sampath <pradeepsampath@yahoo.com>
Subject: TEMAC drivers for kernel 2.6.17.1
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-789608402-1161976825=:25298"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-789608402-1161976825=:25298
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,
   
  I am using linux kernel 2.6.17.1 on ML403 dev board. I am trying to get the TEMAC to work but with no success. I applied TEMAC patches from http://source.mvista.com/~ank/paulus-powerpc/20060309/. But the ethernet interface does not seem to come up. 

  Is there any other TEMAC patch out there which is known to work with 2.6 kernel? 
   
  For the BSP I tried using the ML403 EDK Embedded PowerPC reference design from Xilinx. But it doesn't come with a PLB TEMAC in the design. I also tried to use xapp902 which has the PLB TEMAC module. But on running "Generate Libraries and BSPs" it does not generate any sources code under "drivers" or "arch" folder.
   
  -Pradeep
   
  I have attached the boot up logs from the hyper-terminal.
loaded at:     00400000 0051913C
board data at: 00517124 0051713C
relocated to:  004050E0 004050F8
zimage at:     004057F5 00516F4D
avail ram:     0051A000 10000000
  Linux/PPC load: console=ttyS0,9600 root=/dev/xsa2
  Uncompressing Linux...done.
Now booting the kernel
[    0.000000] Linux version 2.6.17.1 (psampath@psampath-test) (gcc version 3.4.
1) #5 Sun Oct 22 10:25:16 PDT 2006
[    0.000000] Xilinx ML403 Reference System (Virtex-4 FX)
[    0.000000] Built 1 zonelists
[    0.000000] Kernel command line: console=ttyS0,9600 root=/dev/xsa2
[    0.000000] Xilinx INTC #0 at 0xD1000FC0 mapped to 0xFDFFEFC0
[    0.000000] PID hash table entries: 2048 (order: 11, 8192 bytes)
[    0.000183] Console: colour dummy device 80x25
[    0.001962] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.005114] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.060120] Memory: 257280k available (1808k kernel code, 616k data, 84k init
, 0k highmem)
[    0.248262] Security Framework v1.0.0 initialized
[    0.248328] SELinux:  Disabled at boot.
[    0.248481] Mount-cache hash table entries: 512
[    0.254057] NET: Registered protocol family 16
[    0.262730] NET: Registered protocol family 2
[    0.316488] IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.317422] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.317970] TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
[    0.318284] TCP: Hash tables configured (established 8192 bind 4096)
[    0.318320] TCP reno registered
[    0.325013] audit: initializing netlink socket (disabled)
[    0.325150] audit(0.324:1): initialized
[    0.326666] VFS: Disk quotas dquot_6.5.1
[    0.326910] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.327817] Initializing Cryptographic API
[    0.327891] io scheduler noop registered
[    0.328088] io scheduler anticipatory registered (default)
[    0.328173] io scheduler deadline registered
[    0.328345] io scheduler cfq registered
[    0.946309] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing
enabled
[    0.955054] serial8250.0: ttyS0 at MMIO 0xa0001003 (irq = 9) is a 16450
[    3.002532] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 bloc
ksize
[    3.093986]  xsa: xsa1 xsa2
[    3.138222] i8042.c: No controller found.
[    3.186302] TCP bic registered
[    3.222088] NET: Registered protocol family 8
[    3.274064] NET: Registered protocol family 20
  [    3.336810] EXT3-fs: INFO: recovery required on readonly filesystem.
[    3.412076] EXT3-fs: write access will be enabled during recovery.
[    3.717927] kjournald starting.  Commit interval 5 seconds
[    3.782937] EXT3-fs: recovery complete.
[    3.870012] EXT3-fs: mounted filesystem with ordered data mode.
[    3.940755] VFS: Mounted root (ext3 filesystem) readonly.
[    4.004944] Freeing unused kernel memory: 84k init
INIT: version 2.78 booting
Activating swap...
/etc/init.d/rcS: /dev/null: Read-only file system
[    9.866081] EXT3-fs warning: mounting unchecked fs, running e2fsck is recomme
nded
[    9.957819] EXT3 FS on xsa2, internal journal
Checking all file systems...
fsck 1.27 (8-Mar-2002)
Calculating module dependencies... depmod: QM_MODULES: Function not implemented
  done.
Loading modules:
modprobe: Can't open dependencies file /lib/modules/2.6.17.1/modules.dep (No suc
h file or directory)
Mounting local filesystems...
nothing was mounted
Cleaning: /etc/network/ifstate.
Setting up IP spoofing protection: rp_filter.
Disable TCP/IP Explicit Congestion Notification: done.
Configuring network interfaces: done.
Starting portmap daemon: portmap.
Starting dhcpcd on eth0
Running ntpdate to synchronize clock.
Cleaning: /tmp /var/lock /var/runfind: ./syslogd.pid: Input/output error
find: ./syslogd.pid: Input/output error
find: ./inetd.pid: Input/output error
find: ./inetd.pid: Input/output error
dhcpcd[734]: dhcpStart: socket: Address family not supported by protocol
  .
  sed: can't read /etc/motd: Input/output error
INIT: Entering runlevel: 3': Input/output
Starting kernel log daemon: klogd.
Starting system log daemon: syslogd
  Starting web server: apache.
Starting internet superserver: inetdstart-stop-daemon: open pidfile /var/run/ine
td.pid: Input/output error
.
Hostname: ml403.
Creating barrier for shutdown
Starting X11 session for user 'linux'
PAM_unix[966]: (su) session opened for user linux by (uid=0)
Welcome to the ML403 Evaluation Board
(C) 2004 Xilinx, I
MontaVista(R) Linux(R) Professional Edition 3.1
  ml403 login: root
PAM-securetty[988]: Couldn't open /etc/securetty
Password:
PAM_unix[988]: (login) session opened for user root by LOGIN(uid=0)
Last login: Thu Jan  1 00:16:05 1970 on console
login[988]: ROOT LOGIN on `console'
  root@ml403:~#

--0-789608402-1161976825=:25298
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<DIV>Hi,</DIV>  <DIV>&nbsp;</DIV>  <DIV>I am using linux kernel 2.6.17.1 on ML403 dev board. I am trying to get the TEMAC to work but with no success. I applied&nbsp;TEMAC patches from <A href="http://source.mvista.com/~ank/paulus-powerpc/20060309/" target=_blank rel=nofollow _><FONT color=#003399>http://source.mvista.com/~ank/paulus-powerpc/20060309/</FONT></A>. But the ethernet interface does not seem to come up.&nbsp;<BR></DIV>  <DIV>Is there any other TEMAC patch out there which is known to work with 2.6 kernel?&nbsp;</DIV>  <DIV>&nbsp;</DIV>  <DIV>For the BSP I tried using the ML403 EDK Embedded PowerPC reference design from Xilinx. But it doesn't come with a PLB TEMAC in the design. I also tried to use xapp902 which has the PLB TEMAC module. But on running "Generate Libraries and BSPs" it does not generate any sources code under "drivers" or "arch" folder.</DIV>  <DIV>&nbsp;</DIV>  <DIV>-Pradeep</DIV>  <DIV>&nbsp;</DIV>  <DIV>I have attached the boot up logs from the
 hyper-terminal.<BR>loaded at:&nbsp;&nbsp;&nbsp;&nbsp; 00400000 0051913C<BR>board data at: 00517124 0051713C<BR>relocated to:&nbsp; 004050E0 004050F8<BR>zimage at:&nbsp;&nbsp;&nbsp;&nbsp; 004057F5 00516F4D<BR>avail ram:&nbsp;&nbsp;&nbsp;&nbsp; 0051A000 10000000</DIV>  <DIV>Linux/PPC load: console=ttyS0,9600 root=/dev/xsa2</DIV>  <DIV>Uncompressing Linux...done.<BR>Now booting the kernel<BR>[&nbsp;&nbsp;&nbsp; 0.000000] Linux version 2.6.17.1 (<A href="http://us.f832.mail.yahoo.com/ym/Compose?To=psampath@psampath-test" target=_blank rel=nofollow _><FONT color=#003399>psampath@psampath-test</FONT></A>) (gcc version 3.4.<BR>1) #5 Sun Oct 22 10:25:16 PDT 2006<BR>[&nbsp;&nbsp;&nbsp; 0.000000] Xilinx ML403 Reference System (Virtex-4 FX)<BR>[&nbsp;&nbsp;&nbsp; 0.000000] Built 1 zonelists<BR>[&nbsp;&nbsp;&nbsp; 0.000000] Kernel command line: console=ttyS0,9600 root=/dev/xsa2<BR>[&nbsp;&nbsp;&nbsp; 0.000000] Xilinx INTC #0 at 0xD1000FC0 mapped to 0xFDFFEFC0<BR>[&nbsp;&nbsp;&nbsp;
 0.000000] PID hash table entries: 2048 (order: 11, 8192 bytes)<BR>[&nbsp;&nbsp;&nbsp; 0.000183] Console: colour dummy device 80x25<BR>[&nbsp;&nbsp;&nbsp; 0.001962] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)<BR>[&nbsp;&nbsp;&nbsp; 0.005114] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)<BR>[&nbsp;&nbsp;&nbsp; 0.060120] Memory: 257280k available (1808k kernel code, 616k data, 84k init<BR>, 0k highmem)<BR>[&nbsp;&nbsp;&nbsp; 0.248262] Security Framework v1.0.0 initialized<BR>[&nbsp;&nbsp;&nbsp; 0.248328] SELinux:&nbsp; Disabled at boot.<BR>[&nbsp;&nbsp;&nbsp; 0.248481] Mount-cache hash table entries: 512<BR>[&nbsp;&nbsp;&nbsp; 0.254057] NET: Registered protocol family 16<BR>[&nbsp;&nbsp;&nbsp; 0.262730] NET: Registered protocol family 2<BR>[&nbsp;&nbsp;&nbsp; 0.316488] IP route cache hash table entries: 2048 (order: 1, 8192 bytes)<BR>[&nbsp;&nbsp;&nbsp; 0.317422] TCP established hash table entries: 8192 (order: 3, 32768
 bytes)<BR>[&nbsp;&nbsp;&nbsp; 0.317970] TCP bind hash table entries: 4096 (order: 2, 16384 bytes)<BR>[&nbsp;&nbsp;&nbsp; 0.318284] TCP: Hash tables configured (established 8192 bind 4096)<BR>[&nbsp;&nbsp;&nbsp; 0.318320] TCP reno registered<BR>[&nbsp;&nbsp;&nbsp; 0.325013] audit: initializing netlink socket (disabled)<BR>[&nbsp;&nbsp;&nbsp; 0.325150] audit(0.324:1): initialized<BR>[&nbsp;&nbsp;&nbsp; 0.326666] VFS: Disk quotas dquot_6.5.1<BR>[&nbsp;&nbsp;&nbsp; 0.326910] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)<BR>[&nbsp;&nbsp;&nbsp; 0.327817] Initializing Cryptographic API<BR>[&nbsp;&nbsp;&nbsp; 0.327891] io scheduler noop registered<BR>[&nbsp;&nbsp;&nbsp; 0.328088] io scheduler anticipatory registered (default)<BR>[&nbsp;&nbsp;&nbsp; 0.328173] io scheduler deadline registered<BR>[&nbsp;&nbsp;&nbsp; 0.328345] io scheduler cfq registered<BR>[&nbsp;&nbsp;&nbsp; 0.946309] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ
 sharing<BR>enabled<BR>[&nbsp;&nbsp;&nbsp; 0.955054] serial8250.0: ttyS0 at MMIO 0xa0001003 (irq = 9) is a 16450<BR>[&nbsp;&nbsp;&nbsp; 3.002532] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 bloc<BR>ksize<BR>[&nbsp;&nbsp;&nbsp; 3.093986]&nbsp; xsa: xsa1 xsa2<BR>[&nbsp;&nbsp;&nbsp; 3.138222] i8042.c: No controller found.<BR>[&nbsp;&nbsp;&nbsp; 3.186302] TCP bic registered<BR>[&nbsp;&nbsp;&nbsp; 3.222088] NET: Registered protocol family 8<BR>[&nbsp;&nbsp;&nbsp; 3.274064] NET: Registered protocol family 20</DIV>  <DIV>[&nbsp;&nbsp;&nbsp; 3.336810] EXT3-fs: INFO: recovery required on readonly filesystem.<BR>[&nbsp;&nbsp;&nbsp; 3.412076] EXT3-fs: write access will be enabled during recovery.<BR>[&nbsp;&nbsp;&nbsp; 3.717927] kjournald starting.&nbsp; Commit interval 5 seconds<BR>[&nbsp;&nbsp;&nbsp; 3.782937] EXT3-fs: recovery complete.<BR>[&nbsp;&nbsp;&nbsp; 3.870012] EXT3-fs: mounted filesystem with ordered data mode.<BR>[&nbsp;&nbsp;&nbsp; 3.940755] VFS: Mounted
 root (ext3 filesystem) readonly.<BR>[&nbsp;&nbsp;&nbsp; 4.004944] Freeing unused kernel memory: 84k init<BR>INIT: version 2.78 booting<BR>Activating swap...<BR>/etc/init.d/rcS: /dev/null: Read-only file system<BR>[&nbsp;&nbsp;&nbsp; 9.866081] EXT3-fs warning: mounting unchecked fs, running e2fsck is recomme<BR>nded<BR>[&nbsp;&nbsp;&nbsp; 9.957819] EXT3 FS on xsa2, internal journal<BR>Checking all file systems...<BR>fsck 1.27 (8-Mar-2002)<BR>Calculating module dependencies... depmod: QM_MODULES: Function not implemented</DIV>  <DIV>done.<BR>Loading modules:<BR>modprobe: Can't open dependencies file /lib/modules/2.6.17.1/modules.dep (No suc<BR>h file or directory)<BR>Mounting local filesystems...<BR>nothing was mounted<BR>Cleaning: /etc/network/ifstate.<BR>Setting up IP spoofing protection: rp_filter.<BR>Disable TCP/IP Explicit Congestion Notification: done.<BR>Configuring network interfaces: done.<BR>Starting portmap daemon: portmap.<BR>Starting dhcpcd on eth0<BR>Running
 ntpdate to synchronize clock.<BR>Cleaning: /tmp /var/lock /var/runfind: ./syslogd.pid: Input/output error<BR>find: ./syslogd.pid: Input/output error<BR>find: ./inetd.pid: Input/output error<BR>find: ./inetd.pid: Input/output error<BR>dhcpcd[734]: dhcpStart: socket: Address family not supported by protocol</DIV>  <DIV>.</DIV>  <DIV>sed: can't read /etc/motd: Input/output error<BR>INIT: Entering runlevel: 3': Input/output<BR>Starting kernel log daemon: klogd.<BR>Starting system log daemon: syslogd</DIV>  <DIV>Starting web server: apache.<BR>Starting internet superserver: inetdstart-stop-daemon: open pidfile /var/run/ine<BR>td.pid: Input/output error<BR>.<BR>Hostname: ml403.<BR>Creating barrier for shutdown<BR>Starting X11 session for user 'linux'<BR>PAM_unix[966]: (su) session opened for user linux by (uid=0)<BR>Welcome to the ML403 Evaluation Board<BR>(C) 2004 Xilinx, I<BR>MontaVista(R) Linux(R) Professional Edition 3.1</DIV>  <DIV>ml403 login: root<BR>PAM-securetty[988]:
 Couldn't open /etc/securetty<BR>Password:<BR>PAM_unix[988]: (login) session opened for user root by LOGIN(uid=0)<BR>Last login: Thu Jan&nbsp; 1 00:16:05 1970 on console<BR>login[988]: ROOT LOGIN on `console'</DIV>  <DIV><A href="http://us.f832.mail.yahoo.com/ym/Compose?To=root@ml403" target=_blank rel=nofollow _><FONT color=#003399>root@ml403</FONT></A>:~#</DIV>
--0-789608402-1161976825=:25298--
