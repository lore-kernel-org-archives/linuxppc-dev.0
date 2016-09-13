Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYNvV0fjMzDsVP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 22:16:38 +1000 (AEST)
In-Reply-To: <1473150519-30931-1-git-send-email-prasannatsmkumar@gmail.com>
To: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>, olof@lixom.net,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 herbert@gondor.apana.org.au, mpm@selenic.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: Re: hwrng: pasemi-rng - Use linux/io.h instead of asm/io.h
Message-Id: <3sYNvT6H6Yz9t1T@ozlabs.org>
Date: Tue, 13 Sep 2016 22:16:37 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-06-09 at 08:28:39 UTC, PrasannaKumar Muralidharan wrote:
> Checkpatch.pl warns about usage of asm/io.h. Use linux/io.h instead.
> 
> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/63019f3cab99c7acd27df5a5b8

cheers
