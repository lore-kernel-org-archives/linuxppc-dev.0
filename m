Return-Path: <herbert@gondor.apana.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7rLC2Fj0zDqdv
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 20:36:35 +1000 (AEST)
Date: Tue, 9 Aug 2016 18:36:25 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-crypto@vger.kernel.org, linuxppc-dev@ozlabs.org,
 Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH v2] crypto: powerpc - CRYPT_CRC32C_VPMSUM should depend
 on ALTIVEC
Message-ID: <20160809103625.GB6934@gondor.apana.org.au>
References: <1470696375-22023-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470696375-22023-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 09, 2016 at 08:46:15AM +1000, Michael Ellerman wrote:
> The optimised crc32c implementation depends on VMX (aka. Altivec)
> instructions, so the kernel must be built with Altivec support in order
> for the crc32c code to build.
> 
> Fixes: 6dd7a82cc54e ("crypto: powerpc - Add POWER8 optimised crc32c")
> Acked-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
