Date: Thu, 28 Mar 2002 10:19:27 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Dan Bethe <dan_bethe@yahoo.com>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: slim kernel source
In-Reply-To: <20020327183028.71552.qmail@web11002.mail.yahoo.com>
Message-ID: <Pine.GSO.4.21.0203281018110.4979-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 27 Mar 2002, Dan Bethe wrote:
> Hi all.  Is there a utility or procedure which can remove a bunch of the code
> from extraneous architectures from my kernel source tree?  I only want to build
> kernels for my beloved Powermac 8500 and so I can do without code specific to
> ia32, S390, Alpha, MIPS, and friends.
>
> Even if you just know of a few directories I can remove and save a couple dozen
> megs of space, that'd be good.

You can remove everything under arch/ and include/ you don't need. But you'll
be very disappointed when you notice that you haven't saved a couple dozen megs
of space by doing that. The arch-specific code is _very_ small compared to all
the driver code, which is valid for most architectures.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
