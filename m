Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 681592C0099
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Mar 2014 19:50:41 +1100 (EST)
Received: by mail-pa0-f47.google.com with SMTP id lj1so6985954pab.20
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Mar 2014 01:50:37 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1395132465-19450-1-git-send-email-geert@linux-m68k.org>
References: <1395132465-19450-1-git-send-email-geert@linux-m68k.org>
Date: Tue, 18 Mar 2014 09:50:37 +0100
Message-ID: <CAMuHMdVUKbgKEaQ-0ksTd3NJoNASmqy0CiVH6AryAt-HT7Qy3A@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.14-rc7
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Linux I2C <linux-i2c@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 18, 2014 at 9:47 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.14-rc7[1]  to v3.14-rc6[3], the summaries are:
>   - build errors: +5/-13

Ignoring randconfig failures that are not really new:

  + /scratch/kisskb/src/drivers/i2c/busses/i2c-cpm.c: error: implicit
declaration of function 'irq_of_parse_and_map'
[-Werror=implicit-function-declaration]:  => 449:2
  + /scratch/kisskb/src/drivers/i2c/busses/i2c-cpm.c: error: implicit
declaration of function 'of_iomap'
[-Werror=implicit-function-declaration]:  => 460:2

powerpc/mpc85xx_defconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/7277/ (all 119 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/7258/ (all 119 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
