Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x0nQC39ywzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Jul 2017 21:01:39 +1000 (AEST)
In-Reply-To: <20170628013236.413-1-oohall@gmail.com>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-mm@kvack.org, Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [v4,1/6] mm, x86: Add ARCH_HAS_ZONE_DEVICE to Kconfig
Message-Id: <3x0nQC2RLpz9sNx@ozlabs.org>
Date: Sun,  2 Jul 2017 21:01:39 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-06-28 at 01:32:31 UTC, Oliver O'Halloran wrote:
> Currently ZONE_DEVICE depends on X86_64 and this will get unwieldly as
> new architectures (and platforms) get ZONE_DEVICE support. Move to an
> arch selected Kconfig option to save us the trouble.
> 
> Cc: linux-mm@kvack.org
> Acked-by: Ingo Molnar <mingo@kernel.org>
> Acked-by: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/65f7d049788763969180c72ef98dab

cheers
