Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-pd0-x230.google.com (mail-pd0-x230.google.com
 [IPv6:2607:f8b0:400e:c02::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C1FFF2C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Nov 2013 20:17:21 +1100 (EST)
Received: by mail-pd0-f176.google.com with SMTP id w10so3578878pde.21
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Nov 2013 01:17:18 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1385233105-20026-1-git-send-email-geert@linux-m68k.org>
References: <1385233105-20026-1-git-send-email-geert@linux-m68k.org>
Date: Sun, 24 Nov 2013 10:17:18 +0100
Message-ID: <CAMuHMdVLg9uMh3FCHnE-=Dvd8XN283hvyybVid7ffmJpFNEYow@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.13-rc1
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: sparclinux <sparclinux@vger.kernel.org>,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Nov 23, 2013 at 7:58 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> 8 regressions:
>   + /scratch/kisskb/src/arch/sparc/kernel/kgdb_64.c: error: implicit declaration of function 'exception_enter' [-Werror=implicit-function-declaration]:  => 162:7
>   + /scratch/kisskb/src/arch/sparc/kernel/kgdb_64.c: error: implicit declaration of function 'exception_exit' [-Werror=implicit-function-declaration]:  => 176:2

sparc64-allmodconfig

>   + /scratch/kisskb/src/kernel/bounds.c: error: -mcall-aixdesc must be big endian:  => 1:0
>   + /scratch/kisskb/src/scripts/mod/devicetable-offsets.c: error: -mcall-aixdesc must be big endian:  => 1:0
>   + /scratch/kisskb/src/scripts/mod/empty.c: error: -mcall-aixdesc must be big endian:  => 1:0
>   + <stdin>: error: -mcall-aixdesc must be big endian:  => 1:0

powerpc-allmodconfig
powerpc-allyesconfig

>   + error: drivers/built-in.o: undefined reference to `i2c_register_driver':  => .init.literal+0xd88)
>   + error: sram.c: undefined reference to `devm_regmap_init_i2c':  => .text+0x58ef8)

xtensa-allmodconfig
sparc-allmodconfig

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
