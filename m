Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0E0E7DDED9
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 17:39:58 +1100 (EST)
Message-Id: <CE85949A-8D58-4732-A82D-B55D0782953F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
In-Reply-To: <200804021646.31765.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] powerpc: Fix CPM2 SCC1 clock initialization.
Date: Thu, 3 Apr 2008 01:39:44 -0500
References: <200804021646.31765.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 2, 2008, at 9:46 AM, Laurent Pinchart wrote:
> A missing break statement in a switch caused cpm2_clk_setup() to  
> initialize
> SCC2 instead of SCC1. This patch fixes the bug.
>
> Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
> ---
> arch/powerpc/sysdev/cpm2.c |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)

applied.

However your email is malformatted.  Since it was a trivial patch I  
fixed it up by hand.

- k
