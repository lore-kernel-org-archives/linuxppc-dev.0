From: Benjamin Herrenschmidt <bh40@calva.net>
To: Tom Vier <thomassr@erols.com>, <linuxppc-dev@lists.linuxppc.org>,
        <yellowdog-devel@lists.yellowdoglinux.com>
Subject: Re: RFC: Changing default partition type for linux/ppc
Date: Sun, 9 Jul 2000 23:33:09 +0200
Message-Id: <20000709213309.30020@192.168.1.10>
In-Reply-To: <20000709172219.C12414@zero>
References: <20000709172219.C12414@zero>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>i'd vote for "ext2", "hfs", etc. call them what they are, and keep it simple,
>instead of "Linux_Ext2fs" or something similar.

That won't work for 2 reasons:

 - MacOS and MacOS X won't mount HFS partitions if the type is not Apple_HFS
 - If we put the fs type (like Linux_ext2) in the partition type, it's
not updated
   by the various linux mkxxxx tools, and can be confusing. I would
rather keep
   a simple "Linux" type, along with "Linux_swap" to help skipping swap
partition
   in bootloaders (and installers)

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
