Message-Id: <4.2.2.20040519131218.05091660@bhawley.mailhost.luminex.com>
Date: Wed, 19 May 2004 13:14:10 -0700
To: Wolfgang Denk <wd@denx.de>
From: Brian Hawley <bhawley@luminex.com>
Subject: Re: Ebony Board, PPC440GP and Ramdisk
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <4.2.2.20040519123513.05074da0@bhawley.mailhost.luminex.com
 >
References: <20040519195405.98971C109F@atlas.denx.de>
 <Your message of "Wed, 19 May 2004 10:16:29 PDT." <4.2.2.20040519101456.0509d340@bhawley.mailhost.luminex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We aren't too successful at getting a ramdisk up either.


## Checking Image at 00100000 ...
Image Name: Linux-2.6.5
Created: 2004-05-19 19:39:09 UTC
Image Type: PowerPC Linux Kernel Image (gzip compressed)
Data Size: 787934 Bytes = 769.5 kB
Load Address: 00000000
Entry Point: 00000000
Verifying Checksum ... OK
## Checking Image at 00200000 ...
Image Name: ramdisk image
Created: 2004-05-19 20:40:12 UTC
Image Type: PowerPC Linux RAMDisk Image (gzip compressed)
Data Size: 1476478 Bytes = 1.4 MB
Load Address: 00000000
Entry Point: 00000000
Verifying Checksum ... OK

IBM Ebony port (MontaVista Software, Inc. (source@mvista.com))
On node 0 totalpages: 32768
DMA zone: 32768 pages, LIFO batch:8
Normal zone: 0 pages, LIFO batch:1
HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line: root=/dev/ram rw
PID hash table entries: 1024 (order 10: 8192 bytes)
Memory: 127552k available (1220k kernel code, 436k data, 92k init, 0k highmem)
[ *chopped extraneous msgs * ]
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17
Kernel panic: VFS: Unable to mount root fs on ram0
<0>Rebooting in 180 seconds..<6>eth0: Link is Up


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
