Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-lb0-x232.google.com (mail-lb0-x232.google.com
 [IPv6:2a00:1450:4010:c04::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4E7451A0053
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jul 2014 18:03:20 +1000 (EST)
Received: by mail-lb0-f178.google.com with SMTP id 10so3669873lbg.37
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Jul 2014 01:03:16 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1404806449-30974-1-git-send-email-geert@linux-m68k.org>
References: <1404806449-30974-1-git-send-email-geert@linux-m68k.org>
Date: Tue, 8 Jul 2014 10:03:16 +0200
Message-ID: <CAMuHMdVeE9eistCN5zcZoAL+Fm4bQ-m+-uY87eFTOF-Q5+LKBA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.16-rc4
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

On Tue, Jul 8, 2014 at 10:00 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.16-rc4[1]  to v3.16-rc3[3], the summaries are:
>   - build errors: +7/-2

  + /scratch/kisskb/src/arch/sh/drivers/dma/dma-sh.c: error:
'CHCR_TS_HIGH_MASK' undeclared (first use in this function):  => 98:12
  + /scratch/kisskb/src/arch/sh/drivers/dma/dma-sh.c: error:
'CHCR_TS_HIGH_SHIFT' undeclared (first use in this function):  =>
145:10, 98:34
  + /scratch/kisskb/src/arch/sh/drivers/dma/dma-sh.c: error:
'CHCR_TS_LOW_MASK' undeclared (first use in this function):  => 97:21
  + /scratch/kisskb/src/arch/sh/drivers/dma/dma-sh.c: error:
'CHCR_TS_LOW_SHIFT' undeclared (first use in this function):  =>
97:42, 145:10
  + /scratch/kisskb/src/arch/sh/mm/cache-sh4.c: error:
'cached_to_uncached' undeclared (first use in this function):  =>
99:17
  + /scratch/kisskb/src/arch/sh/mm/cache-sh4.c: error: implicit
declaration of function 'cpu_context'
[-Werror=implicit-function-declaration]:  => 192:2

sh-randconfig

  + /scratch/kisskb/src/scripts/mod/devicetable-offsets.c: error:
-mcall-aixdesc must be big endian:  => 1:0

powerpc-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/7639/ (all 119 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/7619/ (all 119 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
