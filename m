Message-Id: <200007071125.MAA02302@hyperion.valhalla.net>
Date: Fri, 07 Jul 2000 12:22:46 +0100
Subject: Re: RFC: Changing default partition type for linux/ppc
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
CC: Benjamin Herrenschmidt <bh40@calva.net>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> Currently, the default partition type used by Linux/PPC on mac partition
> maps is Apple_UNIX_SVR2. This is historically the type used by Apple's A/
> UX for its own partitions. However, I don't like it since it gives no
> indication on the type of filesystem on the partition, and I see no
> reason to keep it.

This is a great idea - the Apple_UNIX_SVR2 bit is confusing at first.

- apart from the desire to have an 'easy to use' partition tool on the MacOS
side - for non-kernel-hackers (see Drive Partition thread).

What chance of getting Apple to support this move?

> So I suggest moving to Linux_ext2, Linux_swap, or maybe simply Linux and
> Linux_swap (since ext2 is not the only filesystem Linux may put on
> these). Using a different type for swap would help avoiding confusion.

What prospect of sharing swap space between MacOS X and linux in dual/multi
boot machines?

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
