Message-Id: <m13teUl-001SzWC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Re: mvme2604 - using Gabriel's patches. NFS questions.
To: linuxppc-embedded@lists.linuxppc.org
Date: Wed, 8 Nov 2000 18:19:07 -0500 (EST)
In-Reply-To: <4.3.2.20001108174258.00b96420@falcon.si.com> from "Jerry Van Baren" at Nov 08, 2000 05:48:04 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> The boot messages for the boards always report " VFS: Mounted root
> (NFS filesystem) read-only".  Not knowing NFS that well, is there a
> way I can change it so the boards mount the file system as
> read/write?

You want to add "rw" to the boot arguments to mount the file system
read/write.  Here is an example:

Attached TCP/IP interface to motfcc0.
Attaching network interface lo0... done.
Loading... 45684 + 452802
Starting at 0x400000...

CPU/CPM/BUS: 198/132/33 Mhz

Ethernet (in decimal): 0:160:30:75:228:193

loaded at:     00400000 0040B274
board data at: 00FFFFC0 00FFFFEC
relocated to:  00200100 0020012C
zimage at:     0040B274 00479B36
avail ram:     0047A000 01000000

Linux/PPC load: root=/dev/nfs rw nfsroot=207.75.228.195:/target nfsaddrs=207.75.228.193:207.75.228.195
Uncompressing Linux...done.
Now booting the kernel
Total memory = 16MB; using 0kB for hash table (at 00000000)
Linux version 2.4.0-test10 (diekema@dell) (gcc version 2.95.2 19991030 (2.95.3 prerelease/franzo)) #38 Wed Nov 8 17:05:16 EST 2000
Boot arguments: root=/dev/nfs rw nfsroot=207.75.228.195:/target nfsaddrs=207.75.228.193:207.75.228.195

------------------\\----------------------\\----------------------------
Jon Diekema        |                       | Smiths Industries
(616) 241-8310     |                       | 3290 Patterson Avenue, SE
diekema_jon@si.com \\                      \\  Grand Rapids, MI 49512-1991

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
