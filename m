Date: Mon, 31 Jul 2000 13:59:57 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Thomas Graichen <graichen@innominate.de>, thomas.graichen@innominate.de
cc: linuxppc-dev@lists.linuxppc.org, linux-xfs@oss.sgi.com
Subject: Re: SGI XFS on ppc
In-Reply-To: <news2mail-8m2hhl$758$1@mate.bln.innominate.de>
Message-ID: <Pine.LNX.4.10.10007311357070.442-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 31 Jul 2000, Thomas Graichen wrote:
> * how to test the xfs filesystem without the tools? - i just made
>   a small 32mb xfs filesystem on an x86 and dd'ed to a file which
>   you can easily dd onto any partition and mount it as xfs fs there
>   (verified to work on x86)
> * trying to mount the dd'ed filesystem just hangs the machine - no
>   output so far (xfs is compiled with debug and vnode tracing and
>   syslog will give *.* to the console) ...

Is XFS now always big endian (as we discussed about at Linux-Kongreﬂ 1999),
or is it still native endian, so you cannot use an x86 image on big endian
machines?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
