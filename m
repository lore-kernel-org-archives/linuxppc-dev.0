Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-pb0-x22f.google.com (mail-pb0-x22f.google.com
 [IPv6:2607:f8b0:400e:c01::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4944314003E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Mar 2014 18:55:40 +1100 (EST)
Received: by mail-pb0-f47.google.com with SMTP id up15so1592238pbc.20
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Mar 2014 00:55:37 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1395820064-19148-1-git-send-email-geert@linux-m68k.org>
References: <1395820064-19148-1-git-send-email-geert@linux-m68k.org>
Date: Wed, 26 Mar 2014 08:55:37 +0100
Message-ID: <CAMuHMdWQmAmG8oebHh8SVodAp_TXHX1wLBoEZRfMz=HRxVdQmg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.14-rc8
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Linux-sh list <linux-sh@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 26, 2014 at 8:47 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.14-rc8[1]  to v3.14-rc7[3], the summaries are:
>   - build errors: +6/-1

  + /scratch/kisskb/src/arch/powerpc/include/asm/io.h: error:
'virt_phys_offset' undeclared (first use in this function):  =>
814:16, 807:16, 770:9, 787:17
  + /scratch/kisskb/src/include/linux/mm.h: error: 'virt_phys_offset'
undeclared (first use in this function):  => 890:9, 1402:20, 494:22

powerpc-randconfig

  + /scratch/kisskb/src/arch/sh/drivers/dma/dma-sh.c: error:
'CHCR_TS_HIGH_MASK' undeclared (first use in this function):  => 98:12
  + /scratch/kisskb/src/arch/sh/drivers/dma/dma-sh.c: error:
'CHCR_TS_HIGH_SHIFT' undeclared (first use in this function):  =>
98:34, 145:10
  + /scratch/kisskb/src/arch/sh/drivers/dma/dma-sh.c: error:
'CHCR_TS_LOW_MASK' undeclared (first use in this function):  => 97:21
  + /scratch/kisskb/src/arch/sh/drivers/dma/dma-sh.c: error:
'CHCR_TS_LOW_SHIFT' undeclared (first use in this function):  =>
97:42, 145:10

sh-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/7303/ (all 119 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/7277/ (all 119 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
