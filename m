Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4053FDDE3C
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 01:51:09 +1000 (EST)
Date: Tue, 25 Sep 2007 10:43:26 -0500
From: Scott Wood <scottwood@freescale.com>
To: Deepak Gaur <dgaur@cdotd.ernet.in>
Subject: Re: MPC8560 CPM2 SCC(UART) Driver CPM_UART_CONSOLE
Message-ID: <20070925154326.GB16112@ld0162-tx32.am.freescale.net>
References: <20070925104704.M46195@cdotd.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070925104704.M46195@cdotd.ernet.in>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 25, 2007 at 05:33:59PM +0630, Deepak Gaur wrote:
> I am writing a kernel module which is required to parse the characters received from a
> device attached to MPC8560 SCC2 (UART slave mode) on serial interface. This SCC is
> required to be configured for single-buffer, character based operation. Moreover on
> another SCC (SCC1 UART master mode) the board debug interface(console) is connected.
> 
> While trying to figure out CPM UART device driver interface available in file
> drivers/serial/cpm_uart/cpm_uart_core.c for my kernel module I found that some of the
> functions are available when CPM_UART_CONSOLE is enabled. 
> 
> My doubt is regarding status of this flag for my hardware setup. Should this flag be
> enabled or not. If it is required to be enabled for supporting SCC1 then how SCC2 will
> be handled?

That flag should only be set on the actual console.  What is it that you
need to do with the other port that the driver won't currently do?

-Scott
