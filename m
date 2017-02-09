Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJzCT6vnTzDqGx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2017 00:17:57 +1100 (AEDT)
In-Reply-To: <1486532012-3094-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v2] powerpc/opal-irqchip: Use interrupt names if present
Message-Id: <3vJzCT67Bvz9s7f@ozlabs.org>
Date: Fri, 10 Feb 2017 00:17:57 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-02-08 at 05:33:32 UTC, Michael Ellerman wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Recent versions of OPAL can provide names for the various OPAL interrupts,
> so let's use them. This also modernises the code that fetches the
> interrupt array to use the helpers provided by the generic code instead
> of hand-parsing the property.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/2717a33d60745f2f72e521cdaedf79

cheers
