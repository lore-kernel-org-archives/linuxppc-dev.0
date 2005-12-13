Return-Path: <geert@linux-m68k.org>
Received: from witte.sonytel.be (witte.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id C8447688C3
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Dec 2005 05:29:54 +1100 (EST)
Date: Tue, 13 Dec 2005 19:28:41 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonycom.com
To: Adrian Bunk <bunk@stusta.de>
In-Reply-To: <20051213180551.GN23349@stusta.de>
Message-ID: <Pine.LNX.4.62.0512131926530.17990@pademelon.sonytel.be>
References: <20051211185212.GQ23349@stusta.de>
	<20051211192109.GA22537@flint.arm.linux.org.uk>
	<20051211193118.GR23349@stusta.de>
	<20051211194437.GB22537@flint.arm.linux.org.uk>
	<20051213001028.GS23349@stusta.de> <439ECDCC.80707@hogyros.de>
	<20051213140001.GG23349@stusta.de>
	<20051213173112.GA24094@flint.arm.linux.org.uk>
	<20051213180551.GN23349@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: tony.luck@intel.com, linux-ia64@vger.kernel.org, grundler@parisc-linux.org,
	matthew@wil.cx, Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	lethal@linux-sh.org, linux-mtd@lists.infradead.org,
	dwmw2@infradead.org, kkojima@rr.iij4u.or.jp, parisc-linux@parisc-linux.org
Subject: Re: [2.6 patch] don't allow users to set CONFIG_BROKEN=y
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 13 Dec 2005, Adrian Bunk wrote:
> Do not allow people to create configurations with CONFIG_BROKEN=y.
> 
> The sole reason for CONFIG_BROKEN=y would be if you are working on 
> fixing a broken driver, but in this case editing the Kconfig file is 
> trivial.
> 
> Never ever should a user enable CONFIG_BROKEN.
                      ^^^^
OK, a user, not an expert. Let's assume users don't enable EXPERIMENTAL.

But I'd like to at least have the possibility to enable broken drivers, even if
it's just for compile regression tests.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
