Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.hengli.com.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rtK5L1BFFzDqDX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 20:23:34 +1000 (AEST)
Date: Mon, 18 Jul 2016 18:22:53 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: alastair@au1.ibm.com
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 davem@davemloft.net, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alastair D'Silva <alastair@d-silva.org>
Subject: Re: [PATCH 0/2] Automatically load the vmx_crypto module if supported
Message-ID: <20160718102253.GA13780@gondor.apana.org.au>
References: <1468388840-12068-1-git-send-email-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1468388840-12068-1-git-send-email-alastair@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 13, 2016 at 03:47:16PM +1000, alastair@au1.ibm.com wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> This series allows the vmx_crypto module to be detected and automatically
> loaded via UDEV if the CPU supports the vector crypto feature.
> 
> Alastair D'Silva (2):
>   powerpc: Add module autoloading based on CPU features
>   crypto: vmx - Convert to CPU feature based module autoloading

Both patches applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
