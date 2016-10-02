Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.hengli.com.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sn7Bh0p3YzDrSg
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Oct 2016 01:40:28 +1100 (AEDT)
Date: Sun, 2 Oct 2016 22:40:16 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Marcelo Cerri <marcelo.cerri@canonical.com>
Cc: linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>,
 "Leonidas S. Barbosa" <leosilva@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 George Wilson <gcwilson@us.ibm.com>
Subject: Re: [PATCH 0/3] Fix crypto/vmx/p8_ghash memory corruption
Message-ID: <20161002144016.GF18268@gondor.apana.org.au>
References: <1475080931-7926-1-git-send-email-marcelo.cerri@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1475080931-7926-1-git-send-email-marcelo.cerri@canonical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 28, 2016 at 01:42:08PM -0300, Marcelo Cerri wrote:
> This series fixes the memory corruption found by Jan Stancek in 4.8-rc7. The
> problem however also affects previous versions of the driver.
> 
> Marcelo Cerri (3):
>   crypto: ghash-generic - move common definitions to a new header file
>   crypto: vmx - Fix memory corruption caused by p8_ghash
>   crypto: vmx - Ensure ghash-generic is enabled

Patch 1/2 applied to crypto.  I have changed patch 3 to use select
instead of depend and have applied it to cryptodev.

Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
