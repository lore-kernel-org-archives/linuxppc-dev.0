Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-oi0-x236.google.com (mail-oi0-x236.google.com
 [IPv6:2607:f8b0:4003:c06::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 18D241A2BD6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Sep 2015 19:03:54 +1000 (AEST)
Received: by oiev17 with SMTP id v17so62936675oie.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Sep 2015 02:03:52 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1442134868-17607-1-git-send-email-geert@linux-m68k.org>
References: <1442134868-17607-1-git-send-email-geert@linux-m68k.org>
Date: Sun, 13 Sep 2015 11:03:51 +0200
Message-ID: <CAMuHMdV31w=aDD-=uUPOqW71xLpOnH1jWeQpH=6x=vxNSo94FQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.3-rc1
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Sep 13, 2015 at 11:01 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v4.3-rc1[1] compared to v4.2[2].
>
> Summarized:
>   - build errors: +15/-6

> [1] http://kisskb.ellerman.id.au/kisskb/head/9353/ (all 254 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/head/9309/ (all 254 configs)

>   + /home/kisskb/slave/src/arch/arm/kernel/devtree.c: error: implicit declaration of function 'early_init_dt_scan_nodes' [-Werror=implicit-function-declaration]:  => 244:2
>   + /home/kisskb/slave/src/arch/arm/kernel/devtree.c: error: implicit declaration of function 'early_init_dt_verify' [-Werror=implicit-function-declaration]:  => 215:2
>   + /home/kisskb/slave/src/arch/arm/kernel/devtree.c: error: implicit declaration of function 'of_flat_dt_match_machine' [-Werror=implicit-function-declaration]:  => 218:2
>   + /home/kisskb/slave/src/arch/arm/kernel/devtree.c: error: implicit declaration of function 'of_get_flat_dt_prop' [-Werror=implicit-function-declaration]:  => 229:3
>   + /home/kisskb/slave/src/arch/arm/kernel/devtree.c: error: implicit declaration of function 'of_get_flat_dt_root' [-Werror=implicit-function-declaration]:  => 228:3
>   + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error: 'L_PTE_DIRTY' undeclared (first use in this function):  => 39:2
>   + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error: 'L_PTE_MT_WRITEBACK' undeclared (first use in this function):  => 39:2
>   + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error: 'L_PTE_PRESENT' undeclared (first use in this function):  => 39:2
>   + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error: 'L_PTE_XN' undeclared (first use in this function):  => 39:2
>   + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error: 'L_PTE_YOUNG' undeclared (first use in this function):  => 39:2

arm-randconfig

>   + /home/kisskb/slave/src/arch/powerpc/kvm/book3s_pr.c: error: 'last_sc' may be used uninitialized in this function [-Werror=uninitialized]:  => 1094:31

powerpc-allyesconfig, powerpc-randconfig, powerpc-allmodconfig

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
