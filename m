Date: Fri, 21 Mar 2003 00:51:29 -0800 (PST)
From: Paul White <pwhite@bivio.net>
To: Rahul Dev <rahuld@cdotd.ernet.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: no bash prompt
In-Reply-To: <3E7ACA85.26F72374@cdotd.ernet.in>
Message-ID: <Pine.LNX.4.21.0303210049190.7289-100000@stimpy.bivio.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Rahul,

I'm not familiar with an ads powerpc 8260 board, however if your
linux console is over a serial port, you will need to add an option
to your linux kernel command line:

"console=/dev/ttyS0" or "console=/dev/ttyS1"

I can see your passing nothing, due to:

> Boot arguments:
and
> Kernel command line:

Hope this helps!

Paul White
Bivio Networks, Inc.

On Fri, 21 Mar 2003, Rahul Dev wrote:

>
> Dear all,
>
>     I am running linux 2.4.2  over  ads  powerpc (8260) board.
>     Since , there is no support of scsi  controller over the board , i m
> using ramdisk image.
>
>     I m getting the following  prints:
>
> Linux version 2.4.2 (rahuld@hpv2k-35) (gcc version 3.0.4) #1
>  Fri Mar 7 15:30:25 IST 2003
> Boot arguments:
> On node 0 totalpages: 4095
> zone(0): 4095 pages.
> zone(1): 0 pages.
> zone(2): 0 pages.
> Kernel command line:
> Warning: real time clock seems stuck!
> Calibrating delay loop... 244.12 BogoMIPS
> Memory: 13016k available (724k kernel code, 260k data, 40k init, 0k
> highmem)
> Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
> Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
> Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
> Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
> POSIX conformance testing by UNIFIX
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Starting kswapd v1.8
> CPM UART driver version 0.01
> ttyS0 on SCC1 at 0x8000, BRG1
> ttyS1 on SCC2 at 0x8100, BRG2
> block: queued sectors max/low 8581kB/2860kB, 64 slots per queue
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> RAMDISK: ext2 filesystem found at block 0
> RAMDISK: Loading 2048 blocks [1 disk] into ram disk... done.
> Freeing initrd memory: 0k freed
>  Serial driver version 5.02 (2000-08-09) with no serial options enabled
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP
> IP: routing cache hash table of 512 buckets, 4Kbytes
> TCP: Hash tables configured (established 512 bind 1024)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> setting up filesystem
> VFS: Mounted root (ext2 filesystem).
> Freeing unused kernel memory: 40k init
>
> The  problem is that i m not getting  bash  prompt.
> Then i  added  one application in my ramdisk.image  that  prints  some
> message  on  "/dev/console" .
> But i m not getting any prints .
> Can anybody point out that where could the problem be??
>
> thanx and regards,
>  -rd
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
