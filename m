Return-Path: <geert@linux-m68k.org>
Received: from winston.telenet-ops.be (winston.telenet-ops.be [195.130.137.75])
 by ozlabs.org (Postfix) with ESMTP id 3E8DA2C00F2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 07:07:06 +1000 (EST)
Received: from gerard.telenet-ops.be (gerard.telenet-ops.be [195.130.132.48])
 by winston.telenet-ops.be (Postfix) with ESMTP id 26B6A1BC67B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2013 23:07:03 +0200 (CEST)
Date: Tue, 9 Apr 2013 23:07:02 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@linux-m68k.org
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Build regressions/improvements in v3.9-rc6
In-Reply-To: <alpine.DEB.2.00.1304092304220.23715@ayla.of.borg>
Message-ID: <alpine.DEB.2.00.1304092304550.23730@ayla.of.borg>
References: <alpine.DEB.2.00.1304092304220.23715@ayla.of.borg>
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

On Tue, 9 Apr 2013, Geert Uytterhoeven wrote:
> JFYI, when comparing v3.9-rc6 to v3.9-rc5[3], the summaries are:
>   - build errors: +8/-13

Ignoring R_PPC64_REL24 truncated relocations, as usual:

  + error: binder.c: undefined reference to `get_vm_area':  => .text+0x2fe8b8)
  + error: binder.c: undefined reference to `map_vm_area':  => .text+0x2fa11c) 
  + error: binder.c: undefined reference to `zap_page_range':  => .text+0x2fa354)

sh4/sh-randconfig

  + error: cuboot-pq2.c: undefined reference to `fsl_get_immr':  => .text+0x314)

powerpc-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/6063/ (all 118 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/6041/ (all 118 configs)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
