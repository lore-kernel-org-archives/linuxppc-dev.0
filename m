Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E88B7DDFD2
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 21:07:20 +1000 (EST)
Subject: RE: [PATCH 2/5] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zhang Wei-r63237 <Wei.Zhang@freescale.com>
In-Reply-To: <46B96294322F7D458F9648B60E15112C3075B9@zch01exm26.fsl.freescale.net>
References: <11798051102658-git-send-email-wei.zhang@freescale.com>
	<11798051101543-git-send-email-wei.zhang@freescale.com>
	<1179805110272-git-send-email-wei.zhang@freescale.com>
	<17B6534B-3C1C-433D-8875-1C2255E79D98@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C3075B9@zch01exm26.fsl.freescale.net>
Content-Type: text/plain
Date: Wed, 30 May 2007 21:07:05 +1000
Message-Id: <1180523226.19517.241.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-05-30 at 18:02 +0800, Zhang Wei-r63237 wrote:
> Hi, 
> 
> > > +			uli1575: uli1575@100 {
> > 
> > is this the right address?
> 
> '@100' of here, I make up  the address by get from bus 1, device 0,
> function 0.
> Such as below '@200' means bus 2, device 0, function0.

It's PCI ? The unit address is well defined then, check the PCI bindings
to OF

Ben.
