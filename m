From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Keith Clayton <clay-ton@pacbell.net>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Fighting with Sonnet g3/l2 upgrade
Date: Sun, 14 Jan 2001 13:21:47 +0100
Message-Id: <19341209055331.21808@smtp.wanadoo.fr>
In-Reply-To: <20010113125616.A478@yoda>
References: <20010113125616.A478@yoda>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Also, while this is probably a BAD idea, is it possible to create a BootX
>build
>where the g_l2cr_available (i think that's right) flag is set to true
from the
>start so that the Set G3 cache option is available for me?  Using the
>powerlogix util I can find the G3 Cache value and I can use resedit to set it
>by hand in the BootX Settings file. Then maybe have a bunch of debugging
>output or something.
>
>I don't expect this to be a magic bullet or anything but I'm hoping to
>understand where things are going wrong and see if it can be worked around.
>
>Sorry to bug you Ben . . if I had CodeWarrior myself, I'd be able to do more
>experimentation myself first.

The hda: lost interrupt problems and the G3/L2 cache issues are 2
different things.

Is your Sonet card also providing an IDE interface ? In this case, it's
possible that the chipset on this card is not supported by 2.2.18 without
the big IDE patch (which need to be fixed for powerpc).

For the G3, I'd rather figure out the correct L2CR value and "fix" it
from userland (via /proc)

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
