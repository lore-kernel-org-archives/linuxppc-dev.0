Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rp1Kr4cKlzDqxj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 20:19:28 +1000 (AEST)
In-Reply-To: <1467226517-29098-1-git-send-email-imunsie@au.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>, mikey <mikey@neuling.org>,
 linuxppc-dev@lists.ozlabs.org, Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Huy Nguyen <huyn@mellanox.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: cxl: Fix NULL pointer dereference on kernel contexts with no AFU
 interrupts
Message-Id: <3rp1Kr27Y2z9t0p@ozlabs.org>
Date: Mon, 11 Jul 2016 20:19:27 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-29-06 at 18:55:17 UTC, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> If a kernel context is initialised and does not have any AFU interrupts
> allocated it will cause a NULL pointer dereference when the context is
> detached since the irq_names list will not have been initialised.
> 
> Move the initialisation of the irq_names list into the cxl_context_init
> routine so that it will be valid for the entire lifetime of the context
> and will not cause a NULL pointer dereference.
> 
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f5c9df9a442f586b1839476272

cheers
