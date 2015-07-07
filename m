Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5202A1A1056
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2015 19:36:28 +1000 (AEST)
Message-ID: <1436261781.15289.2.camel@ellerman.id.au>
Subject: Re: [PATCH v2] crypto/nx-842-{powerpc,pseries}: reduce chattiness
 of platform drivers
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Cc: Dan Streetman <ddstreet@us.ibm.com>, linux-crypto@vger.kernel.org,
 gustavold@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
Date: Tue, 07 Jul 2015 19:36:21 +1000
In-Reply-To: <20150706170621.GA3578@linux.vnet.ibm.com>
References: <20150702223800.GA1712@linux.vnet.ibm.com>
 <20150702224049.GE1712@linux.vnet.ibm.com>
 <1435887032.3665.1.camel@ellerman.id.au>
 <20150706170621.GA3578@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-07-06 at 10:06 -0700, Nishanth Aravamudan wrote:
> On 03.07.2015 [11:30:32 +1000], Michael Ellerman wrote:
> > On Thu, 2015-07-02 at 15:40 -0700, Nishanth Aravamudan wrote:
> > > While we never would successfully load on the wrong machine type, there
> > > is extra output by default regardless of machine type.
> > > 
> 
> Thanks Michael!

Thanks for cleaning it up.


> While we never would successfully load on the wrong machine type, there
> is extra output by default regardless of machine type.
> 
> For instance, on a PowerVM LPAR, we see the following:
> 
> nx_compress_powernv: loading
> nx_compress_powernv: no coprocessors found
> 
> even though those coprocessors could never be found.
> 
> Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> Cc: Dan Streetman <ddstreet@us.ibm.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-crypto@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> 
> ---
> v2:
>   Rather than not loading, just reduce the verbosity

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

I'm assuming Herbert will take this.

cheers
