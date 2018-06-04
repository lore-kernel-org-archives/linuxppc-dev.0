Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zxfc4lXLzF0Rs
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 00:10:32 +1000 (AEST)
In-Reply-To: <20180406011720.7728-2-mgreer@animalcreek.com>
To: Mark Greer <mgreer@animalcreek.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Remi Machet <rmachet@nvidia.com>, Dale Farnsworth <dale@farnsworth.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Mark Greer <mgreer@animalcreek.com>
Subject: Re: [1/5] powerpc/embedded6xx: Remove C2K board support
Message-Id: <40zxfb5H0xz9s2S@ozlabs.org>
Date: Tue,  5 Jun 2018 00:10:31 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-04-06 at 01:17:16 UTC, Mark Greer wrote:
> The C2K platform appears to be orphaned so remove code supporting it.
> 
> CC: Remi Machet <rmachet@nvidia.com>
> Signed-off-by: Mark Greer <mgreer@animalcreek.com>
> Acked-by: Remi Machet <remi@machet.us>
> Signed-off-by: Mark Greer <mgreer@animalcreek.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/92c8c16f345759e87c5d5b771d438f

cheers
