Date: Wed, 7 Nov 2001 12:47:33 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: The Plan
In-Reply-To: <15337.7275.266062.777161@cargo.ozlabs.ibm.com>
Message-ID: <Pine.GSO.4.21.0111071246050.11631-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 7 Nov 2001, Paul Mackerras wrote:
> - Files which relate only to one platform, or a small number of
>   platforms, move to arch/ppc/platforms.  (There are some minor
>   exceptions to this rule which we can discuss if people are
>   concerned.)  We end up with:

Why not move platform-specific files to arch/ppc/<platform>/ instead?

Your solution reduces the clutter only by a factor of 2, while creating
platform-specific directories reduces it by a factor of n.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
