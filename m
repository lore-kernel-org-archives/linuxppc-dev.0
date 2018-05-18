Return-Path: <herbert@gondor.apana.org.au>
Received: from deadmen.hmeau.com (orcrist.hmeau.com [104.223.48.154])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40nck32DZ8zF2GM
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 May 2018 04:52:43 +1000 (AEST)
Date: Sat, 19 May 2018 02:21:15 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 "David S. Miller" <davem@davemloft.net>, Ofir Drang <ofir.drang@arm.com>,
 linux-next <linux-next@vger.kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 sachinp <sachinp@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: reorder paes test lexicographically
Message-ID: <20180518182114.aqrkeoypuh2wlucy@gondor.apana.org.au>
References: <1526025847-13134-1-git-send-email-gilad@benyossef.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1526025847-13134-1-git-send-email-gilad@benyossef.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 11, 2018 at 09:04:06AM +0100, Gilad Ben-Yossef wrote:
> Due to a snafu "paes" testmgr tests were not ordered
> lexicographically, which led to boot time warnings.
> Reorder the tests as needed.
> 
> Fixes: a794d8d ("crypto: ccree - enable support for hardware keys")
> Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
