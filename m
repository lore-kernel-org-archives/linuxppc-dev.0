Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.hengli.com.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F9B81A060F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2015 18:34:19 +1000 (AEST)
Date: Mon, 6 Jul 2015 16:34:11 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Cc: Dan Streetman <ddstreet@us.ibm.com>,
 "David S. Miller" <davem@davemloft.net>,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 gustavold@linux.vnet.ibm.com
Subject: Re: [PATCH 0/6] drivers/nx-842: reduce verbosity of logging
Message-ID: <20150706083411.GB20800@gondor.apana.org.au>
References: <20150702223800.GA1712@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150702223800.GA1712@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 02, 2015 at 03:38:00PM -0700, Nishanth Aravamudan wrote:
> Currently, on a LPAR with the nx-842 device disabled, the following
> messages are emitted:

Patches 1-3 applied.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
