Date: Wed, 12 Jul 2000 14:37:55 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Iain Sandoe <iain@sandoe.co.uk>
cc: Derek Homeier <supas100@astrophysik.uni-kiel.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [ANN] Dmasound backport to 2.2.17pre7/10 patch
In-Reply-To: <200007121137.MAA18130@hyperion.valhalla.net>
Message-ID: <Pine.LNX.4.10.10007121437080.504-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 12 Jul 2000, Iain Sandoe wrote:
> you have to modprobe:
> soundcore
> dmasound_core <params>
> dmasound_awacs

Or you can use the module dependency system if you don't need <params>:

    modprobe dmasound_awacs

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
