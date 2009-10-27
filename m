Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CE6E2B7BA3
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Oct 2009 14:21:51 +1100 (EST)
Subject: Re: [PATCH 10/16] percpu: make percpu symbols in powerpc unique
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tejun Heo <tj@kernel.org>
In-Reply-To: <1255500125-3210-11-git-send-email-tj@kernel.org>
References: <1255500125-3210-1-git-send-email-tj@kernel.org>
	<1255500125-3210-11-git-send-email-tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Oct 2009 14:19:49 +1100
Message-ID: <1256613589.11607.29.camel@pasglop>
Mime-Version: 1.0
Cc: cl@linux-foundation.org, rusty@rustcorp.com.au,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	linuxppc-dev@ozlabs.org, mingo@redhat.com,
	Paul Mackerras <paulus@samba.org>, cebbert@redhat.com,
	hpa@zytor.com, tglx@linutronix.de, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-10-14 at 15:01 +0900, Tejun Heo wrote:
> This patch updates percpu related symbols in powerpc such that percpu
> symbols are unique and don't clash with local symbols.  This serves
> two purposes of decreasing the possibility of global percpu symbol
> collision and allowing dropping per_cpu__ prefix from percpu symbols.
> 
> * arch/powerpc/kernel/perf_callchain.c: s/callchain/cpu_perf_callchain/
> 
> * arch/powerpc/kernel/setup-common.c: s/pvr/cpu_pvr/
> 
> * arch/powerpc/platforms/pseries/dtl.c: s/dtl/cpu_dtl/
> 
> * arch/powerpc/platforms/cell/interrupt.c: s/iic/cpu_iic/
> 
> Partly based on Rusty Russell's "alloc_percpu: rename percpu vars
> which cause name clashes" patch.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Rusty Russell <rusty@rustcorp.com.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Cheers,
Ben.
