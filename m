Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xkKqF4qL9zDqk0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 23:30:01 +1000 (AEST)
In-Reply-To: <1504163489.4681.4.camel@hbabu-laptop>
To: Haren Myneni <haren@linux.vnet.ibm.com>, herbert@gondor.apana.org.au
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, linuxram@us.ibm.com, npiggin@gmail.com, suka@us.ibm.com,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, ddstreet@ieee.org
Subject: Re: [V4,
 1/7] crypto/nx: Rename nx842_powernv_function as icswx function
Message-Id: <3xkKqF2jcvz9t3P@ozlabs.org>
Date: Fri,  1 Sep 2017 23:30:00 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-08-31 at 07:11:29 UTC, Haren Myneni wrote:
> Rename nx842_powernv_function to nx842_powernv_exec.
> nx842_powernv_exec points to nx842_exec_icswx and
> will be point to VAS exec function which will be added later
> for P9 NX support.
> 
> Signed-off-by: Haren Myneni <haren@us.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c97f8169fb227cae5adeac56cafa98

cheers
