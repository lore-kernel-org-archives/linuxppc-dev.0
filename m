Mime-Version: 1.0
Message-Id: <v04210106b4074cf7d0b7@[192.168.0.1]>
In-Reply-To: <199909170032.KAA13065@tango.anu.edu.au>
References: <199909160742.JAA00362@piglet.cpu.lu>
 <199909170032.KAA13065@tango.anu.edu.au>
Date: Thu, 16 Sep 1999 17:46:32 -0800
To: Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org
From: Ethan Benson <erbenson@alaska.net>
Subject: Re: New booter (about quik)
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 17/9/99 Paul Mackerras wrote:

>
>
>No, it needs to be an ext2 partition.  AFAIK the first 1k of an HFS
>partition isn't free.

yes it is free, unless you have macos on that same partition then 
there are macos bootblocks there.

dd if=/dev/hda4 of=/tmp/hfsblock bs=1024 count=1
dd if=/dev/hda8 of=/tmp/ext2block bs=1024 count=1

$ cmp /tmp/hfsblock /tmp/ext2block
$

no difference at all.

hda4 is a empty hfs partition with no macos
hda8 is a ext2fs not the root partition and such no boot blocks 
installed (quik or otherwise)



Best Regards,
Ethan Benson
To obtain my PGP key: http://www.alaska.net/~erbenson/pgp/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
