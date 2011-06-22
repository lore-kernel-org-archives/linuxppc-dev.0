Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7B0F1B6FE0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jun 2011 21:14:53 +1000 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e33.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p5MB7Ex6010335
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2011 05:07:14 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id p5MBEeS1201132
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2011 05:14:40 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p5MBEd8C010933
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2011 05:14:40 -0600
Date: Wed, 22 Jun 2011 07:14:39 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH] hwrng: ppc4xx - add support for ppc4xx TRNG
Message-ID: <20110622111439.GC2414@zod.rchland.ibm.com>
References: <20110621121955.GB2414@zod.rchland.ibm.com>
	<1308671762.4954.0.camel@calx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308671762.4954.0.camel@calx>
Cc: linuxppc-dev@lists.ozlabs.org, Herbert Xu <herbert@gondor.apana.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 21, 2011 at 10:56:02AM -0500, Matt Mackall wrote:
>On Tue, 2011-06-21 at 08:19 -0400, Josh Boyer wrote:
>> Various PowerPC 4xx SoCs contain a TRNG embedded in the Security function.
>> This adds a device driver for that TRNG.
>> 
>> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
>
>Looks good.
>
>Acked-by: Matt Mackall <mpm@selenic.com>

Thanks!  Whose tree should this go through?  If it doesn't matter, I can
put it in mine for the next merge window.  If they go through the crypto
tree, that's fine too.

josh
