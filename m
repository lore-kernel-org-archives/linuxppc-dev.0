Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rsjFG5xx0zDqL9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jul 2016 20:28:18 +1000 (AEST)
In-Reply-To: <1467959838-6900-1-git-send-email-benh@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [01/14] powerpc/powernv: Add XICS emulation APIs
Message-Id: <3rsjFG4qp8z9sC3@ozlabs.org>
Date: Sun, 17 Jul 2016 20:28:18 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-08-07 at 06:37:05 UTC, Benjamin Herrenschmidt wrote:
> OPAL provides an emulated XICS interrupt controller to
> use as a fallback on newer processors that don't have a
> XICS. It's meant as a way to provide backward compatibility
> with future processors. Add the corresponding interfaces.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9fedd3f8804af87be608310aac

cheers
