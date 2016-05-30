Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ig0-x243.google.com (mail-ig0-x243.google.com
 [IPv6:2607:f8b0:4001:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJ7fT52xKzDqT1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 17:34:09 +1000 (AEST)
Received: by mail-ig0-x243.google.com with SMTP id u4so5130759igl.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 00:34:09 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1464593333-10283-1-git-send-email-geert@linux-m68k.org>
References: <1464593333-10283-1-git-send-email-geert@linux-m68k.org>
Date: Mon, 30 May 2016 09:34:07 +0200
Message-ID: <CAMuHMdVvK9h2MLVAeB3n8G6hfKJU1Rma2_uVYBTqsFxnRv2YsA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.7-rc1
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 30, 2016 at 9:28 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>   + /home/kisskb/slave/src/arch/powerpc/include/asm/nohash/64/pgalloc.h: error: implicit declaration of function 'pte_fragment_fre' [-Werror=implicit-function-declaration]/home/kisskb/slave/src/arch/powerpc/mm/pgtable.c: At top level::  => 175:2
>   + /home/kisskb/slave/src/arch/powerpc/include/asm/nohash/64/pgalloc.h: error: implicit declaration of function 'pte_fragment_fre' [-Werror=implicit-function-declaration]:  => 175:2
>   + /home/kisskb/slave/src/arch/powerpc/kernel/pci_dn.c: error: 'struct pci_dn' has no member named 'edev':  => 272:8
>   + /home/kisskb/slave/src/arch/powerpc/kernel/pci_dn.c: error: dereferencing pointer to incomplete type:  => 215:7
>   + /home/kisskb/slave/src/arch/powerpc/kernel/pci_dn.c: error: implicit declaration of function 'eeh_dev_init' [-Werror=implicit-function-declaration]:  => 212:3
>   + /home/kisskb/slave/src/arch/powerpc/mm/init_64.c: error: 'PUD_TABLE_SIZE' undeclared (first use in this function):  => 90:18

powerpc-randconfig

>   + /home/kisskb/slave/src/arch/sh/kernel/setup.c: error: implicit declaration of function 'early_init_dt_scan' [-Werror=implicit-function-declaration]:  => 256:2

sh-randconfig

>   + error: fou6.c: undefined reference to `ip6_tnl_encap_add_ops':  => .init.text+0x4b0f), .init.text+0x4b24)
>   + error: fou6.c: undefined reference to `ip6_tnl_encap_del_ops':  => .exit.text+0x438), .init.text+0x4b39), .exit.text+0x447)

i386-randconfig (fix from Arnd just applied by DaveM).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
