Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJzG44WRQzDqLJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2017 00:20:12 +1100 (AEDT)
In-Reply-To: <1486427736.4850.103.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Paul Mackerras <pmac@au1.ibm.com>
Subject: Re: [2/2] powerpc/powernv: Properly set "host-ipi" on IPIs
Message-Id: <3vJzG43Bnfz9s7f@ozlabs.org>
Date: Fri, 10 Feb 2017 00:20:12 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-02-07 at 00:35:36 UTC, Benjamin Herrenschmidt wrote:
> Otherwise KVM will fail to pass them through to the host
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/f83e6862047e1e371bdc5d512dd6ca

cheers
