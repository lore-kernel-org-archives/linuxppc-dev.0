Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNQNY4tQ0zDrFq
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 19:53:17 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Herbert Xu <herbert@gondor.apana.org.au>,
 Haren Myneni <haren@linux.vnet.ibm.com>
Cc: linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mikey@neuling.org, benh@kernel.crashing.org, suka@us.ibm.com,
 ddstreet@ieee.org, linuxram@us.ibm.com, npiggin@gmail.com, hbabu@us.ibm.com
Subject: Re: [PATCH V3 2/6] crypto/nx: Create nx842_configure_crb function
In-Reply-To: <20170803055850.GA11987@gondor.apana.org.au>
References: <1500699459.23205.3.camel@hbabu-laptop>
 <20170803055850.GA11987@gondor.apana.org.au>
Date: Thu, 03 Aug 2017 19:53:16 +1000
Message-ID: <87bmnxq8oj.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Herbert Xu <herbert@gondor.apana.org.au> writes:

> On Fri, Jul 21, 2017 at 09:57:39PM -0700, Haren Myneni wrote:
>> 
>> Configure CRB is moved to nx842_configure_crb() so that it can
>> be used for icswx and VAS exec functions. VAS function will be
>> added later with P9 support.
>> 
>> Signed-off-by: Haren Myneni <haren@us.ibm.com>
>
> Your patch does not apply against cryptodev.  Please rebase.

It depends on another series that will go via my tree, so it might be
better if this series goes via my tree too?

cheers
