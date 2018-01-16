Return-Path: <SRS0=m/JJ=EL=goodmis.org=rostedt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLZ5t1WcgzF0Vh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 02:34:41 +1100 (AEDT)
Date: Tue, 16 Jan 2018 10:34:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: tglx@linutronix.de, john.stultz@linaro.org,
 linux-kernel@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org,
 acme@kernel.org, benh@kernel.crashing.org, borntraeger@de.ibm.com,
 catalin.marinas@arm.com, cmetcalf@mellanox.com, cohuck@redhat.com,
 davem@davemloft.net, deller@gmx.de, devel@driverdev.osuosl.org,
 gerald.schaefer@de.ibm.com, gregkh@linuxfoundation.org,
 heiko.carstens@de.ibm.com, hoeppner@linux.vnet.ibm.com, hpa@zytor.com,
 jejb@parisc-linux.org, jwi@linux.vnet.ibm.com, linux-mips@linux-mips.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com,
 mpe@ellerman.id.au, oberpar@linux.vnet.ibm.com, oprofile-list@lists.sf.net,
 paulus@samba.org, peterz@infradead.org, ralf@linux-mips.org,
 rric@kernel.org, schwidefsky@de.ibm.com, sebott@linux.vnet.ibm.com,
 sparclinux@vger.kernel.org, sth@linux.vnet.ibm.com,
 ubraun@linux.vnet.ibm.com, will.deacon@arm.com, x86@kernel.org
Subject: Re: [PATCH v3 02/10] include: Move compat_timespec/ timeval to
 compat_time.h
Message-ID: <20180116103433.0a1356d3@gandalf.local.home>
In-Reply-To: <20180116021818.24791-3-deepa.kernel@gmail.com>
References: <20180116021818.24791-1-deepa.kernel@gmail.com>
 <20180116021818.24791-3-deepa.kernel@gmail.com>
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

On Mon, 15 Jan 2018 18:18:10 -0800
Deepa Dinamani <deepa.kernel@gmail.com> wrote:

> diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
> index 09ad88572746..db25aa15b705 100644
> --- a/arch/x86/include/asm/ftrace.h
> +++ b/arch/x86/include/asm/ftrace.h

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> @@ -49,7 +49,7 @@ int ftrace_int3_handler(struct pt_regs *regs);
>  #if !defined(__ASSEMBLY__) && !defined(COMPILE_OFFSETS)
>  
>  #if defined(CONFIG_FTRACE_SYSCALLS) && defined(CONFIG_IA32_EMULATION)
> -#include <asm/compat.h>
> +#include <linux/compat.h>
>  
>  /*
>   * Because ia32 syscalls do not map to x86_64 syscall numbers
