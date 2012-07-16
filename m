Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-yx0-f170.google.com (mail-yx0-f170.google.com
 [209.85.213.170])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4E37A2C00FF
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2012 04:59:50 +1000 (EST)
Received: by yenl12 with SMTP id l12so4902728yen.15
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2012 11:59:47 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1342464946-30236-1-git-send-email-geert@linux-m68k.org>
References: <1342464946-30236-1-git-send-email-geert@linux-m68k.org>
Date: Mon, 16 Jul 2012 20:59:47 +0200
Message-ID: <CAMuHMdW39GoFf4or-7PJxW78zUPkZe+pyAqjN59FNTOZYWnQ6g@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.5-rc7
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Cc: Linuxppc-dev <linuxppc-dev@ozlabs.org>, Chris Zankel <chris@zankel.net>,
 Linux-sh list <linux-sh@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 16, 2012 at 8:55 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.5-rc7 to v3.5-rc6[3], the summaries are:
>   - build errors: +5/-24

5 regressions:
  + arch/powerpc/sysdev/mpic.c: error: case label does not reduce to
an integer constant:  => 890:9, 898:9, 886:9, 894:9

powerpc-randconfig

  + drivers/scsi/bnx2i/bnx2i_iscsi.c: error: implicit declaration of
function 'pci_iomap' [-Werror=implicit-function-declaration]:  =>
816:3
  + drivers/scsi/bnx2i/bnx2i_iscsi.c: error: implicit declaration of
function 'pci_iounmap' [-Werror=implicit-function-declaration]:  =>
887:3

xtensa-allmodconfig

  + error: idt77252.c: relocation truncated to fit: R_PPC64_REL24
against symbol `_restgpr0_29' defined in .text section in
arch/powerpc/lib/built-in.o:  => (.text+0x1ff83a0)

powerpc-allyesconfig

  + kernel/sys.c: error: 'mmap_min_addr' undeclared (first use in this
function): 1864:34 => 1868:37, 1868:34

sh-randconfig, sh-allyesconfig, sh-allmodconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/5243/ (all 116 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
