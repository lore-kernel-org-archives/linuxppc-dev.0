Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41WNmx2wHNzDq6t
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 16:06:09 +1000 (AEST)
In-Reply-To: <20180712214149.19587-1-jrtc27@jrtc27.com>
To: James Clarke <jrtc27@jrtc27.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: James Clarke <jrtc27@jrtc27.com>
Subject: Re: powerpc/Makefile: Assemble with -me500 when building for E500
Message-Id: <41WNmx1tMJz9s21@ozlabs.org>
Date: Thu, 19 Jul 2018 16:06:09 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-07-12 at 21:41:49 UTC, James Clarke wrote:
> Some of the assembly files use instructions specific to BookE or E500,
> which are rejected with the now-default -mcpu=powerpc, so we must pass
> -me500 to the assembler just as we pass -me200 for E200.
> 
> Fixes: 4bf4f42a2feb ("powerpc/kbuild: Set default generic machine type for 32-bit compile")
> Signed-off-by: James Clarke <jrtc27@jrtc27.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/4e4a4b75ccce827f9b8b04b6ee5c90

cheers
