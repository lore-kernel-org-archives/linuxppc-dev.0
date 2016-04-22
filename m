Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrvdd07kmzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 22:12:53 +1000 (AEST)
In-Reply-To: <1461083664-12283-1-git-send-email-fbarrat@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: cxl: Increase timeout for detection of AFU mmio hang
Message-Id: <3qrvdc6WDTz9t4b@ozlabs.org>
Date: Fri, 22 Apr 2016 22:12:52 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-19-04 at 16:34:24 UTC, Frederic Barrat wrote:
> PSL designers recommend a larger value for the mmio hang pulse, 256 us
> instead of 1 us. The CAIA architecture states that it needs to be
> smaller than 1/2 of the RTOS timeout set in the PHB for outbound
> non-posted transactions, which is still (easily) the case here.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>
> Tested-by: Frank Haverkamp <haver@linux.vnet.ibm.com>
> Tested-by: Manoj Kumar <manoj@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/4aec6ec0da9c72c0fa1a5b0d11

cheers
