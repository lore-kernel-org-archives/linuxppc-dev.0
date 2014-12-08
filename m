Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-lb0-x22a.google.com (mail-lb0-x22a.google.com
 [IPv6:2a00:1450:4010:c04::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 728E71A09DC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 21:27:59 +1100 (AEDT)
Received: by mail-lb0-f170.google.com with SMTP id 10so1957764lbg.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Dec 2014 02:27:55 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1418034294-17584-1-git-send-email-geert@linux-m68k.org>
References: <1418034294-17584-1-git-send-email-geert@linux-m68k.org>
Date: Mon, 8 Dec 2014 11:27:55 +0100
Message-ID: <CAMuHMdWqusEzKN_s1Uk+Ak=BrRkoTv=qpK1FT94DH_Tno2j2jA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.18
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

On Mon, Dec 8, 2014 at 11:24 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.18[1]  to v3.18-rc7[3], the summaries are:
>   - build errors: +13/-11

(ignoring non-interesting things)

  + /home/kisskb/slave/src/arch/powerpc/lib/sstep.c: error: 'do_lfd'
undeclared (first use in this function):  => 1874:29
  + /home/kisskb/slave/src/arch/powerpc/lib/sstep.c: error: 'do_lfs'
undeclared (first use in this function):  => 1872:29
  + /home/kisskb/slave/src/arch/powerpc/lib/sstep.c: error: 'do_stfd'
undeclared (first use in this function):  => 1928:30
  + /home/kisskb/slave/src/arch/powerpc/lib/sstep.c: error: 'do_stfs'
undeclared (first use in this function):  => 1926:30
  + /home/kisskb/slave/src/arch/powerpc/lib/sstep.c: error: implicit
declaration of function 'do_fp_load'
[-Werror=implicit-function-declaration]:  => 1872:4
  + /home/kisskb/slave/src/arch/powerpc/lib/sstep.c: error: implicit
declaration of function 'do_fp_store'
[-Werror=implicit-function-declaration]:  => 1926:4
  + /home/kisskb/slave/src/arch/powerpc/xmon/xmon.c: error: implicit
declaration of function 'dump_tlb_44x'
[-Werror=implicit-function-declaration]:  => 912:4

powerpc-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/8168/ (262 out of 119 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/8143/ (262 out of 119 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
