Subject: Re: ext2fs or ramdisk problems......
To: johnw@aiinet.com (Whitney, John)
Date: Tue, 29 Aug 2000 15:14:35 +1100 (EST)
Cc: sanders@mvista.com ('Scott Anderson'),
        linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <7283DE19D141D111AD0E00A0C95B195502C5F607@mail2.aiinet.com> from "Whitney, John" at Aug 28, 2000 10:27:26 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000829041435.C409FB5@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Whitney, John writes:
> If I copy a file, such as /bin/vim, into new files until they fill up
> the unused ramdisk space, delete the copies, and start copying them
> again, I get the "out of space" error (actually, I don't think I even
> have to fill up the space before I can get this to happen).  If it were
> inode related, I'd think that it was the *number* of files and that for
> each file I deleted, I could create a new one (which isn't the case).

True.  I just tried both these cases, and I get the results you expect.
Are you sure your memory subsystem is working properly?
Did you pass an explicit size to mke2fs, and if so, does it match the size of
your ramdisk?

Regards,
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
