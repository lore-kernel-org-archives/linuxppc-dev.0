Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rwfrg0QzzzDqYG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 15:50:43 +1000 (AEST)
In-Reply-To: <1468901033-28996-3-git-send-email-alastair@au1.ibm.com>
To: Alastair D'Silva <alastair@au1.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org, paulus@samba.org,
 linux-crypto@vger.kernel.org, Alastair D'Silva <alastair@d-silva.org>,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Subject: Re: [V2,
 2/2] crypto: vmx - Convert to CPU feature based module autoloading
Message-Id: <3rwfrf67mVz9t0j@ozlabs.org>
Date: Fri, 22 Jul 2016 15:50:42 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-19-07 at 04:03:53 UTC, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> This patch utilises the GENERIC_CPU_AUTOPROBE infrastructure
> to automatically load the vmx_crypto module if the CPU supports
> it.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ccf5c442a1b82bf74105d72416

cheers
