Message-ID: <3965D1D8.C7B9F28E@amulet.co.jp>
Date: Fri, 07 Jul 2000 21:49:28 +0900
From: Hollis Blanchard <hollis@amulet.co.jp>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
CC: linuxppc-dev@lists.linuxppc.org, Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: RFC: Changing default partition type for linux/ppc
References: <200007071125.MAA02302@hyperion.valhalla.net>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe wrote:
>
> > Currently, the default partition type used by Linux/PPC on mac partition
> > maps is Apple_UNIX_SVR2. This is historically the type used by Apple's A/
> > UX for its own partitions. However, I don't like it since it gives no
> > indication on the type of filesystem on the partition, and I see no
> > reason to keep it.

[snip]

> What chance of getting Apple to support this move?

I would estimate the odds are somewhere between slim and none. Feel free
to email leadership@apple.com.

Of course I think we all know it's not that important either. Drive
Setup's Linux support came a few years late, and still is lacking a bit.
With Apple's new interest in Unix it's possible they might care (but
also possible that they'd have no interest in interoperating with
inferior Unices ;). Of course, I imagine they're pretty busy with their
own Unix - not much time to worry about working with other people's.

> > So I suggest moving to Linux_ext2, Linux_swap, or maybe simply Linux and
> > Linux_swap (since ext2 is not the only filesystem Linux may put on
> > these). Using a different type for swap would help avoiding confusion.

I think "Linux" and "Linux_swap" would be a good idea, especially since
some ext2 alternatives seem to be getting closer.

> What prospect of sharing swap space between MacOS X and linux in dual/multi
> boot machines?

I don't know the details, but I know that you must run mkswap on a new
swap partition. Since I don't imagine any particular effort has been put
in to keeping Linux and BSD mkswap's compatible, I doubt it would be
possible.

-Hollis

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
