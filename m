Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjrtm4Xs4zDrcT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 20:46:40 +1100 (AEDT)
In-Reply-To: <20171122122852.20078-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: npiggin@gmail.com
Subject: Re: powerpc/64s: Fix Power9 DD2.1 logic in DT CPU features
Message-Id: <3yjrtm0MsXz9t2d@ozlabs.org>
Date: Fri, 24 Nov 2017 20:46:39 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-11-22 at 12:28:52 UTC, Michael Ellerman wrote:
> I got the logic wrong in the DT CPU features code when I added the
> Power9 DD2.1 feature. We should be setting the bit if we detect a
> DD2.1, not clearing it if we detect a DD2.0.
> 
> This code isn't actually exercised at the moment so nothing is
> actually broken.
> 
> Fixes: 3ffa9d9e2a7c ("powerpc/64s: Fix Power9 DD2.0 workarounds by adding DD2.1 feature")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/4d6c51b107cc73b15a377224549aa5

cheers
