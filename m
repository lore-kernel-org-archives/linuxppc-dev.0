Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 83280DDF5B
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 15:16:17 +1000 (EST)
Message-Id: <8D6E7137-E0D3-41C0-AC39-27B9F4DFCF2D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
In-Reply-To: <200808191420.24837.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: cpm2: Fix race condition in CPM2 GPIO library.
Date: Thu, 21 Aug 2008 00:16:07 -0500
References: <200808191420.24837.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 19, 2008, at 7:20 AM, Laurent Pinchart wrote:

> The CPM2 GPIO library code uses the non thread-safe clrbits32/ 
> setbits32
> macros. This patch protects them with a spinlock.
>
> Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
> ---
> arch/powerpc/sysdev/cpm_common.c |   37 +++++++++++++++++++++++++ 
> +-----------
> 1 files changed, 26 insertions(+), 11 deletions(-)

applied.

- k
