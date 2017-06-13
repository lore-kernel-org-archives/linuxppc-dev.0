Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wn9bC6wrGzDqMF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 23:29:11 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id d5so9260875pfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 06:29:11 -0700 (PDT)
Date: Tue, 13 Jun 2017 23:28:51 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>, "Vaidyanathan Srinivasan"
 <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH 03/13] powerpc/64s: idle process interrupts from system
 reset wakeup
Message-ID: <20170613232851.37195c34@roar.ozlabs.ibm.com>
In-Reply-To: <20170613130557.26315-4-npiggin@gmail.com>
References: <20170613130557.26315-1-npiggin@gmail.com>
 <20170613130557.26315-4-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 13 Jun 2017 23:05:47 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
> index f06112cf8734..8366bdc69988 100644
> --- a/arch/powerpc/include/asm/hw_irq.h
> +++ b/arch/powerpc/include/asm/hw_irq.h
> @@ -32,6 +32,7 @@
>  #ifndef __ASSEMBLY__
>  
>  extern void __replay_interrupt(unsigned int vector);
> +extern void __replay_wakeup_interrupt(unsigned long srr1);
>  
>  extern void timer_interrupt(struct pt_regs *);
>  extern void performance_monitor_exception(struct pt_regs *regs);

Oops, just noticed this remnant from an earlier version. Please
ignore this hunk.

Thanks,
Nick
