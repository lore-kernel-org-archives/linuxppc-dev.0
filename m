Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40B8xS5FVjzF2MB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 01:13:32 +1100 (AEDT)
In-Reply-To: <20180327120153.31612-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mauricfo@linux.vnet.ibm.com
Subject: Re: [v2,
 01/10] powerpc: Add security feature flags for Spectre/Meltdown
Message-Id: <40B8xR2CnPz9s1l@ozlabs.org>
Date: Thu, 29 Mar 2018 01:13:30 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-03-27 at 12:01:44 UTC, Michael Ellerman wrote:
> This commit adds security feature flags to reflect the settings we
> receive from firmware regarding Spectre/Meltdown mitigations.
> 
> The feature names reflect the names we are given by firmware on bare
> metal machines. See the hostboot source for details.
> 
> Arguably these could be firmware features, but that then requires them
> to be read early in boot so they're available prior to asm feature
> patching, but we don't actually want to use them for patching. We may
> also want to dynamically update them in future, which would be
> incompatible with the way firmware features work (at the moment at
> least). So for now just make them separate flags.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/9a868f634349e62922c226834aa23e

cheers
