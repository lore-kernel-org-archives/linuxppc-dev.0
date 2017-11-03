Return-Path: <herbert@gondor.apana.org.au>
Received: from deadmen.hmeau.com (orcrist.hmeau.com [104.223.48.154])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yT4412T7dzDrD1
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Nov 2017 01:25:20 +1100 (AEDT)
Date: Fri, 3 Nov 2017 22:24:28 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org,
 "Leonidas S. Barbosa" <leosilva@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "David S. Miller" <davem@davemloft.net>,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] crypto: vmx - Use skcipher for ctr fallback
Message-ID: <20171103142428.GK9011@gondor.apana.org.au>
References: <20171016225420.31081-1-pfsmorigo@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171016225420.31081-1-pfsmorigo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 16, 2017 at 08:54:19PM -0200, Paulo Flabiano Smorigo wrote:
> Signed-off-by: Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
