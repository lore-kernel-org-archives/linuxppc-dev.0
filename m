Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
 [209.85.212.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A4E102C0091
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Nov 2012 20:20:47 +1100 (EST)
Received: by mail-vb0-f51.google.com with SMTP id fq11so466225vbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Nov 2012 01:20:42 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1353230222-3464-1-git-send-email-geert@linux-m68k.org>
References: <1353230222-3464-1-git-send-email-geert@linux-m68k.org>
Date: Sun, 18 Nov 2012 10:20:42 +0100
Message-ID: <CAMuHMdXuoAhW=CLogzprPe+6=8Oe5y0J6SuZnYKQzhMv=dpuTg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.7-rc6
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Nov 18, 2012 at 10:17 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.7-rc6 to v3.7-rc5[3], the summaries are:
>   - build errors: +2/-12

Just some broken dependencies, I guess:

2 regressions:
  + arch/powerpc/sysdev/mpic.c: error: case label does not reduce to
an integer constant:  => 890:9, 898:9, 886:9, 894:9

powerpc/powerpc-randconfig

  + error: "__ashrdi3" [fs/ext4/ext4.ko] undefined!:  => N/A

sh4/sh-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/5628/ (all 117 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/5614/ (all 117 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
