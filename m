Date: Sun, 6 Aug 2000 07:34:31 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: "Timothy A. Seufert" <tas@mindspring.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: a GCC question
In-Reply-To: <v04220802b5b2e2274457@[10.0.0.42]>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000806070953.1409A-100000@ofey.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 6 Aug 2000, Timothy A. Seufert wrote:

> At 1:01 AM -0500 8/6/00, Takashi Oe wrote:
>
> >By the way, has anyone noticed compiling arch/ppc/mm/init.c takes very
> >long time?  On my machine, it takes as long as about two minutes to just
> >compile it, while compiling other files are almost instantaneous.  Well,
> >it's one of the biggest C files, but, still, I wonder if we can organize
> >the code a bit to help the compiler somehow.  Perhaps, my machine is too
> >slow?
>
> Something odd is going on.  2 minutes is way too long.  I just did:
>
> rm arch/ppc/mm/init.o
> make
>
> on a 2.2.17pre13 tree which was otherwise fully compiled and watched
> for make to start compiling init.c.  It took less than a second to
> compile.

Hmm, that's true.  I mean, on 2.2.x tree, it takes about five seconds even
with my slow machine, which is comparable to your result.  I've noticed
the long compile time for arch/ppc/mm/init.c on 2.4.x tree.

> My computer is very fast, but it can't be that much faster than
> yours!  Perhaps you are consistently hitting some VM thrashing at
> that point in a full kernel build?

I've just tried vmstat during the compilation, but I didn't see
anything...


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
