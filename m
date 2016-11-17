Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.apana.org.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKQLx56XmzDvg0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 02:40:41 +1100 (AEDT)
Date: Thu, 17 Nov 2016 23:40:26 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: "Leonidas S. Barbosa" <leosilva@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: crypto/vmx: various build fixes
Message-ID: <20161117154026.GB1687@gondor.apana.org.au>
References: <20161116151146.15720-1-naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161116151146.15720-1-naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 16, 2016 at 08:41:46PM +0530, Naveen N. Rao wrote:
> First up, clean up the generated .S files properly on a 'make clean'.
> Secondly, force re-generation of these files when building for different
> endian-ness than what was built previously. Finally, generate the new
> files in the build tree, rather than the source tree.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
