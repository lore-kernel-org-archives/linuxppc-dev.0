Date: Sun, 25 Jan 2004 14:55:31 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>,
	Tom Rini <trini@kernel.crashing.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Hydra Mac I/O (was: Re: No Subject)
In-Reply-To: <1075035753.874.14.camel@gaston>
Message-ID: <Pine.GSO.4.58.0401251454230.20527@waterleaf.sonytel.be>
References: <Pine.GSO.4.58.0401251223440.20527@waterleaf.sonytel.be>
 <1075035753.874.14.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 26 Jan 2004, Benjamin Herrenschmidt wrote:
> On Sun, 2004-01-25 at 22:31, Geert Uytterhoeven wrote:
> > This patch converts <asm/hydra.h> to use explicit-sized types.
> > It also applies to 2.4.
>
> Don't you want to port the Hydra code to use the macio infrastructure ?

Perhaps... If I find time to do that...

> It would probably require defining the LongTrail as a _MACH_Pmac or
> hacking enough of pmac_feature to grok it, but that doesn't seem to
> bad actually...

Are there no other machines with the Hydra or another Mac I/O?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
