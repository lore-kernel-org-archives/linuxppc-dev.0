Date: Wed, 1 Aug 2001 16:57:01 -0300
From: Ricardo Scop <scop@digitel.com.br>
Message-ID: <1706.010801@digitel.com.br>
To: "Mike O'Brien" <mobrien@airfiber.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Hanging in Init
In-reply-To: <000101c11ab4$0fc48f60$6865a8c0@airfiber.com>
References: <000101c11ab4$0fc48f60$6865a8c0@airfiber.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mike,

As far as I know, Linux requires IMMR = 0xF0000000. Read the file
./Documentation/powerpc/SBC8260_memory_mapping.txt in the Linux source
tree for more information.

[]'s, Scop                            mailto:scop@digitel.com.br

Wednesday, August 01, 2001, 3:01:59 PM, you wrote:


MOB> I have been trying to get a custom PPC860 board up using MonteVista's Hard
MOB> Hat
MOB> 2.0 distribution using a vxWorks bootrom.  I have made alot of progress in
MOB> the last
MOB> few days but have got stuck at the point here init is executed.  The IMMR is
MOB> set
MOB> to 0x02200000.  I ran across some old posts on the list referring to this
MOB> being set
MOB> too low for linux.  Could this be the problem?  If not does anyone have any
MOB> suggestions on what could be wrong?  Attached is the boot up output from the
MOB> console.

MOB> Thanks,
MOB> Mike O'Brien

MOB> Attaching network interface cpm0... done.
MOB> Attaching network interface lo0... done.
MOB> Loading... 504934
MOB> WARNING: CRC mismatch (calculated 0x1a946201 expected 0x017c1f7c)
MOB> Starting at 0x1180000...

MOB> loaded at:     01180000 0118A1DC
MOB> relocated to:  00180000 0018A1DC
MOB> board data at: 001801C0 001801DC
MOB> relocated to:  00200100 0020011C
MOB> zimage at:     01187000 011F828A
MOB> avail ram:     00201000 02000000

MOB> Linux/PPC load: root=/dev/nfs rw init=/bin/sh
MOB> Uncompressing Linux...done.
MOB> Now booting the kernel
MOB> Linux version 2.4.2_hhl20 (root@palm) (gcc version 2.95.3 20010315
MOB> (release/Mon1
MOB> On node 0 totalpages: 8192
MOB> zone(0): 8192 pages.
MOB> zone(1): 0 pages.
MOB> zone(2): 0 pages.
MOB> Kernel command line: root=/dev/nfs rw init=/bin/sh
MOB> Decrementer Frequency = 123750000/60
MOB> Warning: real time clock seems stuck!
MOB> Calibrating delay loop... 32.87 BogoMIPS
MOB> Memory: 30940k available (864k kernel code, 320k data, 48k init, 0k highmem)
MOB> Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
MOB> Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
MOB> Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
MOB> Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
MOB> POSIX conformance testing by UNIFIX
MOB> Calling smp_init()...
MOB> Calling kernel_thread()...
MOB> Calling unlock_kernel()...
MOB> Entered init()...
MOB> Calling do_basic_setup()...
MOB> Linux NET4.0 for Linux 2.4
MOB> Based upon Swansea University Computer Society NET3.039
MOB> Starting kswapd v1.8
MOB> i2c-core.o: i2c core module
MOB> CPM UART driver version 0.03
MOB> ttyS00 at 0x0280 is a SMC
MOB> pty: 256 Unix98 ptys configured
MOB> block: queued sectors max/low 20488kB/6829kB, 64 slots per queue
MOB> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
MOB> eth0: CPM ENET Version 0.2 on SCC1, 08:00:3e:26:15:59
MOB> loop: loaded (max 8 devices)
MOB> NET4: Linux TCP/IP 1.0 for NET4.0
MOB> IP Protocols: ICMP, UDP, TCP, IGMP
MOB> IP: routing cache hash table of 512 buckets, 4Kbytes
MOB> TCP: Hash tables configured (established 2048 bind 2048)
MOB> Sending BOOTP requests.... OK
MOB> IP-Config: Got BOOTP answer from 192.168.101.239, my address is
MOB> 192.168.101.98
MOB> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
MOB> Looking up port of RPC 100003/2 on 192.168.101.239
MOB> Looking up port of RPC 100005/2 on 192.168.101.239
MOB> VFS: Mounted root (nfs filesystem).
MOB> Freeing unused kernel memory: 48k init 4k openfirmware
MOB> Unlock kernel...
MOB> Open console...
MOB> Call /sbin/init...

MOB> [hang]

MOB> ** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
