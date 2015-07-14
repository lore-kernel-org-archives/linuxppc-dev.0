Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C0A181A0BAC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 10:05:45 +1000 (AEST)
Received: from /spool/local
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Mon, 13 Jul 2015 20:05:41 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 83CF938C8039
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2015 20:05:38 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6E05cON62128296
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 00:05:38 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6E05bqF019893
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2015 20:05:37 -0400
Date: Mon, 13 Jul 2015 17:05:36 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Dan Streetman <ddstreet@us.ibm.com>,
 "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, gustavold@linux.vnet.ibm.com
Subject: Re: [PATCH 5/6] [RFC] crypto/testmgr: add null test for 842 algorithm
Message-ID: <20150714000536.GA38815@linux.vnet.ibm.com>
References: <20150702223800.GA1712@linux.vnet.ibm.com>
 <20150702224119.GF1712@linux.vnet.ibm.com>
 <20150704072453.GC6153@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150704072453.GC6153@gondor.apana.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04.07.2015 [15:24:53 +0800], Herbert Xu wrote:
> On Thu, Jul 02, 2015 at 03:41:19PM -0700, Nishanth Aravamudan wrote:
> > Currently, when the nx-842-pseries driver loads, the following message
> > is emitted:
> > 
> > alg: No test for 842 (842-nx)
> > 
> > It seems like the simplest way to fix this message (other than adding a
> > proper test) is to just insert the null test into the list in the
> > testmgr.
> > 
> > Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> 
> Please add some real test vectors instead.
