Date: Mon, 5 Jun 2000 16:15:44 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michel Lanners <mlan@mcp.cpu.lu>
cc: Tony Mantler <nicoya@apia.dhs.org>, mlan@cpu.lu, drow@false.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [patch] VRAM detection in controlfb
In-Reply-To: <200006051351.PAA19854@mcp.cpu.lu>
Message-ID: <Pine.LNX.4.05.10006051614100.5397-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 5 Jun 2000, Michel Lanners wrote:
> So I guess the optimum would be to mark the VRAM cacheable, but in a way that
> writes don't go into the cache. Would that be write-through?

That's indeed write-through. Note that writes will still be cached in such a
way that a consecutive read from the same location will return the cached
value.  But writes will immediately be sent to the host bridge.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
