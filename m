Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4284E67C4D
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 17:33:37 +1000 (EST)
Subject: Re: [PATCH] Split out vpa unregister logic from
	pseries_kexec_cpu_down_xics()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <20060824065409.645DD67C42@ozlabs.org>
References: <20060824065409.645DD67C42@ozlabs.org>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 17:33:11 +1000
Message-Id: <1156404791.8433.227.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-08-24 at 16:54 +1000, Michael Ellerman wrote:
> As part of the new irq code pseries_kexec_cpu_down() was split into a
> xics and mpic version. The vpa unregister logic is now only done in the
> xics routine, and although that's ok in practice (we don't have SPLPAR
> machines with mpic), I'd rather have the two concepts stay separate.
> 
> So move the vpa unregister into pseries_kexec_cpu_down(), which gets called
> by both the xics and mpic routines. This also gives us an obvious place to
> put any new kexec-down logic needed in future.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
