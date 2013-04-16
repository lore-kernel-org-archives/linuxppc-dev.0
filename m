Return-Path: <geert@linux-m68k.org>
Received: from winston.telenet-ops.be (winston.telenet-ops.be [195.130.137.75])
 by ozlabs.org (Postfix) with ESMTP id AF17B2C012F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2013 04:56:14 +1000 (EST)
Received: from juliette.telenet-ops.be (juliette.telenet-ops.be
 [195.130.137.74])
 by winston.telenet-ops.be (Postfix) with ESMTP id 211531BD834
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2013 20:56:12 +0200 (CEST)
Date: Tue, 16 Apr 2013 20:56:11 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@linux-m68k.org
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Build regressions/improvements in v3.9-rc7
In-Reply-To: <alpine.DEB.2.00.1304162052210.2338@ayla.of.borg>
Message-ID: <alpine.DEB.2.00.1304162052420.2358@ayla.of.borg>
References: <alpine.DEB.2.00.1304162052210.2338@ayla.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/PPC Development <linuxppc-dev@lists.ozlabs.org>,
 linux-sh@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 16 Apr 2013, Geert Uytterhoeven wrote:
> JFYI, when comparing v3.9-rc7 to v3.9-rc6[3], the summaries are:
>   - build errors: +8/-10

  + drivers/pcmcia/electra_cf.c: error: implicit declaration of function '__ioremap_at' [-Werror=implicit-function-declaration]:  => 225:2
  + drivers/pcmcia/electra_cf.c: error: implicit declaration of function '__iounmap_at' [-Werror=implicit-function-declaration]:  => 316:3
  + drivers/pcmcia/electra_cf.c: error: implicit declaration of function 'in_le32' [-Werror=implicit-function-declaration]:  => 70:2
  + drivers/pcmcia/electra_cf.c: error: implicit declaration of function 'ioremap' [-Werror=implicit-function-declaration]:  => 213:2  + drivers/pcmcia/electra_cf.c: error: implicit declaration of function 'iounmap' [-Werror=implicit-function-declaration]:  => 318:3
  + drivers/pcmcia/electra_cf.c: error: implicit declaration of function 'out_le32' [-Werror=implicit-function-declaration]:  => 147:2

powerpc-randconfig

>   - build warnings: +164/-34

And my eye fell on this one:

  + include/math-emu/double.h: warning: "__LITTLE_ENDIAN" is not defined [-Wundef]:  => 59:5
  + include/math-emu/single.h: warning: "__LITTLE_ENDIAN" is not defined [-Wundef]:  => 50:5

sh-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/6094/ (all 118 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/6063/ (all 118 configs)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
