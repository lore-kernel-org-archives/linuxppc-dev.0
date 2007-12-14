Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CF255DDFFA
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 15:29:27 +1100 (EST)
Message-Id: <1E4C9AA0-C7BC-4F62-9219-C98DFF106659@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Li Yang <leoli@freescale.com>
In-Reply-To: <1196766100-7411-1-git-send-email-leoli@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] ipic: ack only for edge interrupts
Date: Thu, 13 Dec 2007 22:29:13 -0600
References: <1196766100-7411-1-git-send-email-leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 4, 2007, at 5:01 AM, Li Yang wrote:

> Only external interrupts in edge detect mode support ack operation.
> Therefore, in most cases ack is not needed.  The patch makes ipic
> ack only when it's needed.  This could boost over all system  
> performance.
>
> Signed-off-by: Li Yang <leoli@freescale.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> Update to use different irq_chip for level and edge interrupts as Ben
> suggested.
> Supercedes [PATCH] ipic: change ack operation that register is  
> accessed
> only when needed
>
> arch/powerpc/sysdev/ipic.c |  113 ++++++++++++++++ 
> +---------------------------
> arch/powerpc/sysdev/ipic.h |    6 +--
> 2 files changed, 45 insertions(+), 74 deletions(-)

applied.

- k
