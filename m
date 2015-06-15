Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-oi0-x235.google.com (mail-oi0-x235.google.com
 [IPv6:2607:f8b0:4003:c06::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B9B071A1A93
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 22:14:59 +1000 (AEST)
Received: by oiha141 with SMTP id a141so57354436oih.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 05:14:57 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1434365804-11523-1-git-send-email-geert@linux-m68k.org>
References: <1434365804-11523-1-git-send-email-geert@linux-m68k.org>
Date: Mon, 15 Jun 2015 14:14:57 +0200
Message-ID: <CAMuHMdUmPhz+vBg2Hw8YnEmPEeJwQB1g1=Mxsdvp2fUOoz7=BQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.1-rc8
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "the arch/x86 maintainers" <x86@kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
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

On Mon, Jun 15, 2015 at 12:56 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.1-rc8[1] to v4.1-rc7[3], the summaries are:
>   - build errors: +10/-7

  + /home/kisskb/slave/src/Documentation/prctl/disable-tsc-ctxt-sw-stress-test.c:
error: impossible register constraint in 'asm':  => 34:1
  + /home/kisskb/slave/src/Documentation/prctl/disable-tsc-on-off-stress-test.c:
error: impossible register constraint in 'asm':  => 36:1
  + /home/kisskb/slave/src/Documentation/prctl/disable-tsc-test.c:
error: impossible register constraint in 'asm':  => 36:1
  + /home/kisskb/slave/src/Documentation/vDSO/vdso_standalone_test_x86.c:
error: impossible register constraint in 'asm':  => 49:2

i386-randconfig

  + /home/kisskb/slave/src/arch/sh/mm/cache-sh4.c: error:
'cached_to_uncached' undeclared (first use in this function):  =>
99:17
  + /home/kisskb/slave/src/arch/sh/mm/cache-sh4.c: error: implicit
declaration of function 'cpu_context'
[-Werror=implicit-function-declaration]:  => 192:2

sh-randconfig

  + error: No rule to make target include/config/auto.conf:  => N/A

arm-randconfig

  + error: aes.c: undefined reference to `.enable_kernel_altivec':  =>
.text+0xc921e0), .text+0xc92394), .text+0xc92460)
  + error: aes_cbc.c: undefined reference to `.enable_kernel_altivec':
 => .text+0xc92598), .text+0xc926f4)

powerpc-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/9008/ (254 out of 257 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/8978/ (254 out of 257 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
