Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Date: Sun, 2 Jun 2002 12:51:51 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Leigh Brown <leigh@solinno.co.uk>
Cc: Paul Mackerras <paulus@samba.org>,
	Peter De Schrijver <p2@mind.be>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: S3 trio config
In-Reply-To: <1023014281.11116.14.camel@kettle.solinno.co.uk>
Message-ID: <Pine.GSO.4.21.0206021250180.13419-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 2 Jun 2002, Leigh Brown wrote:
> On Sat, 2002-06-01 at 09:39, Geert Uytterhoeven wrote:
> > On Sat, 1 Jun 2002, Paul Mackerras wrote:
> > > I wrote:
> > > > Does anyone know why we have this?  Is the S3 Trio display really only
> > > > used on PReP or CHRP machines, not on any PCs?
> > >
> > > I should have said, not on any other PPC systems, of course, since
> > > that code was in a CONFIG_PPC section.
> >
> > S3triofb relies on Open Firmware, so it can work on PowerMac/CHRP only. AFAIK
> > it was used on CHRP only.
>
> Well, S3triofb hasn't even compiled for ages.  I've attached a patch
> that allows it to compile, and removes the dependency on OF.  However,
> it still requires some sort of firmware to initialise the card.  I've
> added a little hack so that it ignores the card if it wasn't initialised
> by the firmware, since the driver doesn't have the code to initialise it
> properly.
>
> It works on the 7043-140 using a PReP kernel, and has been tested by
> quite a few people.  Unfortunately, I no longer have an S3Trio card (and
> to be honest, I know very little about graphics cards).
>
> IMHO it's worth applying the patch as a working (just) driver is a
> better starting point than a non-compiling one.

Yes, that's better. Thanks!

> If there are other PPC systems that bring up the S3Trio in 640x480x8
> mode then I suppose the driver will be applicable to them also....

Peter: does OF initialize your board to 640x480, or is a different resolution
possible as well?

OF on my LongTrail (Peter's is newer) never did anything with a Trio64.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
