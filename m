Date: Mon, 24 Apr 2000 20:10:03 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Chas Williams <chas@cmf.nrl.navy.mil>
cc: mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org, drow@false.org
Subject: Re: aty128 and offb and linux-2.3.99pre6 
In-Reply-To: <200004241516.LAA20279@ginger.cmf.nrl.navy.mil>
Message-ID: <Pine.LNX.4.10.10004242008100.316-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 24 Apr 2000, Chas Williams wrote:
> In message <200004240651.IAA00313@piglet.grunz.lu>,Michel Lanners writes:
> >It does work... but it changes the order my fbs are detected. Grrr....
>
> i have to agree.  this is fairly annoying since i have 2 rage pro's
> (one on the agp and one on the pci bus) and the console should be on
> the agp!

Huh? This has nothing to do with the order of 2 RAGE PROs. Atyfb is probed for
before offb (like it should be) since a long time, and the order is always the
same.

Try `video=map:1' to map all your virtual consoles to the second card.


Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
