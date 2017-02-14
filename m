Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vN27s4DhHzDqyM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 23:40:25 +1100 (AEDT)
In-Reply-To: <b0894e503195b13a5ed6319e897e673f376a748d.1486496890.git.naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, mhiramat@kernel.org,
 ananth@linux.vnet.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, mingo@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [1/3] kprobes: introduce weak variant of kprobe_exceptions_notify
Message-Id: <3vN27s2kxcz9s7M@ozlabs.org>
Date: Tue, 14 Feb 2017 23:40:25 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-02-07 at 19:54:14 UTC, "Naveen N. Rao" wrote:
> kprobe_exceptions_notify() is not used on some of the architectures such
> as arm[64] and powerpc anymore. Introduce a weak variant for such
> architectures.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/fc62d0207ae0ebc9d19df68394c0dc

cheers
