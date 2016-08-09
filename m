Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7sRv24kQzDqQ5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 21:26:35 +1000 (AEST)
In-Reply-To: <1470292695-9829-1-git-send-email-anton@ozlabs.org>
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org, herbert@gondor.apana.org.au, davem@davemloft.net
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 alastair@d-silva.org
Subject: Re: crypto: crc32c-vpmsum - Convert to CPU feature based module
 autoloading
Message-Id: <3s7sRv1923z9t1n@ozlabs.org>
Date: Tue,  9 Aug 2016 21:26:35 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-04-08 at 06:38:15 UTC, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
> 
> This patch utilises the GENERIC_CPU_AUTOPROBE infrastructure
> to automatically load the crc32c-vpmsum module if the CPU supports
> it.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/d2cf5be07ff7c7cde8bef8551a

cheers
