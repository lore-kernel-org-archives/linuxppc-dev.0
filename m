Date: Wed, 5 Jun 2002 09:50:11 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Leigh Brown <leigh@solinno.co.uk>,
	Paul Mackerras <paulus@samba.org>, Peter De Schrijver <p2@mind.be>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: S3 trio config
In-Reply-To: <20020604201607.GA1335@opus.bloom.county>
Message-ID: <Pine.GSO.4.21.0206050948450.27487-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 4 Jun 2002, Tom Rini wrote:
> On Sun, Jun 02, 2002 at 11:38:01AM +0100, Leigh Brown wrote:
> > On Sat, 2002-06-01 at 09:39, Geert Uytterhoeven wrote:
> > > On Sat, 1 Jun 2002, Paul Mackerras wrote:
> > > > I wrote:
> > > > > Does anyone know why we have this?  Is the S3 Trio display really only
> > > > > used on PReP or CHRP machines, not on any PCs?
> > > >
> > > > I should have said, not on any other PPC systems, of course, since
> > > > that code was in a CONFIG_PPC section.
> > >
> > > S3triofb relies on Open Firmware, so it can work on PowerMac/CHRP only. AFAIK
> > > it was used on CHRP only.
> >
> > Well, S3triofb hasn't even compiled for ages.  I've attached a patch
> > that allows it to compile, and removes the dependency on OF.  However,
> > it still requires some sort of firmware to initialise the card.  I've
> > added a little hack so that it ignores the card if it wasn't initialised
> > by the firmware, since the driver doesn't have the code to initialise it
> > properly.
>
> Okay, I've applied this patch and done a bit more work so that it
> _might_ work as a module.  Geert, who should all of this goto in the end
> since it doesn't seem like this driver has had an active maintainer for
> a while..

Originally the driver was written by Peter De Schrijver, but he seems to have
been very silent last week.
Since it's PPC related, I think the `generic PPC pusher' can take care of it.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
