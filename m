Mime-Version: 1.0
Message-Id: <v04210103b4060fde4e1e@[192.168.0.1]>
In-Reply-To: <v0313030bb405d538a1cb@[17.202.21.235]>
References: <v04210103b4058cbb5883@[17.203.21.242]>
 <19990915113905.031280@mailhost.mipsys.com>
 <v04210108b4051bfbea54@[192.168.0.1]>
 <v04210103b4058cbb5883@[17.203.21.242]>
 <v0313030bb405d538a1cb@[17.202.21.235]>
Date: Wed, 15 Sep 1999 19:18:45 -0800
To: Peter Bierman <bierman@apple.com>
From: Ethan Benson <erbenson@alaska.net>
Subject: Re: New booter
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 15/9/99 Peter Bierman wrote:

>
>You contradict yourself. The bootblock IS PART OF THE DEFINITION OF THE
>FILESYSTEM.

No i don't, there are TWO bootblocks that may be used: one is the MBR 
the Master Boot Record it it at the very start of the disk, then you 
may have a bootblock at the start of each partition if the filesystem 
allows it, the only thing the filesystem needs to do is leave 512 or 
1024 bytes free at the start of the partition, then ANYTHING can be 
put there for the firmware to load.

you ever look at the first 1024 bytes of an HFS partition ? its all 
zeros, same with ext2, until you add a bootblock, macos has one for 
oldworld machines linux has lilo on x86, and on PPC we have quik that 
is broken.

>The DOS bootblock has been carried along by every x86 operating system
>ever, because that's the only thing the BIOS has ever understood.

there is nothing more to the DOS bootblock then free space at the 
beginning of the partition, you can put any code you like there.  the 
only condition is it must be in a language used by the BIOS, just 
like on OpenFirmware machines you can put any code in the bootblock 
so long as its written in Forth.

>Even NTFS uses the original fdisk pmap, if only to store a single partition
>entry that points to a "modern" pmap.

I have not looked at NT enough to know what its filesystems do, but 
as far as bootblocks go it places its NT first stage booter on the 
MBR just like LILO does.

>Everything on x86 is an delicate chain built from how it was done in the
>1970's!

at least you can take a machine from the 1970s and install and boot 
linux and LILO on it without using MS booters or OSes, and without 
creating partitions with fake versions of DOS or windows to boot 
linux.

I call that a working and longterm solution.



Best Regards,
Ethan Benson
To obtain my PGP key: http://www.alaska.net/~erbenson/pgp/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
