Return-Path: <yoush@debian.org>
Received: from zigzag.lvk.cs.msu.su (zigzag.lvk.cs.msu.su [158.250.17.23])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9F4E6DDD0C
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2008 17:14:44 +1100 (EST)
Received: from Debian-exim by zigzag.lvk.cs.msu.su with spam-scanned (Exim
	4.50) id 1JS4hX-0001Tr-8H
	for linuxppc-dev@ozlabs.org; Thu, 21 Feb 2008 09:14:38 +0300
From: "Nikita V. Youshchenko" <yoush@debian.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc: don't create two devices for each cpm_uart
	device tree node
Date: Thu, 21 Feb 2008 09:13:27 +0300
References: <200802200232.44486@blacky.localdomain>
	<20080220164052.GB32165@ld0162-tx32.am.freescale.net>
In-Reply-To: <20080220164052.GB32165@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200802210913.28155@blacky.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Wed, Feb 20, 2008 at 02:32:33AM +0300, Nikita V. Youshchenko wrote:
> >     powerpc: don't create two devices for each cpm_uart device tree
> > node
> >
> >     Code in arch/powerpc/sysdev/fsl_soc.c used to create two 'struct
> > device' objects for each cpm_uart device tree node - one
> > "fsl-cpm-scc:uart" in cpm_uart_of_init() and one "fsl-cpm-smc:uart" in
> > cpm_smc_uart_of_init().
>
> This is old code that only exists for non-CONFIG_PPC_CPM_NEW_BINDING
> boards.  As there are none of these remaining in-tree, this code should
> go away soon.

Thank you for information.

I am working with vendor kernel, based on 2.6.18, and that does not have 
CONFIG_PPC_CPM_NEW_BINDING. I thought that fix I made for that kernel 
could be usable for mainline, but if not - nevermind.
