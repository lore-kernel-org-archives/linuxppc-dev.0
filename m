Content-Type: text/plain;
  charset="iso-8859-1"
From: Brian Waite <waite@skycomputers.com>
To: Roland Dreier <roland@topspin.com>
Subject: Re: NFS root woes: No init found
Date: Wed, 4 Dec 2002 17:52:24 -0500
Cc: linuxppc-embedded@lists.linuxppc.org
References: <200212041635.31861.waite@skycomputers.com> <200212041730.00480.waite@skycomputers.com> <523cpdbds5.fsf@topspin.com>
In-Reply-To: <523cpdbds5.fsf@topspin.com>
MIME-Version: 1.0
Message-Id: <200212041752.24742.waite@skycomputers.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Oh I like the thought! I too have had good luch wit the eval board, but now
our custom is biting me. Lets have a looksie at the data.
Thanks for the idea.
Brian

> This is just a wild guess, but maybe there is a data corruption
> problem somewhere.  (Maybe cache-coherency?  I know the 74xx/gt64260
> is a cache-coherent platform but maybe the snooping isn't wired up or
> set up correctly??)
>
> You could try printing out the data the kernel thinks it read for init
> and compare it with what's actually on the disk.  (It seems likely it
> will be different, since the kernel can't tell that it's an ELF file)
>
> Just as a data point, we have had good success running Linux with NFS
> root on both the Galileo Discovery eval board and our own custom board
> (both used the Galileo internal ethernet).
>
> Best,
>   Roland


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
