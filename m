Date: Tue, 25 Apr 2000 11:52:19 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michel Lanners <mlan@cpu.lu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: aty128 and offb and linux-2.3.99pre6 
In-Reply-To: <200004242105.XAA00390@piglet.grunz.lu>
Message-ID: <Pine.LNX.4.10.10004251147050.337-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 24 Apr 2000, Michel Lanners wrote:
> On  24 Apr, this message from Geert Uytterhoeven echoed through cyberspace:
> > On Mon, 24 Apr 2000, Chas Williams wrote:
> >> In message <200004240651.IAA00313@piglet.grunz.lu>,Michel Lanners writes:
> >> >It does work... but it changes the order my fbs are detected. Grrr....
> >>
> >> i have to agree.  this is fairly annoying since i have 2 rage pro's
> >> (one on the agp and one on the pci bus) and the console should be on
> >> the agp!
> >
> > Huh? This has nothing to do with the order of 2 RAGE PROs. Atyfb is probed for
> > before offb (like it should be) since a long time, and the order is always the
> > same.
> >
> > Try `video=map:1' to map all your virtual consoles to the second card.
>
> Geert, is there any documentation available about these things? Like
> how you go about 'advanced' framebuffer use (multiple fb's, switching
> consoles between fb's, ...)? Where are the userland tools, and what do
> they do (fbset and others)?
>
> I do have some things figured out, but am still not really comfortable
> with framebuffers...

Unfortunately there's still no real documentation, besides the few things in
linux/Documentation/fb/.

Kernel options: read drivers/video/fbmem.c

Tools: fbset, con2fbmap.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
