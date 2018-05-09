Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gzyb5lxXzF2Pn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 00:59:03 +1000 (AEST)
In-Reply-To: <20180502065754.13816-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: maddy@linux.ibm.com, npiggin@gmail.com
Subject: Re: powerpc/64: Remove unused paca->soft_enabled
Message-Id: <40gzyb36vXz9s4r@ozlabs.org>
Date: Thu, 10 May 2018 00:59:03 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-05-02 at 06:57:54 UTC, Michael Ellerman wrote:
> In commit 4e26bc4a4ed6 ("powerpc/64: Rename soft_enabled to
> irq_soft_mask") we renamed paca->soft_enabled. But then in commit
> 8e0b634b1327 ("powerpc/64s: Do not allocate lppaca if we are not
> virtualized") we added it back. Oops. This happened because the two
> patches were in flight at the same time and rebased vs each other
> multiple times, and we missed it in review.
> 
> Fixes: 8e0b634b1327 ("powerpc/64s: Do not allocate lppaca if we are not virtualized")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/c4ec1f0353b342473b93637fd0c3fb

cheers
