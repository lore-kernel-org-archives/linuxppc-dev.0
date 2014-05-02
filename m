Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B8297140106
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 May 2014 01:44:39 +1000 (EST)
Received: by mail-pa0-f53.google.com with SMTP id kp14so1105162pab.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 May 2014 08:44:36 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1399045268-18344-1-git-send-email-geert@linux-m68k.org>
References: <1399045268-18344-1-git-send-email-geert@linux-m68k.org>
Date: Fri, 2 May 2014 17:44:36 +0200
Message-ID: <CAMuHMdU=YJ-W9KaE7Y4Q0pYEQ=rb9GKG7qQX1tsm2AJ8AC3bhQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.15-rc3
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 uml-devel <user-mode-linux-devel@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 2, 2014 at 5:41 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.15-rc3[1]  to v3.15-rc2[3], the summaries are:
>   - build errors: +5/-9

  + /scratch/kisskb/src/arch/um/os-Linux/mem.c: error: 'TMPFS_MAGIC'
undeclared (first use in this function):  => 31
  + /scratch/kisskb/src/arch/um/os-Linux/mem.c: error: (Each
undeclared identifier is reported only once:  => 31
  + /scratch/kisskb/src/arch/um/os-Linux/mem.c: error: for each
function it appears in.):  => 31
  + /scratch/kisskb/src/arch/um/os-Linux/mem.c: error: linux/magic.h:
No such file or directory:  => 16:25

um-defconfig

  + error: No rule to make target include/config/auto.conf:  => N/A

powerpc-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/7427/ (all 119 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/7401/ (all 119 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
