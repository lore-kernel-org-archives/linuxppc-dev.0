Return-Path: <herbert@gondor.apana.org.au>
Received: from deadmen.hmeau.com (orcrist.hmeau.com [104.223.48.154])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xz8W43dPRzDsND
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 20:15:28 +1000 (AEST)
Date: Fri, 22 Sep 2017 18:14:05 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
 hpa@zytor.com, x86@kernel.org, horia.geanta@nxp.com,
 dan.douglass@nxp.com, thomas.lendacky@amd.com, gary.hook@amd.com,
 harsh@chelsio.com, matthias.bgg@gmail.com,
 leosilva@linux.vnet.ibm.com, pfsmorigo@linux.vnet.ibm.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 00/11] crypto: gcm - add GCM IV size constant
Message-ID: <20170922101405.GI16270@gondor.apana.org.au>
References: <20170822080818.12486-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170822080818.12486-1-clabbe.montjoie@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 22, 2017 at 10:08:07AM +0200, Corentin Labbe wrote:
> Many GCM users use directly GCM IV size instead of using some constant.
> 
> This patch add all IV size constant used by GCM and convert drivers for using them..
> 
> Corentin Labbe (11):
>   crypto: gcm - add GCM iv size constant
>   crypto: caam - Use GCM IV size constant
>   crypto: ccp - Use GCM IV size constant
>   crypto: nx - Use GCM IV size constant
>   crypto: atmel - Use GCM IV size constant
>   crypto: bcm - Use GCM IV size constant
>   crypto: mediatek - Use GCM IV size constant
>   crypto: chelsio - Use GCM IV size constant
>   crypto: omap - Use GCM IV size constant
>   crypto: gcm - Use GCM IV size constant
>   crypto: aesni - Use GCM IV size constant

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
