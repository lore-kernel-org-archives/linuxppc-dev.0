Date: Thu, 13 Dec 2001 09:06:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Nils Krueger <nilz@hoschi.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PowerStack interrupt?problem
Message-ID: <20011213160658.GE28967@cpe-24-221-152-185.az.sprintbbd.net>
References: <Pine.GSO.4.21.0110011006580.706-100000@mullein.sonytel.be> <000601c14a6d$d9b4a5b0$020aa8c0@dimbar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000601c14a6d$d9b4a5b0$020aa8c0@dimbar>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Oct 01, 2001 at 01:40:19PM +0200, Nils Krueger wrote:
> > > Goody, which? :)  I've got a 604/100 right here.
> >
> > The one that looks like a HiFi, with 133 MHz 604.
>
> It's called PowerStack Series E.

Same thing I've got.

> > > Hmm.  I sort-of wonder if the PS/2 changes a while back goofed something
> up.
> > > My kbd is fine too, and I'll try and throw a mouse on later this week.
> > > Can you grab the bk version and go back to 2.4.8, .7, et al and see if
> > > it works?  I think some PS/2 stuff was done in maybe .5 or .6..
>
> I had the same problem with 2.4.5, .7-pre3 and .8-pre3. I haven't watched
> the interrupts then, but it showed the same symptoms. (keyboard, mouse,
> network, scsi are stalled but graphic card is still working)

Okay, I just tried 2.4.17-pre8 (from _devel) on my PowerStack Series E,
and the ps2 mouse seems to be working with gpm (gpm -m /dev/psaux -t
ps2).

Although it is worth noting that if i did:
while `true`;do cat /proc/interrupts ; sleep 2;done
Interrupts seemed to stop eventually.  It also takes ~100 interrupts for
a tiny mouse movement, which I'm not sure if is right or wrong..

> One keypress or release of a mouse button causes about 20 interrupts and
> sometimes one or two BAD interrupts. (BTW, it's the same on my so far most
> stable 2.2.17) Should be normally 4 interrupts (and of course no BAD one)?

Odd.  It seems to take 3 interrupts/keypress here (6 for up-arrow,
enter).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
