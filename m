Date: Tue, 27 Nov 2001 08:22:44 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.linuxppc.org, Keith Owens <kaos@ocs.com.au>
Subject: Re: include/asm-ppc/platforms/
Message-ID: <20011127082244.I13091@cpe-24-221-152-185.az.sprintbbd.net>
References: <15363.31192.101536.919771@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15363.31192.101536.919771@gargle.gargle.HOWL>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Nov 27, 2001 at 10:32:40PM +1100, Paul Mackerras wrote:

> I want to create a new directory, include/asm-ppc/platforms, for those
> files which mainly contain configuration information for specific
> platforms, such as address and IRQ assignments for on-board devices.
> The files that I want to move into include/asm-ppc/platforms are:
[snip]

What about:
amgia*.h ans-lcd.h backlight.h heathrow.h keylargo.h pmac_feature.h
prep_nvram.h gg2.h uninorth.h and maybe ppc405_dma.h as well.  I think I
might have missed a few pmac-specific platform headers in there...

> This requires corresponding minor changes to 14 files in
> arch/ppc/platforms and 5 files in include/asm-ppc, plus some changes
> in the files that move to include/asm-ppc/platforms.
>
> Does anyone have any comments or objections?

Like I said on IRC, I don't think this really helps much.  I will
conceed that in _devel we have more .h files in include/asm-$(ARCH) than
anyone else, but if we're going to do some organization, lets do more
than throwing lots of files in one directory, which could keep on
growing...

I sort of like the include/asm-ppc/platforms symlink idea, but I forget
if kbuild-2.5 works well with this or if it is/was painful.  Keith?

Barring that, maybe make processor, platform and peripheral dirs?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
