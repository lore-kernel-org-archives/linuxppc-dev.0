Date: Sun, 31 Oct 1999 21:31:22 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Martin Costabel <costabel@wanadoo.fr>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: linux-2.2.13pre15 stability w/ head.S patch
In-Reply-To: <381A6CF9.67FE83E2@wanadoo.fr>
Message-ID: <Pine.LNX.4.05.9910312106280.2480-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 30 Oct 1999, Martin Costabel wrote:
> The aty128fb driver exists in the rsync 2.3.22 kernel, but it cannot be
> compiled in, because the config and makefiles don't know about it. In
> the kernel.org sources, the config and makefiles are corrected and allow
> you to choose the aty128fb driver, but it doesn't compile, because
> FB_ACCEL_ATI_RAGE128 has been forgotten in include/linux/fb.h.

#define FB_ACCEL_ATI_RAGE128    32      /* ATI Rage128 family           */

This one indeed got missed. I sent it to Linus myself later, but he hasn't
applied it yet :-( I'll resent it in a few seconds...

> In the good old days (like 2 months ago :-() when the vger cvs tree was
> still actively maintained and was used to collect all the right patches
> for the pmac, life was definitely better.

David Miller promised me he will upgrade vger once he has fixed the Red Hat
problems on SPARC (he's working at Red Hat, you know).

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
