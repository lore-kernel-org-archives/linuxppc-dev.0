Date: Fri, 25 Jan 2002 10:22:08 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: hollis@austin.ibm.com,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	sdi@remote.org
Subject: Re: RFC: vesafb
In-Reply-To: <20020124180313.GB1839@cpe-24-221-152-185.az.sprintbbd.net>
Message-ID: <Pine.GSO.4.21.0201251020020.15996-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 24 Jan 2002, Tom Rini wrote:
> On Wed, Jan 23, 2002 at 01:20:10PM -0600, hollis@austin.ibm.com wrote:
> > The attached patch allows vesafb to work on PPC. vesafb does surprisingly
> > little with the BIOS (which I thought was the whole point of VESA). With some
> > ifdef's I'm able to use it as sort of a VGA offb -- the firmware initializes
> > the card, and the driver just uses it and never mucks with it.
>
> This looks good to me.  My only comment is you should probably use
> CONFIG_MTRR around the mtrr bits instead of __i386__ (which is what

Indeed.

> other drivers do).  Geert, since you're still overall fb maintainer

What's in a name...

> (yes?) would you be willing to sign off on these changes to be sent to
> Marcelo for 2.4.19-pre1?

Just send them to Marcelo, CC me, and say it's OK for me to include them.
Or better, ask Gerd Knorr to send them in (please CC me)?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
