Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-pd0-x22c.google.com (mail-pd0-x22c.google.com
 [IPv6:2607:f8b0:400e:c02::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CBD9E2C0078
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jan 2014 20:05:30 +1100 (EST)
Received: by mail-pd0-f172.google.com with SMTP id g10so17856961pdj.31
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jan 2014 01:05:21 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1388998868-31448-1-git-send-email-geert@linux-m68k.org>
References: <1388998868-31448-1-git-send-email-geert@linux-m68k.org>
Date: Mon, 6 Jan 2014 10:05:21 +0100
Message-ID: <CAMuHMdWfHtGQQ-s1z0u-PKagD0i+_pd4=H02=TyMiFfcJW63og@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.13-rc7
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: the arch/x86 maintainers <x86@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Linux-sh list <linux-sh@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 6, 2014 at 10:01 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.13-rc7[1] to v3.13-rc6[3], the summaries are:
>   - build errors: +14/-4

  + /scratch/kisskb/src/arch/sh/mm/cache-sh4.c: error:
'cached_to_uncached' undeclared (first use in this function):  =>
99:17
  + /scratch/kisskb/src/arch/sh/mm/cache-sh4.c: error: implicit
declaration of function 'cpu_context'
[-Werror=implicit-function-declaration]:  => 192:2
  + /scratch/kisskb/src/drivers/mtd/maps/vmu-flash.c: error: (near
initialization for 'vmu_flash_driver.drv'):  => 805:3, 803:3, 804:3
  + /scratch/kisskb/src/drivers/mtd/maps/vmu-flash.c: error: expected
declaration specifiers or '...' before string constant:  => 824:20,
822:16, 823:15
  + /scratch/kisskb/src/drivers/mtd/maps/vmu-flash.c: error: field
name not in record or union initializer:  => 805:3, 803:3, 804:3
  + /scratch/kisskb/src/include/linux/maple.h: error: field 'dev' has
incomplete type:  => 80:16
  + /scratch/kisskb/src/include/linux/maple.h: error: field 'drv' has
incomplete type:  => 85:23

sh-randconfig

  + /scratch/kisskb/src/drivers/tty/serial/nwpserial.c: error:
implicit declaration of function 'udelay'
[-Werror=implicit-function-declaration]:  => 53:3
  + error: No rule to make target drivers/scsi/aic7xxx/aicasm/*.[chyl]:  => N/A

powerpc-randconfig

  + error: No rule to make target /etc/sound/msndinit.bin:  => N/A
  + error: No rule to make target /etc/sound/msndperm.bin:  => N/A
  + error: No rule to make target /etc/sound/pndsperm.bin:  => N/A
  + error: No rule to make target /etc/sound/pndspini.bin:  => N/A

i386-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/7037/ (119 out of 120 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/7026/ (119 out of 120 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
