Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6C4F1DE0A6
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 11:34:27 +1100 (EST)
Message-Id: <8BF3E6F3-1204-4299-80AB-DB9F7775743A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Li Yang <leoli@freescale.com>
In-Reply-To: <1192793930-26039-3-git-send-email-leoli@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH v7 2/9] ipic: add new interrupts introduced by new chip
Date: Thu, 29 Nov 2007 18:34:15 -0600
References: <1192793930-26039-1-git-send-email-leoli@freescale.com>
	<1192793930-26039-2-git-send-email-leoli@freescale.com>
	<1192793930-26039-3-git-send-email-leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 19, 2007, at 6:38 AM, Li Yang wrote:

> These interrupts are introduced by the latest Freescale SoC such as
> MPC837x.
>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/sysdev/ipic.c |  138 +++++++++++++++++++++++++++++++++++ 
> +++++++--
> arch/powerpc/sysdev/ipic.h |    7 +-
> include/asm-powerpc/ipic.h |   12 ++--
> 3 files changed, 143 insertions(+), 14 deletions(-)


applied.

- k
