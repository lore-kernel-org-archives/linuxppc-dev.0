Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-la0-x231.google.com (mail-la0-x231.google.com
 [IPv6:2a00:1450:4010:c03::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 52B471A09D0
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Dec 2014 22:01:16 +1100 (AEDT)
Received: by mail-la0-f49.google.com with SMTP id hs14so8331045lab.22
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Dec 2014 03:01:11 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1417431336-2012-1-git-send-email-geert@linux-m68k.org>
References: <1417431336-2012-1-git-send-email-geert@linux-m68k.org>
Date: Mon, 1 Dec 2014 12:01:10 +0100
Message-ID: <CAMuHMdXPoOe3srvZp1nQQ1O6CcuROyUzAy2wNukSqwDjobZCdQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.18-rc7
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

On Mon, Dec 1, 2014 at 11:55 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.18-rc7[1]  to v3.18-rc6[3], the summaries are:
>   - build errors: +2/-10

Nothing interesting, just a known powerpc-randconfig issue and one more
truncated relocation in powerpc-allyesconfig[*].

> [1] http://kisskb.ellerman.id.au/kisskb/head/8143/ (262 out of 119 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/8117/ (120 out of 119 configs)

[*] Just wondering: Recently m68k had to fix a kernel size limitation (cfr.
    commit 486df8bc4627bdfc ("m68k: Increase initial mapping to 8 or 16 MiB
    if possible"), as multi_defconfig was no longer bootable. How long
    before PPC is forced to fix the toolchain due to kernel bloat ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
