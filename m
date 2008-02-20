Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9EF9DDDFC0
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2008 03:41:36 +1100 (EST)
Date: Wed, 20 Feb 2008 10:40:52 -0600
From: Scott Wood <scottwood@freescale.com>
To: "Nikita V. Youshchenko" <yoush@debian.org>
Subject: Re: [PATCH] powerpc: don't create two devices for each cpm_uart
	device tree node
Message-ID: <20080220164052.GB32165@ld0162-tx32.am.freescale.net>
References: <200802200232.44486@blacky.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200802200232.44486@blacky.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 20, 2008 at 02:32:33AM +0300, Nikita V. Youshchenko wrote:
> 
>     powerpc: don't create two devices for each cpm_uart device tree node
>     
>     Code in arch/powerpc/sysdev/fsl_soc.c used to create two 'struct device'
>     objects for each cpm_uart device tree node - one "fsl-cpm-scc:uart"
>     in cpm_uart_of_init() and one "fsl-cpm-smc:uart" in cpm_smc_uart_of_init().

This is old code that only exists for non-CONFIG_PPC_CPM_NEW_BINDING
boards.  As there are none of these remaining in-tree, this code should
go away soon.

-Scott
