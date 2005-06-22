Return-Path: <vbordug@mail.dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 29A4667A6F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Jun 2005 05:49:24 +1000 (EST)
Date: Wed, 22 Jun 2005 23:49:21 +0400
From: vbordug@ru.mvista.com
To: vinod b <bvinodsmail@gmail.com>
Message-ID: <20050622194921.GB28212@server.dev.rtsoft.ru>
References: <198df04d0506212149550448ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <198df04d0506212149550448ed@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: booting linux on powerpc 405
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello.I am not an expert regarding this board but the output below looks like it is something wrong with root fs-like you use a rfs built for another arch. Just a pure guess..

On Wed, Jun 22, 2005 at 10:19:37AM +0530, vinod b wrote:
> thanks for the response sir.
> 
> sir i created nodes on the dev directory using the command mknode.Even after 
> doing this i have problem.I do not know if there is any problem with nfs 
> server.But as it is seen in the output on the minicom window sigseg signal 
> occeurs then kernel panic happens.So how can this problem be solved.
> 
> I am sending the new output 
> Welcome to minicom 2.00.0
> 
> OPTIONS: History Buffer, F-key Macros, Search History Buffer, I18n
> Compiled on Jan 25 2003, 00:15:18.
> 
> Press CTRL-A Z for help on special keys
> 
> 
> 
> 405GP 1.13 ROM Monitor (4/7/00)
> 
> --------------------- System Info ----------------------
> Processor = 405GP, PVR: 40110082
> Processor speed = 200 MHz
> PLB speed = 100 MHz
> OPB speed = 50 MHz
> Ext Bus speed = 50 MHz
> PCI Bus speed = 33 MHz (Sync)
> Amount of SDRAM = 32 MBytes
> Internal PCI arbiter enabled
> --------------------------------------------------------
> 
> --- Device Configuration ---
> Power-On Test Devices:
> 000 Disabled System Memory [RAM]
> 001 Disabled Ethernet [ENET]
> 004 Disabled Serial Port 2 [S2]
> ----------------------------
> Boot Sources:
> 001 Enabled Ethernet [ENET]
> local=192.0.1.253 <http://192.0.1.253> remote=192.0.1.50
> <http://192.0.1.50>hwaddr=0004ace30f38
> 004 Disabled Serial Port 2 [S2]
> local=8.1.1.2 <http://8.1.1.2>
> remote=255.255.255.255<http://255.255.255.255>hwaddr=ffffffffffff
> 005 Disabled Serial Port 1 [S1]
> ----------------------------
> Debugger: Disabled
> ----------------------------
> 1 - Enable/disable tests
> 2 - Enable/disable boot devices
> 3 - Change IP addresses
> 4 - Ping test
> 5 - Toggle ROM monitor debugger
> 6 - Toggle automatic menu
> 7 - Display configuration
> 8 - Save changes to configuration
> 9 - Set baud rate for s1 boot
> A - Enable/disable I cache (Enabled )
> B - Enable/disable D cache (Disabled)
> 0 - Exit menu and continue
> ->0
> ENET Speed is 100 Mbs...
> FULL duplex connection
> Booting from [ENET] Ethernet ...
> Sending bootp request ...
> 
> 
> Loading file "/tftpboot/zImage.treeboot" ...
> Sending tftp boot request ...
> Transfer Complete ...
> Loaded successfully ...
> Entry point at 0x500000 ...
> 
> loaded at: 00500000 0059E1F8
> relocated to: 00400000 0049E1F8
> board data at: 0049B128 0049B168
> relocated to: 00405470 004054B0
> zimage at: 004059AC 0049A376
> avail ram: 0049F000 02000000
> 
> Linux/PPC load: root=/dev/nfs rw ip=on
> Uncompressing Linux...done.
> Now booting the kernel
> Linux version 2.4.18_mvl30-405ep_eval (root@sairam) (gcc version
> 3.2.1200209305IBM Walnut (IBM405GP) Platform
> Port by MontaVista Software, Inc. (source@mvista.com)
> On node 0 totalpages: 8192
> zone(0): 8192 pages.
> zone(1): 0 pages.
> zone(2): 0 pages.
> Kernel command line: root=/dev/nfs rw ip=on
> Calibrating delay loop... 199.47 BogoMIPS
> Memory: 30800k available (1024k kernel code, 332k data, 72k init, 0k 
> highmem)
> Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
> Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
> Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
> POSIX conformance testing by UNIFIX
> PCI: Probing PCI hardware
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> OCP uart ver 1.2.1 init complete
> Starting kswapd
> Disabling the Out Of Memory Killer
> i2c-core.o: i2c core module version 2.6.2 (20011118)
> initialize_kbd: Keyboard reset failed, no ACK
> Detected PS/2 Mouse Port.
> Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
> SERIAL_PCI edttyS00 at 0xef600300 (irq = 0) is a 16550A
> ttyS01 at 0xef600400 (irq = 1) is a 16550A
> block: 64 slots per queue, batch=16
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> loop: loaded (max 8 devices)
> eth0: Phy @ 0x1, type DP83843 (0x20005c10)
> Reset ethernet interfaces
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 512 buckets, 4Kbytes
> TCP: Hash tables configured (established 2048 bind 4096)
> opening eth0 on emac 0
> eth0: IBM EMAC: link up, 100 Mbps Full Duplex, auto-negotiation complete.
> eth0: IBM EMAC: MAC 00:04:ac:e3:0f:38.
> eth0: IBM EMAC: open completed
> Sending BOOTP and RARP requests . OK
> IP-Config: Got BOOTP answer from 192.0.1.50 <http://192.0.1.50>, my address 
> is 192.0.1.253 <http://192.0.1.253>
> IP-Config: Complete:
> device=eth0, addr=192.0.1.253 <http://192.0.1.253>,
> mask=255.255.255.0<http://255.255.255.0>,
> gw=255.255.255.255 <http://255.255.255.255>,
> host=192.0.1.253 <http://192.0.1.253>, domain=, nis-domain=(none),
> bootserver=192.0.1.50 <http://192.0.1.50>,
> rootserver=192.0.1.50<http://192.0.1.50>,
> rootpath=/home/vinod/target
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> Looking up port of RPC 100003/2 on 192.0.1.50 <http://192.0.1.50>
> Looking up port of RPC 100005/1 on 192.0.1.50 <http://192.0.1.50>
> VFS: Mounted root (nfs filesystem).
> Freeing unused kernel memory: 72k init
> Oops: kernel access of bad area, sig: 11
> NIP: C00EB22C XER: 00000000 LR: C00E900C SP: C0121CB0 REGS: c0121bf0 TRAP: 
> 0800dMSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> DEAR: 00000000, ESR: 00000000
> TASK = c011fff0[0] 'swapper' Last syscall: 120
> last math 00000000 last altivec 00000000
> PLB0: bear= 0x10000000 acr= 0x00000000 besr= 0x00000000
> PLB0 to OPB: bear= 0x00001024 besr0= 0x00000000 besr1= 0x00000000
> 
> GPR00: 00000000 C0121CB0 C011FFF0 C1FD0060 C0121CE8 C0121D08 00000000 
> C1FD6000
> GPR08: C0121D60 00000000 00000000 00000000 44000044 00020000 000C0804 
> 00000000
> GPR16: 00020000 FFFE21AD C0121D58 C0121D58 00000153 00000001 C1FD5D00 
> 00000000
> GPR24: 00000000 C0121CE8 C0121D08 C0121D08 C0121CE8 C1FB0280 00000000 
> C1FD6000
> Call backtrace:
> 00000000 C00E900C C00BD16C C00BD280 C00C0124 C00BFC24 C00B115C
> C0017684 C0003BE0 C0002B4C C00215D4 C00040A8 C00040D0 C0002418
> C01317A8 C0002318
> Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing
> 
> 
> 
> -- 
> vinod
> S.S.S.I.H.L

> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
