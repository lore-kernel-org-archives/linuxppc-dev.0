Message-Id: <v0313030bb405d538a1cb@[17.202.21.235]>
In-Reply-To: <v04210102b405ce2cdefb@[192.168.0.1]>
References: <v04210103b4058cbb5883@[17.203.21.242]>
 <19990915113905.031280@mailhost.mipsys.com>
 <v04210108b4051bfbea54@[192.168.0.1]>
 <v04210103b4058cbb5883@[17.203.21.242]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 15 Sep 1999 16:02:47 -0700
To: Ethan Benson <erbenson@alaska.net>
From: Peter Bierman <bierman@apple.com>
Subject: Re: New booter
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 2:37 PM -0800 9/15/99, Ethan Benson wrote:
>BIOS loads the bootblock from boot disk or if one does not exist it
>looks for a partition marked bootable in the partition table and
>loads the bootblock from that.  the BIOS knows NOTHING about ANY
>filesystem not ext2 not FAT, NTFS, DOSfs, not HFS.  lilo works


You contradict yourself. The bootblock IS PART OF THE DEFINITION OF THE
FILESYSTEM.

The DOS bootblock has been carried along by every x86 operating system
ever, because that's the only thing the BIOS has ever understood.

Even NTFS uses the original fdisk pmap, if only to store a single partition
entry that points to a "modern" pmap.

Everything on x86 is an delicate chain built from how it was done in the
1970's!

-pmb

--
"UNIX shells in Mac OS X should be unneeded but functional...
                        and have the same installed base as MPW."


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
