Subject: Re: ext2fs or ramdisk problems......
To: johnw@aiinet.com (Whitney, John)
Date: Mon, 28 Aug 2000 12:26:49 +1100 (EST)
Cc: greyham@research.canon.com.au ('greyham@research.canon.com.au'),
        kd@flaga.is, linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <7283DE19D141D111AD0E00A0C95B195502C5F605@mail2.aiinet.com> from "Whitney, John" at Aug 25, 2000 09:30:23 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000828012649.CD93CB5@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Whitney, John writes:
> I have had odd results using ext2 on the ramdisk (in my case, a 16MB
> ramdisk).  Using the 2.2.13, ramdisks I created using ext2 would boot
> up just fine on the system, but after use the filesystem would declare
> that it was out of space, even though "df" showed several megabytes
> free on that filesystem.

Scott's suggestion re: inodes sounds like the explanation here.
Unfortunately the error message you get for being out of inodes is the same
as what you get for running out of available blocks.

> Someday I'll go into the Minix source code on my PC and modify it to be
> big-endian, so I don't have to worry about it anymore.

This would be a really worthwhile enhancement.  I'm a little suprised noone's
bothered to fix this, given that ext2 gets it right.  It should be possible
to auto-detect the byte order it was constructed with and have it "just work"
on either architecture, even if mkfs.minix continues to write the fields in
the native byte order.

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
