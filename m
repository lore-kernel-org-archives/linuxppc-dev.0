Message-Id: <200007251441.PAA21903@hyperion.valhalla.net>
Date: Tue, 25 Jul 2000 15:42:08 +0100
Subject: sound again [was: Re: xf4 bug report]
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: SteffenH@hyperion-software.de, daenzerm@student.ethz.ch,
        linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jul 25, 2000, Steffen Haeuser wrote:
> Am 25-Jul-00 schrieb Iain Sandoe:
[...]
>>> Don't bother, that's a known problem as well. Blame Apple for not releasing
>>> specs for the latest sound chips...
>
>>which machine, which kernel (and, if possible, which sound chip - can be
>>found from the MacOS side if not the Linux) ?
>
> A "blue/white" G3 Mac first Revision. Kernel is: 2.2.17pre10-ben2 (with the
> older
> kernel Sound worked - at least I cannot remember that an error message during
> OS-booting happened, I never tried out the sound then.
> But the new Kernel is needed for the X Server V4)
>

OK, which was the last working version (prob. easiest is if you mail me
drivers/sound/dmasound.c).  I can diff that to what we have under 17preXX
and see if there are any clues...

I did a back-port of the 2.4.0-test4 dmasound stuff to 2.2.17pre10-ben2
(will check on pre13-ben1 later):
http://www.drfruitcake.com/linux/linuxppc.html

For some people this helps - but it seems that there are problems (some
minor, some major) across the board.   I would much prefer to work on the
2.4.0-testX code (more useful in the grand scheme of things) and so would
encourage you to test the back-port :-)

Having said that, I would expect your machine to work - I think it's an
AWACS sound chip of some variety?  If it has a DACA you'll have to wait..
:-(

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
