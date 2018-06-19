Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419P934s9fzF0dj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 09:21:11 +1000 (AEST)
In-Reply-To: <20180613132356.29246-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: paulus@samba.org, npiggin@gmail.com
Subject: Re: powerpc/64s: Fix DT CPU features Power9 DD2.1 logic
Message-Id: <419P9343Byz9s4b@ozlabs.org>
Date: Wed, 20 Jun 2018 09:21:11 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-06-13 at 13:23:56 UTC, Michael Ellerman wrote:
> In the device tree CPU features quirk code we want to set
> CPU_FTR_POWER9_DD2_1 on all Power9s that aren't DD2.0 or earlier. But
> we got the logic wrong and instead set it on all CPUs that aren't
> Power9 DD2.0 or earlier, ie. including Power8.
> 
> Fix it by making sure we're on a Power9. This isn't a bug in practice
> because the only code that checks the feature is Power9 only to begin
> with. But we'll backport it anyway to avoid confusion.
> 
> Fixes: 9e9626ed3a4a ("powerpc/64s: Fix POWER9 DD2.2 and above in DT CPU features")
> Cc: stable@vger.kernel.org # v4.17+
> Reported-by: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Acked-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/749a0278c2177b2d16da5d8b135ba7

cheers
