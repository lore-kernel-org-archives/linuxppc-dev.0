From: bob@kunk.jriver.com
Message-ID: <20000628021526.17464.qmail@kunk.jriver.com>
Subject: Re: 2.2.17pre7 Ramdisk compile failure
To: pogtal@erols.com (Nelson Abramson)
Date: Tue, 27 Jun 2000 21:15:26 -0500 (CDT)
Cc: bob@kunk.jriver.com, linuxppc-dev@lists.linuxppc.com
In-Reply-To: <395925FD.97C131C5@erols.com> from "Nelson Abramson" at Jun 27, 2000 06:09:01 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


User Nelson Abramson says:
>
> Are you sure you have all of the correct settings under Block Devices->RAM disc
> support.

Yup, I compile that in all the time.

> > BTW, I got this from a fresh rsync from Pauls stable tree. I've been noticing
> > odd behavior with these rsync images ocassionally. It seems like
> > older files are not always replaced and I ran into a missing autoconf.h this
> > afternoon.
>
> Every problem I've ever had with an rsync image from Paulus' tree has been a
> configuration error on my part.  An easy way to check: do a "make vmlinux"
> without messing with the .config....

I always blame myself first, that is why I wiped it and started over. The
missing autoconf.h came on a fresh rsync.

> Just for the record, I just (five seconds ago) finished compiling a fresh rsync
> from a few minutes before hand.

And I did another rsync afterwards and now it works for me also....

Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
