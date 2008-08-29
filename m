Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F0B21DDFCD
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 22:10:46 +1000 (EST)
Message-Id: <700BE39C-9FCA-43F3-B33F-E6D071AA58E2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jochen Friedrich <jochen@scram.de>
In-Reply-To: <48B52D39.6000706@scram.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] cpm1: Fix race condition in CPM1 GPIO library.
Date: Fri, 29 Aug 2008 07:10:35 -0500
References: <48B52D39.6000706@scram.de>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 27, 2008, at 5:32 AM, Jochen Friedrich wrote:

> The CPM1 GPIO library code uses the non thread-safe clrbits32/ 
> setbits32
> macros. This patch protects them with a spinlock.
>
> Based on the CPM2 patch from Laurent Pinchart <laurentp@cse-semaphore.com 
> >,
> commit 639d64456e20cbfc866b18dc03cf9f9babc9c7cd.
>
> Signed-off-by: Jochen Friedrich <jochen@scram.de>
> ---
> arch/powerpc/sysdev/cpm1.c |   74 ++++++++++++++++++++++++++++++ 
> +-------------
> 1 files changed, 52 insertions(+), 22 deletions(-)

applied.

- k
