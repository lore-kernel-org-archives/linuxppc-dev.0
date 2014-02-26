Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com
 [IPv6:2607:f8b0:400e:c03::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id ABE212C009A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 20:54:20 +1100 (EST)
Received: by mail-pa0-f51.google.com with SMTP id kq14so601146pab.24
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 01:54:17 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1393408336-1367-1-git-send-email-geert@linux-m68k.org>
References: <1393408336-1367-1-git-send-email-geert@linux-m68k.org>
Date: Wed, 26 Feb 2014 10:54:17 +0100
Message-ID: <CAMuHMdVXF2LgyCnf8eGoVQ5LpWe4r06tA+fvjmakvrBqX9hzwg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.14-rc4
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Linux-sh list <linux-sh@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 26, 2014 at 10:52 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.14-rc4[1]  to v3.14-rc3[3], the summaries are:
>   - build errors: +3/-15

  + /scratch/kisskb/src/arch/sh/mm/cache-sh4.c: error:
'cached_to_uncached' undeclared (first use in this function):  =>
99:17
  + /scratch/kisskb/src/arch/sh/mm/cache-sh4.c: error: implicit
declaration of function 'cpu_context'
[-Werror=implicit-function-declaration]:  => 192:2

sh-randconfig

  + error: No rule to make target include/config/auto.conf:  => N/A

powerpc-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/7212/ (all 119 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/7190/ (all 119 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
