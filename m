Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B3A81DDF51
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 08:42:53 +1100 (EST)
Subject: Re: [PATCH] net: NEWEMAC: Support for Pause packets in EMAC driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <47DE5F43.80604@garzik.org>
References: <1205488348-22536-1-git-send-email-sr@denx.de>
	<47DE5F43.80604@garzik.org>
Content-Type: text/plain
Date: Tue, 18 Mar 2008 08:25:01 +1100
Message-Id: <1205789101.26869.181.camel@pasglop>
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


> > 
> > Signed-off-by: Pravin M. Bathija <pbathija@amcc.com>
> > Signed-off-by: Stefan Roese <sr@denx.de>
> > ---
> >  drivers/net/ibm_newemac/core.c |    7 +++++++
> >  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> applied

Thanks. There's also a couple of patches from Valentine that should go
in. I'll ask him to resend to you.

Cheers,
Ben.
