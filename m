Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 29985DE1A7
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 23:48:15 +1000 (EST)
Message-Id: <6E59BCC0-526F-4767-AC7E-8C82FD7D4B3B@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
In-Reply-To: <200807221800.44234.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] cpm2: Rework baud rate generators configuration to
	support external clocks.
Date: Mon, 28 Jul 2008 08:48:05 -0500
References: <200807221800.44234.laurentp@cse-semaphore.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, vbordug@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 22, 2008, at 11:00 AM, Laurent Pinchart wrote:

> The CPM2 BRG setup functions cpm_setbrg and cpm2_fastbrg don't  
> support external
> clocks. This patch adds a new exported __cpm2_setbrg function that  
> takes the
> clock rate and clock source as extra parameters, and moves  
> cpm_setbrg and
> cpm2_fastbrg to include/asm-powerpc/cpm2.h where they become inline  
> wrappers
> around __cpm2_setbrg.
>
> Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
> ---
> arch/powerpc/sysdev/cpm2.c |   34 +++----------------------------
> include/asm-powerpc/cpm2.h |   46 ++++++++++++++++++++++++++++++ 
> +------------
> 2 files changed, 37 insertions(+), 43 deletions(-)

applied.

- k
