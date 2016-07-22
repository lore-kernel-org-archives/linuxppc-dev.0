Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rwfrf3f65zDqYG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 15:50:42 +1000 (AEST)
In-Reply-To: <1468901033-28996-2-git-send-email-alastair@au1.ibm.com>
To: Alastair D'Silva <alastair@au1.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org, paulus@samba.org,
 linux-crypto@vger.kernel.org, Alastair D'Silva <alastair@d-silva.org>,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Subject: Re: [V2,1/2] powerpc: Add module autoloading based on CPU features
Message-Id: <3rwfrf1wwxz9t0F@ozlabs.org>
Date: Fri, 22 Jul 2016 15:50:42 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-19-07 at 04:03:52 UTC, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> This patch provides the necessary infrastructure to allow drivers
> to be automatically loaded via UDEV. It implements the minimum
> required to be able to use module_cpu_feature_match to trigger
> the GENERIC_CPU_AUTOPROBE mechanisms.
> 
> The features exposed are a mirror of the cpu_user_features
> (converted to an offset from a mask). This decision was made to
> ensure that the behavior between features for module loading and
> userspace are consistent.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/4a1202765ddf4e5bb3143c0a85

cheers
