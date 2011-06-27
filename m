Return-Path: <herbert@gondor.apana.org.au>
Received: from fornost.hengli.com.au (helcar.apana.org.au [209.40.204.226])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EAC5CB6F74
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 27 Jun 2011 17:33:51 +1000 (EST)
Date: Mon, 27 Jun 2011 15:33:29 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] crypto: crypto4xx - Perform read/modify/write on
	device control register
Message-ID: <20110627073329.GA9206@gondor.apana.org.au>
References: <20110621121321.GA2414@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110621121321.GA2414@zod.rchland.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, James Hsiao <jhsiao@amcc.com>,
	linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 21, 2011 at 08:13:21AM -0400, Josh Boyer wrote:
> The Security function on the AMCC SoCs has multiple engines within a
> single MMIO range.  The crypto driver currently enables the 3DES
> functionality by doing a blind write to the device control register.
> This can unintentionally disable other functions like the PKA or TRNG
> when the driver is loaded.
> 
> Perform a read/modify/write to enable the 3DES function instead.
> 
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
