Message-ID: <3C03F253.3021F707@linux-m68k.org>
Date: Tue, 27 Nov 2001 21:06:43 +0100
From: Roman Zippel <zippel@linux-m68k.org>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org, Keith Owens <kaos@ocs.com.au>
Subject: Re: include/asm-ppc/platforms/
References: <15363.31192.101536.919771@gargle.gargle.HOWL> <20011127082244.I13091@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Tom Rini wrote:

> What about:
> amgia*.h ans-lcd.h backlight.h heathrow.h keylargo.h pmac_feature.h
> prep_nvram.h gg2.h uninorth.h and maybe ppc405_dma.h as well.  I think I
> might have missed a few pmac-specific platform headers in there...

Be careful with amiga*.h, there are included by several drivers, which
also have to continue to work under m68k.

bye, Roman

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
