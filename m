Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ie0-x236.google.com (mail-ie0-x236.google.com
 [IPv6:2607:f8b0:4001:c03::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 006182C013B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 06:27:10 +1100 (EST)
Received: by mail-ie0-f182.google.com with SMTP id aq17so17161054iec.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Oct 2013 12:27:07 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1381173828-3877-1-git-send-email-geert@linux-m68k.org>
References: <1381173828-3877-1-git-send-email-geert@linux-m68k.org>
Date: Mon, 7 Oct 2013 21:27:06 +0200
Message-ID: <CAMuHMdVF=-RRRgDPjwc6C6=_2=hQJGyCUGtqBvRHCUjZftNrEg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.12-rc4
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

On Mon, Oct 7, 2013 at 9:23 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.12-rc4 to v3.12-rc3[3], the summaries are:
>   - build errors: +6/-10

  + /scratch/kisskb/src/arch/powerpc/xmon/xmon.c: error: implicit
declaration of function 'dump_tlb_44x'
[-Werror=implicit-function-declaration]:  => 897:4
  + /scratch/kisskb/src/drivers/tty/serial/nwpserial.c: error:
implicit declaration of function 'udelay'
[-Werror=implicit-function-declaration]:  => 53:3

powerpc-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/6753/ (all 120 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/6727/ (all 120 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
