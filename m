Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ltvw2NWxzDqhV
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 00:25:32 +1000 (AEST)
In-Reply-To: <1528874937.14408.2.camel@hbabu-laptop>
To: Haren Myneni <haren@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, herbert@gondor.apana.org.au,
 stewart@linux.ibm.com, linux-crypto@vger.kernel.org
Subject: Re: [V3,1/2] powerpc/powernv: Export opal_check_token symbol
Message-Id: <41ltvs6JsBz9s4V@ozlabs.org>
Date: Thu,  9 Aug 2018 00:25:27 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-06-13 at 07:28:57 UTC, Haren Myneni wrote:
> Export opal_check_token symbol for modules to check the availability
> of OPAL calls before using them.
> 
> Signed-off-by: Haren Myneni <haren@us.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6e708000ec2c93c2bde6a46aa2d6c3

cheers
