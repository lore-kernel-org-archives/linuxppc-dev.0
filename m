Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "Ashwin Bihari" <raz0redge@hotmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Embedded initrd with static programs
Date: Tue, 23 Dec 2003 10:04:57 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY9-F37onNzN9rvBmW0007186b@hotmail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings,

I'm trying to create a initial ramdisk that will get loaded to perform the
following actions.

With a new (empty) hard drive, create the partitions according to the scheme
chosen, format the partitions as EXT3, get a tarball containing the root
file system, uncompress this tarball and then reboot.

Since I need to create the partitions non-interactively, I've found "sfdisk"
from the util-linux package to do this job for me. For the formatting of the
partitions as EXT3, I'm using "mke2fs" from the e2fsprogs package. The
problem is that programs contained with these two packages are all
dynamically linked.

I found the source for e2fsprogs, but I don't see a setting to be able to
compile the programs statically.

I'm using Busybox compiled statically to provide the basic Unix command set.

So basically I need the other two programs also statically compiled, does
anyone of any idea on how I would go about this??

Regards.

~Ashwin

_________________________________________________________________
Enjoy the holiday season with great tips from MSN.
http://special.msn.com/network/happyholidays.armx


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
