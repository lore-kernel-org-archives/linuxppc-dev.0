Date: Mon, 23 Oct 2000 20:03:28 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Josh Huber <huber@mclx.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: gpm and XF401 (Re: ADB-Mouse)
In-Reply-To: <20001023122716.D426@missioncriticallinux.com>
Message-ID: <Pine.LNX.4.10.10010232002440.390-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 23 Oct 2000, Josh Huber wrote:
> On Mon, Oct 23, 2000 at 03:00:02PM +0200, Olaf Hering wrote:
> > You mean you mark some text at console with gpm and all you get in the
> > selected area is garbage, even with a non psaux device?
> > I tried it here on a chrp machine and got the same effect, could be a
> > framebuffer bug. Anyone else with that problem?
> >
> > I have XF4 here with kernel 2.4 and no problems at all (fbdev driver).
>
> I have the same problem on a g4 (r128 fb driver) when using 2.4.
>
> I haven't had the time to look into it, but selecting text in console
> mode is definately broken.  It looks like it's somehow using the wrong
> characters for the highlighted versions of the text.
>
> Anyone have any ideas,

Perhaps it's exchanging the attribute byte with the character byte? Check out
the scr_*() macros/functions.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
