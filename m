Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AC4ACDDDEC
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jul 2008 00:54:32 +1000 (EST)
Date: Sun, 6 Jul 2008 18:54:05 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: patches for 2.6.27...
Message-ID: <20080706185405.79edc612@vitb-lp>
In-Reply-To: <200807021036.46603.laurentp@cse-semaphore.com>
References: <068935A1-11BE-4AEB-9C0E-E1AB53F1618E@kernel.crashing.org>
	<200807021036.46603.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

В Wed, 2 Jul 2008 10:36:43 +0200
Laurent Pinchart <laurentp@cse-semaphore.com> пишет:

> Hi Kumar,
> 
> On Wednesday 02 July 2008, Kumar Gala wrote:
> > Please point out any patches that have been posted but havent made
> > it into a git tree related to Freescale chips.
> > 
> > I know there are probably a slew of CPM patches that need to get
> > into the tree.
> 
> Here are 5 patches that I'd like to see in 2.6.27. They haven't made
> into any git tree as far as I know.
> 
> [PATCHv2] fs_enet: restore promiscuous and multicast settings in
> restart()
> http://patchwork.ozlabs.org/linuxppc/patch?person=968&id=19228 [PATCH
> 2/2] fs_enet: MDIO on GPIO support

This has been merged per email from Jeff.

> http://patchwork.ozlabs.org/linuxppc/patch?person=968&id=18693
> [PATCHv3 1/2] [POWERPC] CPM2: Implement GPIO LIB API on CPM2
> Freescale SoC.

> http://patchwork.ozlabs.org/linuxppc/patch?person=968&id=19045
> [PATCH] powerpc: Modem control lines support for the cpm_uart driver
> http://patchwork.ozlabs.org/linuxppc/patch?person=968&id=17928

Seems to be missing and I'd second adding this and will add my ACK if
it will help getting those upstream.

> [PATCH] cpm_uart: Support uart_wait_until_sent()
> http://patchwork.ozlabs.org/linuxppc/patch?person=968&id=19233
> 
This seems to be applied to Kumar's tree per email from him.
