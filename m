Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 25BBCDDE09
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 02:21:35 +1000 (EST)
Date: Thu, 10 May 2007 11:17:09 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: [PATCH] Change include protections to ASM_POWERPC
In-Reply-To: <11788099841311-git-send-email-becky.bruce@freescale.com>
Message-ID: <Pine.LNX.4.64.0705101116540.6072@localhost.localdomain>
References: <11788099841311-git-send-email-becky.bruce@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 10 May 2007, Becky Bruce wrote:

> Change several headers in include/asm-powerpc that currently use some variation
> of ASM_PPC to use ASM_POWERPC instead.
>
> Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
> ---
>  include/asm-powerpc/mpc8260.h      |    6 +++---
>  include/asm-powerpc/pmac_feature.h |    6 +++---
>  include/asm-powerpc/tsi108_irq.h   |    6 +++---
>  include/asm-powerpc/tsi108_pci.h   |    6 +++---
>  include/asm-powerpc/unistd.h       |    6 +++---
>  5 files changed, 15 insertions(+), 15 deletions(-)
>

applied.

- k
