Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-lb0-x236.google.com (mail-lb0-x236.google.com
 [IPv6:2a00:1450:4010:c04::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4A5461A003A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Aug 2014 06:58:21 +1000 (EST)
Received: by mail-lb0-f182.google.com with SMTP id z11so3387504lbi.41
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Aug 2014 13:58:14 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1408308358-27494-1-git-send-email-geert@linux-m68k.org>
References: <1408308358-27494-1-git-send-email-geert@linux-m68k.org>
Date: Sun, 17 Aug 2014 22:58:14 +0200
Message-ID: <CAMuHMdUrBYrHiwj=S-kWYEHb+1CX2VUgYmvJhj_aaC-8ChFL_g@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.17-rc1
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 uml-devel <user-mode-linux-devel@lists.sourceforge.net>,
 Linux-sh list <linux-sh@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Aug 17, 2014 at 10:45 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> 16 regressions:
>   + /scratch/kisskb/src/arch/powerpc/include/asm/floppy.h: error: 'isa_bridge_pcidev' undeclared (first use in this function):  => 142:20

powerpc-randconfig

>   + /scratch/kisskb/src/fs/hostfs/hostfs_user.c: error: 'AT_FDCWD' undeclared (first use in this function):  => 378
>   + /scratch/kisskb/src/fs/hostfs/hostfs_user.c: error: (Each undeclared identifier is reported only once:  => 378
>   + /scratch/kisskb/src/fs/hostfs/hostfs_user.c: error: for each function it appears in.):  => 378

um-defconfig

>   + /scratch/kisskb/src/kernel/locking/mcs_spinlock.h: error: implicit declaration of function 'cpu_relax_lowlatency' [-Werror=implicit-function-declaration]:  => 87:2

frv-defconfig (somehow the fix never made it past Linus' mbox)

>   + error: "flush_icache_range" [drivers/misc/lkdtm.ko] undefined!:  => N/A

sh-allmodconfig (woohoo, this means it has reached the link phase!)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
