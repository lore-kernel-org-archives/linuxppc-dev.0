Message-Id: <200011062245.XAA00760@piglet.grunz.lu>
Date: Mon, 6 Nov 2000 23:44:58 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: controlfb and X
To: bob@kunk.jriver.com
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20001106032750.5523.qmail@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   5 Nov, this message from Robert E Brose II echoed through cyberspace:
> The problem is that the controlfb driver doesn't recognize more than
> 2 megs of vram. This particular Mac 7500 has 4 megs installed which
> works perfectly in MacOS.

Strange. It should detect 4 meg in 2.2 kernels; but maybe not 2.4
kernels.

> With 2.2.18pre18, 2 megs only is available. Running XFree86-3.3.6-11.2
> on the Mac 7500 will do 800x600 in 24 bits as expected and 1024x768 in
> 16 bits but not 1024x768 in 24 bits (not enough ram).

Correct according to what it detects. Wrong detection, however :-(

> With 2.4.0-test10 (which includes dma and parameter line changes in
> controlfb)

Which are those?

> forcing the video ram to 4 megs works fine for console
> modes (for example vmode 17 32) HOWEVER when the XF86_FBdev server
> is run it locks up the machine with a black screen of death. (not
> pingable, keyboard is dead, etc).
> Also, building my own Xfree 4.01 server results in the same black
> screen of death.

Strange....

> I'm assuming the problem is in the dma code added to controlfb.c in the
> 2.4.x version. Has anyone run into this or had different results?

I have only problems with 2.4, but not with controlfb ;-)

Can you be more specific as to hwta version of 2.4 you're running? Where
did you get it from?

Also, do you se anything in your logs (kernel panic, maybe)? If not, can
you attach a serial console to one of the serial ports, and add this to
your kernel command line:

console=ttyS0,19200n8 console=tty0

This would be for a 19200 console, obviously. Try to capture the panic
message (if there is one) when you start X.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
