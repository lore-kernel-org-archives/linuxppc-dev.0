Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4CYf0jkrzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 07:48:38 +1000 (AEST)
In-Reply-To: <1450849794-23174-2-git-send-email-rashmicy@gmail.com>
To: Rashmica Gupta <rashmicy@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, mpe@ellermen.id.au
Subject: Re: [1/5] selftests/powerpc: Make reg.h common to all powerpc
 selftests
Message-Id: <3r4CYd6w63z9t49@ozlabs.org>
Date: Wed, 11 May 2016 07:48:37 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-23-12 at 05:49:50 UTC, Rashmica Gupta wrote:
> Currently there is a reg.h in pmu/ebb that has defines that are useful in
> other powerpc selftests so move this up into selftests/powerpc folder. Also
> include in utils.h - as this is often used in self tests. Add in some other
> useful register defines.

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5263230effb72fd27d7d9340cc

cheers
