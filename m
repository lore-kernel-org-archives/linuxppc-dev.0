Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.hengli.com.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 38FA31A025F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 17:02:39 +1000 (AEST)
Date: Tue, 14 Jul 2015 15:02:31 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "Leonidas S. Barbosa" <leosilva@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, pfsmorigo@linux.vnet.ibm.com,
 mpe@ellerman.id.au
Subject: Re: [PATCH 0/2] Uncomment VSX enable routine for instructions access
Message-ID: <20150714070231.GA20792@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150713165011.GA3356@bluepex.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Leonidas S. Barbosa <leosilva@linux.vnet.ibm.com> wrote:
> enable_kernel_vsx() was commented since anything was using
> it. It changes with vmx_crypto driver that call VSX instructions
> and need kernel_vsx enabled in order to do it properly. Without
> a way to enable VSX instruction vmx_crypto fails into an exception.
> 
> These patches uncomment enable_kernel_vsx() rountine and put it
> available for use. Also adds it in vmx_crypto in order to
> enable kernel_vsx before use VSX instructions.
> 
> Leonidas S. Barbosa (2):
>  Uncomment and make enable_kernel_vsx() routine available
>  Adding enable_kernel_vsx() to access VSX instructions

All applied.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
