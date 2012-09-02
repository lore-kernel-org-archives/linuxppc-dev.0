Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-vc0-f179.google.com (mail-vc0-f179.google.com
 [209.85.220.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F108A2C0090
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Sep 2012 19:33:12 +1000 (EST)
Received: by vcqp16 with SMTP id p16so4361765vcq.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 02 Sep 2012 02:33:09 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1346577700-8156-1-git-send-email-geert@linux-m68k.org>
References: <1346577700-8156-1-git-send-email-geert@linux-m68k.org>
Date: Sun, 2 Sep 2012 11:33:08 +0200
Message-ID: <CAMuHMdUSGHF4VXa91=n96hnNTywA3e03xp6Ayc32ZyHBn=Vh5A@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.6-rc4
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, linux-input@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Sep 2, 2012 at 11:21 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.6-rc4 to v3.6-rc3[3], the summaries are:
>   - build errors: +6/-13

6 regressions:
  + drivers/input/touchscreen/edt-ft5x06.c: error: 'struct
edt_ft5x06_ts_data' has no member named 'raw_buffer':  => 846:14

powerpc-randconfig, fix reported as queued by Dmitry.

  + error: eni.c: relocation truncated to fit: R_PPC64_REL24 against
symbol `_restgpr0_25' defined in .text.save.restore section in
arch/powerpc/lib/built-in.o:  => (.text+0x1ff96e4), (.text+0x1ff9438),
(.text+0x1ff8e74)
  + error: eni.c: relocation truncated to fit: R_PPC64_REL24 against
symbol `_restgpr0_28' defined in .text.save.restore section in
arch/powerpc/lib/built-in.o:  => (.text+0x1ff9848)
  + error: eni.c: relocation truncated to fit: R_PPC64_REL24 against
symbol `_restgpr0_30' defined in .text.save.restore section in
arch/powerpc/lib/built-in.o:  => (.text+0x1ff8ea8), (.text+0x1ff8edc)
  + error: eni.c: relocation truncated to fit: R_PPC64_REL24 against
symbol `_savegpr0_29' defined in .text.save.restore section in
arch/powerpc/lib/built-in.o:  => (.text+0x1ff9cf0)
  + error: fore200e.c: relocation truncated to fit: R_PPC64_REL24
against symbol `_restgpr0_22' defined in .text.save.restore section in
arch/powerpc/lib/built-in.o:  => (.text+0x1ff8608), (.text+0x1ff7e5c)

powerpc-allyesconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/5381/ (all 116 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/5359/ (all 116 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
