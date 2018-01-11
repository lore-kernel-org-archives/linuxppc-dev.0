Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zH8qq4vqNzDqlG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 13:25:43 +1100 (AEDT)
In-Reply-To: <20180108165453.26066-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, peterz@infradead.org, linux-kernel@vger.kernel.org,
 npiggin@gmail.com, oohall@gmail.com, anton@samba.org, paulus@samba.org,
 tglx@linutronix.de
Subject: Re: [01/11] powerpc/pseries: Add H_GET_CPU_CHARACTERISTICS flags &
 wrapper
Message-Id: <3zH8qq3QlLz9t32@ozlabs.org>
Date: Thu, 11 Jan 2018 13:25:43 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-01-08 at 16:54:43 UTC, Michael Ellerman wrote:
> From: Michael Neuling <mikey@neuling.org>
> 
> A new hypervisor call has been defined to communicate various
> characteristics of the CPU to guests. Add definitions for the hcall
> number, flags and a wrapper function.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc fixes.

https://git.kernel.org/powerpc/c/191eccb1580939fb0d47deb405b82a

cheers
