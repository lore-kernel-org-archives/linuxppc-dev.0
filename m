Message-ID: <3922AD7F.7618E190@snmc.com>
Date: Wed, 17 May 2000 09:32:31 -0500
From: Daris Nevil <Daris.Nevil@snmc.com>
MIME-Version: 1.0
To: Steve Rossi <srossi@ccrl.mot.com>
CC: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: e2fsck?
References: <3922A729.F5A922FE@ccrl.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steve,

I may be getting mixed up with another utility, but I think that e2fsck
requires the /proc filesystem to be mounted.  You can do this by:

    mount -p proc /proc /proc

Give that a try and let us know if that solves the problem.

Daris Nevil
SiSIC Inc/Simple Network Magic Corporation
www.snmc.com

Steve Rossi wrote:

> Has anyone successfully compiled e2fsck for 8xx? I was able to compile
> it and run it, but it seg faults with the following output:
>
> sh-2.03# e2fsck /dev/sda2
> e2fsck 1.18, 11-Nov-1999 for EXT2 FS 0.5b, 95/08/09
> /dev/sda2 contains a file system with errors, check forced.
> Pass 1: Checking inodes, blocks, and sizes
> Segmentation fault
>
> TIA,
> Steve
>
> --
> -------------------------------------------------------
> Steven K. Rossi                     srossi@ccrl.mot.com
> Staff Engineer
> Multimedia Communications Research Laboratory
> Motorola Labs
> -------------------------------------------------------
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
