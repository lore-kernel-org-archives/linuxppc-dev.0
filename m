Message-ID: <39123B16.945B1E6E@embeddededge.com>
Date: Thu, 04 May 2000 23:08:06 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: LinuxPPC Embedded Mailing List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: [PATCH] Adding support for LXT971/2 PHYs
References: <20000505011037.B41DA3C97D@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:

> Hmmm. Ours is the first patch for this I've seen posted to the mailing list,

There is lots of stuff that comes straight to me for merging into
sources.......


> OK. How do those of us without BitKeeper access grab your 2.3.99 tree?

If you want to do this kind of stuff, I would suggest anonymous
BitKeeper pulls to keep you up to date.  It shows up in kernel.org
rather quickly......

In this specific case, it wouldn't matter.  For some reason, this
must have been Fast Ethernet week, as I received several patches
over the last few days :-).


> Are you sure we want to do that?

I don't have a solution yet, just several completely different approaches
from people.  Something has to give, because I agree it is getting too
complicated.  It's OK for me, because I have been living it for years
and know what it all means, but it doesn't help someone looking at it
for the first time.


> .......... My ideal
> solution to the problem of supporting multiple board types is to move the
> magic numbers like the PHY interrupt pin and the PxPAR/PxDIR/etc values into
> each board-specific header file,


I understand your point, but the other side of the argument is when you
don't keep things like this together, people don't realize how many
examples of how to do it exist.  They also don't realize how their
change may affect someone else.


> complicating the board info structure is that there's no runtime code size
> overhead this way.

Yes, but this is only initialization, not run time overhead.

> We took this approach with our new custom board, and haven't had to add a
> single #ifdef CONFIG_ourboardname outside the one which chooses our
> board-specific header in mpc8xx.h.

I do that with lots of custom boards.  Most are simple derivative of
what is already there.  In fact, some have even choose the same I/O
pins for Ethernet (there aren't many options, and most have been used :-),
so we don't even need to add anything but another conditional on an
#ifdef.

Anyway, this has kind of gone down a rat hole...I have a bunch of
code from several people I am trying to sort out right now.  I want
to use it all, and I am choosing the best from all of it.  Don't
worry, I'll use some of yours too :-).  It's just not as easy as
getting a patch and checking it in.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
