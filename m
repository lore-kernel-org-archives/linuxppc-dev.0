Date: Mon, 24 Apr 2000 15:31:29 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michel Lanners <mlan@cpu.lu>
cc: linuxppc-dev@lists.linuxppc.org, drow@false.org
Subject: Re: aty128 and offb and linux-2.3.99pre6
In-Reply-To: <200004240651.IAA00313@piglet.grunz.lu>
Message-ID: <Pine.LNX.4.10.10004241530520.316-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 24 Apr 2000, Michel Lanners wrote:
> On  19 Apr, this message from Geert Uytterhoeven echoed through cyberspace:
> > What about other frame buffer devices, like e.g. matroxfb? Does it still work
> > after this patch? If yes, we can get rid of matrox_of_init() as well.
>
> It does work... but it changes the order my fbs are detected. Grrr....
> ;-)

But now you can throw out offb, right? :-) (unless you have controlfb, ...)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
