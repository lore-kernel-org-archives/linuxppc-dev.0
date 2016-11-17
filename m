Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tK2dW6Ql3zDvph
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 11:51:59 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 "Leonidas S. Barbosa" <leosilva@linux.vnet.ibm.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: crypto/vmx: various build fixes
In-Reply-To: <20161116151146.15720-1-naveen.n.rao@linux.vnet.ibm.com>
References: <20161116151146.15720-1-naveen.n.rao@linux.vnet.ibm.com>
Date: Thu, 17 Nov 2016 11:51:56 +1100
Message-ID: <87inrnx70z.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:

> First up, clean up the generated .S files properly on a 'make clean'.
> Secondly, force re-generation of these files when building for different
> endian-ness than what was built previously. Finally, generate the new
> files in the build tree, rather than the source tree.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
> Michael,
> I've added your SOB here though you didn't explicitly include it in your
> previous mail. I hope that's fine from your end.

Yeah that's fine, thanks.

Crypto patches usually have a subject like:

crypto: vmx - Various build fixes


But maybe Herbert can fix it up for you when he applies this.

cheers
