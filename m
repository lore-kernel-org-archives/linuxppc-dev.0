Return-Path: <geert@linux-m68k.org>
Received: from wilson.telenet-ops.be (wilson.telenet-ops.be [195.130.132.42])
 by ozlabs.org (Postfix) with ESMTP id 2D92F2C0104
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 19:25:22 +1000 (EST)
Received: from georges.telenet-ops.be (georges.telenet-ops.be [195.130.137.68])
 by wilson.telenet-ops.be (Postfix) with ESMTP id 83A63348524
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 11:25:01 +0200 (CEST)
Date: Tue, 20 Aug 2013 11:24:45 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@linux-m68k.org
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Build regressions/improvements in v3.11-rc6
In-Reply-To: <alpine.DEB.2.02.1308201120400.26995@ayla.of.borg>
Message-ID: <alpine.DEB.2.02.1308201121150.27907@ayla.of.borg>
References: <alpine.DEB.2.02.1308201120400.26995@ayla.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/PPC Development <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 20 Aug 2013, Geert Uytterhoeven wrote:
> JFYI, when comparing v3.11-rc6 to v3.11-rc5[3], the summaries are:
>   - build errors: +6/-9

  + arch/powerpc/kvm/book3s_xics.c: error: implicit declaration of function 'get_tb' [-Werror=implicit-function-declaration]:  => 812:3

powerpc-randconfig

  + error: No rule to make target /etc/sound/dsp001.ld:  => N/A

i386-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/6556/ (all 120 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/6532/ (all 120 configs)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
