Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-lb0-x22e.google.com (mail-lb0-x22e.google.com
 [IPv6:2a00:1450:4010:c04::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DF4B81A0150
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 18:28:15 +1000 (EST)
Received: by mail-lb0-f174.google.com with SMTP id u10so4052728lbd.33
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 01:28:09 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1403511856-17875-1-git-send-email-geert@linux-m68k.org>
References: <1403511856-17875-1-git-send-email-geert@linux-m68k.org>
Date: Mon, 23 Jun 2014 10:28:09 +0200
Message-ID: <CAMuHMdWJPJFPLQ3YMmuPXHXUDV_Gmx2YjPP-8Lri_RT1BWxfRQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.16-rc2
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 23, 2014 at 10:24 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.16-rc2[1]  to v3.16-rc1[3], the summaries are:
>   - build errors: +1/-6

  + /scratch/kisskb/src/drivers/edac/ppc4xx_edac.c: error: request for
member 'dimm' in something not a structure or union:  => 977:45

powerpc-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/7595/ (all 119 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/7575/ (all 119 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
