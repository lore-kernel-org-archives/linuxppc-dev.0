Date: Thu, 5 Apr 2001 08:39:33 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: puppet <puppetlee@hanmail.net>
Cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: unresovled symbol atomic_...
In-Reply-To: <20010405152250.HM.E0000000001QtCy@www15.hanmail.net>
Message-ID: <Pine.LNX.4.05.10104050839140.25540-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 5 Apr 2001, puppet wrote:
> when I inserted module, following errors ocurred.
>
> unresloved symbol atomic_dec
> unresloved symbol atomic_inc
>
> atomic_dec and atomic_inc are declared as inline function in "asm/atomic.h". As far as I know, inline function can be used in module without a problem like unresloved symbol.
>
> Anybody help me to resolve this ?

Which module? Any chance you compiled it without optimization?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
