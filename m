Date: Sat, 25 Mar 2000 15:36:24 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Gabriel Paubert <paubert@iram.es>, Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <Pine.LNX.4.05.10003251427290.11322-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.10.10003251533080.26717-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > They are prioritized the right way: if you memset the whole aperture to 0
> > the chip freaks out instead of just painting the whole screen black. Been
> > there, done that.
>
> Aha, now I know why I had to remove the last 4K. You had overlapping regions!
> Which means my patch was not really necessary, since it worked around the real
> problem instead of fixing it.

Indeed :-) At least that's how I see it. At that time I had no idea that
the overlap would get to be a real problem ...

	Michael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
