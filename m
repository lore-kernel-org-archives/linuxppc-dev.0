Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6BE8DDDE18
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 21:22:37 +1100 (EST)
Subject: RE: [PATCH] Add irq host and hwirq pair fields to
	outputwhenshowing interrupts.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zhang Wei-r63237 <Wei.Zhang@freescale.com>
In-Reply-To: <46B96294322F7D458F9648B60E15112C1320F5@zch01exm26.fsl.freescale.net>
References: <1173755968459-git-send-email-wei.zhang@freescale.com>
	<1173770092.24454.69.camel@localhost.localdomain>
	<46B96294322F7D458F9648B60E15112C131E7F@zch01exm26.fsl.freescale.net>
	<1173793926.24454.74.camel@localhost.localdomain>
	<46B96294322F7D458F9648B60E15112C1320F5@zch01exm26.fsl.freescale.net>
Content-Type: text/plain
Date: Thu, 15 Mar 2007 11:22:22 +0100
Message-Id: <1173954142.6861.16.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Wang Haiying-r54964 <Haiying.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > Yes, at least for now. Maybe if we can convince ourselves that nothing
> > significant would break of changing /proc/interrupts, then we can add
> > stuffs to it, but I'd rather avoid.
> > 
> 
> Hi, Ben, 
> 
> How about set the host name when calling irq_alloc_host?
> In the mpic, the host name can be the mpic->name, is it ok?

For MPIC it should probably be the OF full path
