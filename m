Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C62D6DDF6C
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 11:07:37 +1100 (EST)
Subject: Re: [PATCH] net: NEWEMAC: Support for Pause packets in EMAC driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <47DEF159.3020504@garzik.org>
References: <1205488348-22536-1-git-send-email-sr@denx.de>
	<47DE5F43.80604@garzik.org> <1205789101.26869.181.camel@pasglop>
	<1205789205.26869.184.camel@pasglop>
	<20080317164341.12075616@zod.rchland.ibm.com>
	<1205790747.26869.187.camel@pasglop>  <47DEF159.3020504@garzik.org>
Content-Type: text/plain
Date: Tue, 18 Mar 2008 10:55:32 +1100
Message-Id: <1205798132.26869.191.camel@pasglop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, Stefan Roese <sr@denx.de>, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-03-17 at 18:31 -0400, Jeff Garzik wrote:
> > Jeff, do you mind if we get those patches through the powerpc tree ?
> > EMAC is very powerpc specific and these are mostly internal driver
> > cuisine.
> 
> Fine with me in concept, though I haven't seen the patches in
> question.

Yup, I've asked people to copy you on them so you get a chance to ack
them :-)

Cheers,
Ben.
