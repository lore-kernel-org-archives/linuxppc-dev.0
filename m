Date: Mon, 11 Sep 2000 23:00:57 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Todd Lipcon <tlipcon@mercea.net>
cc: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Roles for distributions
In-Reply-To: <Pine.LNX.4.10.10009111558170.25787-100000@mercea.net>
Message-ID: <Pine.LNX.4.10.10009112249360.380-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 11 Sep 2000, Todd Lipcon wrote:
> Anyway- I am a fairly decent C, C++, and Java programmer. I'd love to be
> able to contribute to the Linux/PPC effort, however I don't even know
> where to start. Most of the projects that are large enough to actually
> need patches to run correctly on PPC are so large that they are inherently
> intimidating to one not familiar with the source. Do any of you veteran
> hackers have suggestions for the contribution-newbie? What projects are in
> the largest need of help, and how can someone who has never seen their
> source get into the flow of helping out?

Actually it's quite simple :-)

When you find out something doesn't work, you start brainwashing yourself that
you _will_ fix the problem. To obtain this goal, all possible tools and
methods you can imagine[*] are allowed and even strongly encouraged (using a
debugger, adding debug code, using a serial terminal, disassembling, ...).

I can guarantee you that it will feel _very_ good when you finally nail the
bug (the longer it takes and the harder it was, the better it feels :-). And
you'll learn a lot while investigating the problem and studying the system
you're fixing. But still, the more you learn, the more you'll realize that
there's lots of stuff left that you don't understand :-)

I wish you good luck!! And don't forget we all started as innocent babies not
knowing anything about e.g. Linux internals...

Gr{oetje,eeting}s,

						Geert

[*] Ever dumped stack frames by flashing the screen in 8 colors (each color
    contains 8 bit of information)? I did last week :-)
--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
