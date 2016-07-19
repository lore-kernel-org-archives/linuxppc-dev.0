Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.hengli.com.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rtsQq5b60zDqMf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 17:40:34 +1000 (AEST)
Date: Tue, 19 Jul 2016 15:40:07 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org,
 "Leonidas S. Barbosa" <leosilva@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "David S. Miller" <davem@davemloft.net>,
 "open list:IBM Power VMX Cryptographic instructions"
 <linux-crypto@vger.kernel.org>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 1/2] crypto: vmx - Adding asm subroutines for XTS
Message-ID: <20160719074007.GA22394@gondor.apana.org.au>
References: <1468855586-848-1-git-send-email-pfsmorigo@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1468855586-848-1-git-send-email-pfsmorigo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 18, 2016 at 12:26:25PM -0300, Paulo Flabiano Smorigo wrote:
> This patch add XTS subroutines using VMX-crypto driver.
> 
> It gives a boost of 20 times using XTS.
> 
> These code has been adopted from OpenSSL project in collaboration
> with the original author (Andy Polyakov <appro@openssl.org>).
> 
> Signed-off-by: Leonidas S. Barbosa <leosilva@linux.vnet.ibm.com>
> Signed-off-by: Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>

Both patches applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
