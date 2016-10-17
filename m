Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-it0-x22f.google.com (mail-it0-x22f.google.com
 [IPv6:2607:f8b0:4001:c0b::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sy92l6lPkzDvHv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Oct 2016 18:34:55 +1100 (AEDT)
Received: by mail-it0-x22f.google.com with SMTP id 66so729404itl.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Oct 2016 00:34:55 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1476688913-15648-1-git-send-email-geert@linux-m68k.org>
References: <1476688913-15648-1-git-send-email-geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Oct 2016 09:34:53 +0200
Message-ID: <CAMuHMdVety8LeBgM1ZHfqw=NMjH5_=sQR=LLypQ1-YjxnuvaiQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.9-rc1
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Vineet Gupta <vgupta@synopsys.com>,
 arcml <linux-snps-arc@lists.infradead.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Cris <linux-cris-kernel@axis.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 17, 2016 at 9:21 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v4.9-rc1[1] compared to v4.8[2].

> [1] http://kisskb.ellerman.id.au/kisskb/head/11053/ (all 262 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/head/10989/ (all 262 configs)

> 48 error regressions:
>   + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad instruction `llockd r2,[r0]':  => 476
>   + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad instruction `llockd r2,[r13]':  => 475
>   + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad instruction `llockd r2,[r4]':  => 475
>   + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad instruction `llockd r2,[r5]':  => 475
>   + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad instruction `llockd r2,[r6]':  => 475, 476
>   + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad instruction `llockd r2,[r8]':  => 476, 475, 515
>   + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad instruction `llockd r4,[r11]':  => 476
>   + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad instruction `llockd r4,[r13]':  => 493, 475
>   + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad instruction `llockd r4,[r14]':  => 475
>   + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad instruction `llockd r4,[r18]':  => 493
>   + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad instruction `llockd r4,[r21]':  => 493
>   + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad instruction `llockd r4,[r6]':  => 476, 475, 515
>   + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad instruction `llockd r4,[r7]':  => 475
>   + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad instruction `llockd r6,[r12]':  => 493
>   + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad instruction `llockd r6,[r3]':  => 475
>   + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad instruction `llockd r6,[r8]':  => 493
>   + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad instruction `llockd r6,[r9]':  => 493
>   + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad instruction `scondd r0,[r6]':  => 516
>   + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad instruction `scondd r10,[r12]':  => 496
>   + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad instruction `scondd r14,[r9]':  => 496
>   + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad instruction `scondd r16,[r8]':  => 496
>   + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad instruction `scondd r2,[r0]':  => 479
>   + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad instruction `scondd r2,[r13]':  => 496, 478
>   + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad instruction `scondd r2,[r18]':  => 496
>   + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad instruction `scondd r2,[r21]':  => 496
>   + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad instruction `scondd r2,[r4]':  => 478
>   + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad instruction `scondd r2,[r5]':  => 478
>   + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad instruction `scondd r2,[r6]':  => 478, 516, 479
>   + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad instruction `scondd r2,[r8]':  => 479, 478
>   + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad instruction `scondd r4,[r11]':  => 479
>   + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad instruction `scondd r4,[r13]':  => 478
>   + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad instruction `scondd r4,[r14]':  => 478
>   + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad instruction `scondd r4,[r6]':  => 479, 478
>   + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad instruction `scondd r4,[r7]':  => 478
>   + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad instruction `scondd r4,[r8]':  => 516
>   + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad instruction `scondd r6,[r3]':  => 478

arcv2/axs103_smp_defconfig

>   + /home/kisskb/slave/src/arch/powerpc/kvm/book3s_hv_rm_xics.c: error: implicit declaration of function 'get_hard_smp_processor_id' [-Werror=implicit-function-declaration]:  => 758:2

powerpc/ppc64_defconfig+UP

>   + /home/kisskb/slave/src/drivers/dma/omap-dma.c: error: unrecognizable insn::  => 350:1

cris-allyesconfig
cris-allmodconfig

>   + error: ".irq_set_parent" [drivers/mfd/tps65217.ko] undefined!:  => N/A
>   + error: "irq_set_parent" [drivers/mfd/tps65217.ko] undefined!:  => N/A

ppc64le/allmodconfig+ppc64le
powerpc/powerpc-allmodconfig

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
