Date: Sun, 9 Jul 2000 20:33:16 -0400
From: Tom Vier <thomassr@erols.com>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: linuxppc-dev@lists.linuxppc.org, yellowdog-devel@lists.yellowdoglinux.com
Subject: Re: RFC: Changing default partition type for linux/ppc
Message-ID: <20000709203316.A12712@zero>
References: <20000709172219.C12414@zero> <20000709213309.30020@192.168.1.10>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20000709213309.30020@192.168.1.10>; from bh40@calva.net on Sun, Jul 09, 2000 at 11:33:09PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jul 09, 2000 at 11:33:09PM +0200, Benjamin Herrenschmidt wrote:
> >i'd vote for "ext2", "hfs", etc. call them what they are, and keep it simple,
> >instead of "Linux_Ext2fs" or something similar.
>
> That won't work for 2 reasons:
>
>  - MacOS and MacOS X won't mount HFS partitions if the type is not Apple_HFS

you're right. i was just giving examples of names and hfs popped into my
head.

>  - If we put the fs type (like Linux_ext2) in the partition type, it's
> not updated
>    by the various linux mkxxxx tools, and can be confusing. I would
> rather keep
>    a simple "Linux" type, along with "Linux_swap" to help skipping swap
> partition
>    in bootloaders (and installers)

i'm not sure what you're saying. mkfs doesn't touch partition tables.

i was thinking of partition types as more of a description of the fs, rather
than naming them after the OS that uses them. on pcs, linux uses the same
partition type for all file systems (except for swap). it wouldn't be a bad
idea to do the same, as you seem to be saying. "Linux_swap" as a type does
seem a little redundant to me, since the partition name can be set to
"swap". on pc/dos style partitions they use a seperate type for for swap,
but they also don't have a seperate name field.

--
Tom Vier <thomassr@erols.com>
DSA Key id 0x27371A2C

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
