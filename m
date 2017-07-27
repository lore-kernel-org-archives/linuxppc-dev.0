Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJBM24pCxzDrH5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 22:37:18 +1000 (AEST)
In-Reply-To: <20170704042246.22609-1-santosh@fossix.org>
To: Santosh Sivaraj <santosh@fossix.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/smp: Get cpu only after validity check
Message-Id: <3xJBM22dfXz9s1h@ozlabs.org>
Date: Thu, 27 Jul 2017 22:37:18 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-07-04 at 04:22:46 UTC, Santosh Sivaraj wrote:
> Check for validity of cpu before calling get_hard_smp_processor_id.
> 
> Found with coverity.
> 
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/76d98ab4628bf8d36498e8228a5b92

cheers
