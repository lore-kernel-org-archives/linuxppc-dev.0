Return-Path: <B11780@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1outboundpool.messaging.microsoft.com [216.32.181.184])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5F25EB6F44
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Apr 2011 19:57:48 +1000 (EST)
Subject: Re: [PATCH] powerpc/book3e: Fix extlb size
MIME-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <46db3f277b05346f7d50d31907ebcb6b11696c6d.1302247340.git.michael@ellerman.id.au>
Date: Fri, 8 Apr 2011 04:42:25 -0500
Message-ID: <D829F35C-6397-41A8-88CE-E19CA0663EC9@freescale.com>
References: <46db3f277b05346f7d50d31907ebcb6b11696c6d.1302247340.git.michael@ellerman.id.au>
To: Michael Ellerman <michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 8, 2011, at 2:22 AM, Michael Ellerman wrote:

> The calculation of the size for the exception save area of the TLB
> miss handler is wrong, luckily it's too big not too small.
> 
> Rework it to make it a bit clearer, and also correct. We want 3 save
> areas, each EX_TLB_SIZE _bytes_.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
> arch/powerpc/include/asm/paca.h |    3 ++-
> 1 files changed, 2 insertions(+), 1 deletions(-)

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k
