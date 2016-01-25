Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-io0-x22b.google.com (mail-io0-x22b.google.com
 [IPv6:2607:f8b0:4001:c06::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2F2CA1A001D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 19:24:09 +1100 (AEDT)
Received: by mail-io0-x22b.google.com with SMTP id 77so144085074ioc.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 00:24:09 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1453709909-15240-1-git-send-email-geert@linux-m68k.org>
References: <1453709909-15240-1-git-send-email-geert@linux-m68k.org>
Date: Mon, 25 Jan 2016 09:24:06 +0100
Message-ID: <CAMuHMdXPFRRJvw4wC8kHvSo7zbcv9159EeRjzh2xiQ_+8zxb6w@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.5-rc1
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 25, 2016 at 9:18 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v4.5-rc1[1] compared to v4.4[2].
>
> Summarized:
>   - build errors: +15/-23

> [1] http://kisskb.ellerman.id.au/kisskb/head/9841/ (all 261 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/head/9774/ (259 out of 261 configs)
>
>
> *** ERRORS ***
>
> 15 error regressions:
>   + /home/kisskb/slave/src/arch/sh/drivers/dma/dma-sh.c: error: 'DMTE6_IRQ' undeclared (first use in this function):  => 58:21

sh-randconfig

>   + /home/kisskb/slave/src/drivers/gpu/drm/vc4/vc4_v3d.c: error: called object '0u' is not a function:  => 157:29, 159:27

cris-allmodconfig
cris-allyesconfig
m32r/m32700ut.smp_defconfig
m68k-allmodconfig
parisc-allmodconfig
sh-randconfig
xtensa-allmodconfig

>   + /home/kisskb/slave/src/sound/core/compress_offload.c: error: case label does not reduce to an integer constant:  => 804:2

ppc64le/allmodconfig+ppc64le

>   + /tmp/ccDC0dZh.s: Error: can't resolve `_start' {*UND* section} - `L0 ' {.text section}:  => 378, 49
>   + /tmp/ccGniXga.s: Error: can't resolve `_start' {*UND* section} - `L0 ' {.text section}:  => 43
>   + /tmp/ccci5ABy.s: Error: can't resolve `_start' {*UND* section} - `L0 ' {.text section}:  => 366, 49
>   + /tmp/cccq2wZf.s: Error: can't resolve `_start' {*UND* section} - `L0 ' {.text section}:  => 43
>   + /tmp/cchnfEGb.s: Error: can't resolve `_start' {*UND* section} - `L0 ' {.text section}:  => 43

(reported before)

mips-allnoconfig
mips-defconfig
ip27_defconfig

>   + error: No rule to make target include/config/auto.conf:  => N/A

arm-randconfig (reported before)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
