From: bob@kunk.jriver.com
Message-ID: <20001107061621.2858.qmail@kunk.jriver.com>
Subject: Re: controlfb and X
To: mlan@cpu.lu
Date: Tue, 7 Nov 2000 00:16:20 -0600 (CST)
Cc: bob@kunk.jriver.com, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200011062245.XAA00760@piglet.grunz.lu> from "Michel Lanners" at Nov 06, 2000 11:44:58 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Michael....

> On   5 Nov, this message from Robert E Brose II echoed through cyberspace:

> > The problem is that the controlfb driver doesn't recognize more than
> > 2 megs of vram. This particular Mac 7500 has 4 megs installed which
> > works perfectly in MacOS.
>
> Strange. It should detect 4 meg in 2.2 kernels; but maybe not 2.4
> kernels.

Is that with a patch that produces a different controlfb.c that the
one on the paulus site?

> > With 2.2.18pre18, 2 megs only is available. Running XFree86-3.3.6-11.2
> > on the Mac 7500 will do 800x600 in 24 bits as expected and 1024x768 in
> > 16 bits but not 1024x768 in 24 bits (not enough ram).
>
> Correct according to what it detects. Wrong detection, however :-(

Yeah, I just wanted to see if it would do 24/32 bit color at all....

> > With 2.4.0-test10 (which includes dma and parameter line changes in
> > controlfb)
>
> Which are those?

Yours I think. I passed through your website looking. I guess I was not
very clear here, sorry. I was looking at the 2.2.18pre18 paulus code.
the controlfb.c did not have the dma routines in it. The 2.4.0-test10
paulus tree did. I diffed the 2 controlfb.c files from these 2 versions.

> > forcing the video ram to 4 megs works fine for console
> > modes (for example vmode 17 32) HOWEVER when the XF86_FBdev server
> > is run it locks up the machine with a black screen of death. (not
> > pingable, keyboard is dead, etc).
> > Also, building my own Xfree 4.01 server results in the same black
> > screen of death.
>
> Strange....
>
> Also, do you se anything in your logs (kernel panic, maybe)? If not, can
> you attach a serial console to one of the serial ports, and add this to
> your kernel command line:
>
> console=ttyS0,19200n8 console=tty0
>
> This would be for a 19200 console, obviously. Try to capture the panic
> message (if there is one) when you start X.

Nothing in the logs. I'll try the console as you suggest and post
the results. I try not to do this too much because it crashes hard
enough that I have to do a manual fsck to get it back up.

--
Bob Brose
bob@kunk.jriver.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
