Date: Tue, 25 Sep 2001 17:14:36 +0200
From: Xavier Grave <grave@ipno.in2p3.fr>
To: yah <hay8888@21cn.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: request_module
Message-ID: <20010925171436.A1533@ipnpcu5.in2p3.fr>
References: <gF989074824291.01580@webmail5.inner-21cn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
In-Reply-To: <gF989074824291.01580@webmail5.inner-21cn.com>; from hay8888@21cn.com on mar, sep 25, 2001 at 11:57:08 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Perhaps you need to put a good ide support in the kernel ?

Your kernel doesn't seem to "see" your ide driver.
Can you send your .config file ?

Le mar, 25 sep 2001 11:57:08, yah a 閏rit :
>
> Hi,all.
>   I use MCP750 and linuxppc_2_4. I recompiled the kernel, use
> bugboot,fill it in the onboard flash(bank A), and I put root file system
> on ATA flash(hda1).Then I boot the system,but failed. Following is the
> boot info.
>
> Linux/PPC load: root=/dev/hda1 init=/bin/init
> Uncompressing Linux...done.
> Now booting the kernel
> Ramsize from residual data was 0 -- Probing for value
> Ramsize default to be 32M
> Total memory = 32MB; using 128kB for hash table (at c0160000)
> Linux version 2.4.6-pre2 (root@amy.w-ibeda.com) (gcc version 2.95.2
> 19991024 (r1
> PReP architecture
> On node 0 totalpages: 8192
> zone(0): 8192 pages.
> zone(1): 0 pages.
> zone(2): 0 pages.
> Kernel command line: root=/dev/hda1 init=/bin/init
> time_init: decrementer frequency = 16.666516 MHz
> Calibrating delay loop... 732.36 BogoMIPS
> Memory: 30676k available (820k kernel code, 460k data, 92k init, 0k
> highmem)
> Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
> Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
> Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
> POSIX conformance testing by UNIFIX
> PCI: Probing PCI hardware
> Fixup mem res, dev: 0.0, res_start: ffffff00->bfffff00
> PCI: device 00:06.0 has unknown header type 7f, ignoring.
> PCI: device 00:07.0 has unknown header type 7f, ignoring.
> PCI: device 00:0b.0 has unknown header type 7f, ignoring.
> Fixup mem res, dev: 0.10, res_start: ffff0000->bfff0000
> Fixup mem res, dev: 0.11, res_start: ffff0000->bfff0000
> Fixup mem res, dev: 0.12, res_start: ffff0000->bfff0000
> Fixup mem res, dev: 0.13, res_start: ffff0000->bfff0000
> Fixup mem res, dev: 0.14, res_start: ffff0000->bfff0000
> Fixup mem res, dev: 0.15, res_start: ffff0000->bfff0000
> Fixup mem res, dev: 0.16, res_start: ffff0000->bfff0000
> Setting PCI interrupts for a "Mesquite cPCI (MCP750) w/ HAC"
> Relocating PCI address cf20fffc -> 120fffc
> PCI:0:0:0: Resource 00fffffc-00ffffff (f=10f)
> PCI:0:0:0: Resource bfffff00-bfffffff (f=200)
> PCI:0:1:0: Resource 0000fffc-0000ffff (f=10f)
> PCI:0:10:0: Resource bfff0000-bfffffff (f=200)
> PCI: Cannot allocate resource region 4 of device 00:10.0
> PCI:0:11:0: Resource bfff0000-bfffffff (f=200)
> PCI: Cannot allocate resource region 4 of device 00:11.0
> PCI:0:12:0: Resource bfff0000-bfffffff (f=200)
> PCI: Cannot allocate resource region 4 of device 00:12.0
> PCI:0:13:0: Resource bfff0000-bfffffff (f=200)
> PCI: Cannot allocate resource region 4 of device 00:13.0
> PCI:0:14:0: Resource bfff0000-bfffffff (f=200)
> PCI: Cannot allocate resource region 4 of device 00:14.0
> PCI:0:15:0: Resource bfff0000-bfffffff (f=200)
> PCI: Cannot allocate resource region 4 of device 00:15.0
> PCI:0:16:0: Resource bfff0000-bfffffff (f=200)
> PCI: Cannot allocate resource region 4 of device 00:16.0
> PCI:0:3:0: Resource 0120fffc-0120ffff (f=10f)
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Starting kswapd v1.8
> Serial driver version 5.05a (2001-03-20) with MANY_PORTS SHARE_IRQ
> SERIAL_PCI ed
> ttyS00 at 0x03f8 (irq = 4) is a 16550A
> ttyS01 at 0x02f8 (irq = 3) is a 16550A
> block: queued sectors max/low 20304kB/6768kB, 64 slots per queue
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP
> IP: routing cache hash table of 512 buckets, 4Kbytes
> TCP: Hash tables configured (established 2048 bind 2048)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> request_module[block-major-3]: Root fs not mounted
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> VFS: Cannot open root device "hda1" or 03:01
> Please append a correct "root=" boot option
> Kernel panic: VFS: Unable to mount root fs on 03:01
> Rebooting in 180 seconds..
>
>   Any ideas?
> ------------------------------------------------
> 想免受广告信的骚扰，请马上升级为21cn经济邮用户。
> http://member.21cn.com/economy/upgrade.php
> 还有更便宜的吗？
> http://adinfo.21cn.com/price/001.html
> 加入龙腾计划，与21cn齐飞。
> http://www.21cn.com/21cnhtm/qy/index.html
>
>
>
>
--
33 (0) 1 69 15 79 59
De chacun selon ses forces, a chacun selon ses besoins

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
