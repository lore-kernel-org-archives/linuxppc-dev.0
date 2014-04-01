Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-pd0-x233.google.com (mail-pd0-x233.google.com
 [IPv6:2607:f8b0:400e:c02::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5F4F714009D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Apr 2014 19:01:29 +1100 (EST)
Received: by mail-pd0-f179.google.com with SMTP id w10so9175704pde.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Apr 2014 01:01:26 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1396339078-22125-1-git-send-email-geert@linux-m68k.org>
References: <1396339078-22125-1-git-send-email-geert@linux-m68k.org>
Date: Tue, 1 Apr 2014 10:01:26 +0200
Message-ID: <CAMuHMdX3TwTCL3A=g15qATx_zMBr+P12mR1Cg+qTnbfuQohi8g@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.14
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: the arch/x86 maintainers <x86@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 1, 2014 at 9:57 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.14[1]  to v3.14-rc8[3], the summaries are:
>   - build errors: +2/-10

  + error: No rule to make target include/config/auto.conf:  => N/A

powerpc-randconfig

  + error: initramfs.c: undefined reference to `__stack_chk_guard':
=> .init.text+0x1067)

x86_64-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/7320/ (all 119 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/7303/ (all 119 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torval
