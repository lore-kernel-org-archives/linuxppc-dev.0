Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Cb5y1wzszF0dT
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jun 2018 22:56:06 +1000 (AEST)
In-Reply-To: <20180619230454.8881-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/64s: Fix build failures with CONFIG_NMI_IPI=n
Message-Id: <41Cb5x3Gklz9s3C@ozlabs.org>
Date: Sat, 23 Jun 2018 22:56:05 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-06-19 at 23:04:54 UTC, Michael Ellerman wrote:
> I broke the build when CONFIG_NMI_IPI=n with my recent commit to add
> arch_trigger_cpumask_backtrace(), eg:
> 
>   stacktrace.c:(.text+0x1b0): undefined reference to `.smp_send_safe_nmi_ipi'
> 
> We should rework the CONFIG symbols here in future to avoid these
> double barrelled ifdefs but for now they fix the build.
> 
> Fixes: 5cc05910f26e ("powerpc/64s: Wire up arch_trigger_cpumask_backtrace()")
> Reported-by: Christophe LEROY <christophe.leroy@c-s.fr>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/e08ecba17b72aeb01859601bc242a5

cheers
