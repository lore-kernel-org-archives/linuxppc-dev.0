Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 93BF01A1BCB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 10:06:04 +1000 (AEST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Mon, 13 Jul 2015 18:06:02 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id A4E1F1FF002E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2015 17:57:10 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6E0605n54460576
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2015 17:06:00 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6E05xxw016703
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2015 18:06:00 -0600
Date: Mon, 13 Jul 2015 17:05:58 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Dan Streetman <ddstreet@us.ibm.com>,
 "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, gustavold@linux.vnet.ibm.com
Subject: Re: [PATCH 5/6] [RFC] crypto/testmgr: add null test for 842 algorithm
Message-ID: <20150714000558.GB38815@linux.vnet.ibm.com>
References: <20150702223800.GA1712@linux.vnet.ibm.com>
 <20150702224119.GF1712@linux.vnet.ibm.com>
 <20150704072453.GC6153@gondor.apana.org.au>
 <20150714000536.GA38815@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150714000536.GA38815@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 13.07.2015 [17:05:36 -0700], Nishanth Aravamudan wrote:
> On 04.07.2015 [15:24:53 +0800], Herbert Xu wrote:
> > On Thu, Jul 02, 2015 at 03:41:19PM -0700, Nishanth Aravamudan wrote:
> > > Currently, when the nx-842-pseries driver loads, the following message
> > > is emitted:
> > > 
> > > alg: No test for 842 (842-nx)
> > > 
> > > It seems like the simplest way to fix this message (other than adding a
> > > proper test) is to just insert the null test into the list in the
> > > testmgr.
> > > 
> > > Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> > 
> > Please add some real test vectors instead.

Apologies, hit send too fast. I'll work with Dan on this when he gets
back from vacation.

-Nish
