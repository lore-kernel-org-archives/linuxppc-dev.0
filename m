Message-ID: <000601c14a6d$d9b4a5b0$020aa8c0@dimbar>
From: "Nils Krueger" <nilz@hoschi.de>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>,
	"Tom Rini" <trini@kernel.crashing.org>
Cc: "Linux/PPC Development" <linuxppc-dev@lists.linuxppc.org>
References: <Pine.GSO.4.21.0110011006580.706-100000@mullein.sonytel.be>
Subject: Re: PowerStack interrupt?problem
Date: Mon, 1 Oct 2001 13:40:19 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Goody, which? :)  I've got a 604/100 right here.
>
> The one that looks like a HiFi, with 133 MHz 604.

It's called PowerStack Series E.

> > Hmm.  I sort-of wonder if the PS/2 changes a while back goofed something
up.
> > My kbd is fine too, and I'll try and throw a mouse on later this week.
> > Can you grab the bk version and go back to 2.4.8, .7, et al and see if
> > it works?  I think some PS/2 stuff was done in maybe .5 or .6..

I had the same problem with 2.4.5, .7-pre3 and .8-pre3. I haven't watched
the interrupts then, but it showed the same symptoms. (keyboard, mouse,
network, scsi are stalled but graphic card is still working)

This night I compiled 2.4.10-pre12 (from MontaVista rsync) and still the
same. (Thank you, Geert, the video-mode kernel parameter works fine; fbcon
gives me 1024x768 directly after bootup now)

One keypress or release of a mouse button causes about 20 interrupts and
sometimes one or two BAD interrupts. (BTW, it's the same on my so far most
stable 2.2.17) Should be normally 4 interrupts (and of course no BAD one)?

> but the owner promised to join
> the mailing list, so I hope he'll do.

ACK

Nilz.

--
http://www.hoschi.de/nilz   (Nilz' Homepage)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
