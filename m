Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zvzsp5nZDzF0TY
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 23:36:14 +1100 (AEDT)
In-Reply-To: <20180228093257.13049-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: selftests/powerpc: Fix missing clean of pmu/lib.o
Message-Id: <3zvzsn0w4xz9sXc@ozlabs.org>
Date: Mon,  5 Mar 2018 23:36:12 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-02-28 at 09:32:57 UTC, Michael Ellerman wrote:
> The tm-resched-dscr test links against pmu/lib.o, but we don't have a
> rule to clean pmu/lib.o. This can lead to a build break if you build
> for big endian and then little, or vice versa.
> 
> Fix it by making tm-resched-dscr depend on pmu/lib.c, causing the code
> to be built directly in, meaning no .o is generated.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/b7abbd5a3533a31a1e7d4696ea275d

cheers
