Date: Thu, 29 Nov 2001 17:11:11 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 'make rpm' Failing due to i386 bug
In-Reply-To: <20011129082734.S29541@cpe-24-221-152-185.az.sprintbbd.net>
Message-ID: <Pine.GSO.4.21.0111291710090.6747-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 29 Nov 2001, Tom Rini wrote:
> On Wed, Nov 28, 2001 at 10:10:45PM -0900, Ethan Benson wrote:
> > On Wed, Nov 28, 2001 at 08:19:49PM -0700, Tom Rini wrote:
> > > > no we have a zImage target, not bzImage which is a i386 specific hack
> > > > to work around that braindamaged architecture.
> > >
> > > No, we as of 2.4.10ish have a 'bzImage' target which calls 'zImage'
> > > since most of the docs are braindead and say "Now type 'bzImage' or
> > > 'bzdisk'".
> >
> > hrm, i would have made it echo something like:
> >
> > 	bzImage is a i386 specific hack, it is not supported by any other
> > 	architecure.  Use make zImage instead.
> >
> > rather then just silently perpetuate further ignorance.
>
> Well, there's precidence since arm I think does the same thing.  And on
> m68k 'bzImage' creates a bzip2'ed vmlinux. :)

Which has a very questionable purpose, since AFAIK no m68k booter knows how to
decompress bzip2ed kernel images. All they support are plain and gzipped
kernel images.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
