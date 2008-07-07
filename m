Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 219AFDDED4
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jul 2008 16:00:15 +1000 (EST)
Subject: Re: [PATCH v5] ibm_newemac: Parameterize EMAC Multicast Match Handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200807070758.45828.sr@denx.de>
References: <1215303343-26410-1-git-send-email-gerickson@nuovations.com>
	<1215387012-6464-1-git-send-email-gerickson@nuovations.com>
	<200807070758.45828.sr@denx.de>
Content-Type: text/plain
Date: Mon, 07 Jul 2008 16:00:05 +1000
Message-Id: <1215410405.8970.84.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Grant Erickson <gerickson@nuovations.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-07-07 at 07:58 +0200, Stefan Roese wrote:
> On Monday 07 July 2008, Grant Erickson wrote:
> > Various instances of the EMAC core have varying: 1) number of address
> > match slots, 2) width of the registers for handling address match slots,
> > 3) number of registers for handling address match slots and 4) base
> > offset for those registers.
> 
> <snip>
> 
> > Signed-off-by: Grant Erickson <gerickson@nuovations.com>
> 
> Acked-by: Stefan Roese <sr@denx.de>

Did you have a chance to do a bit of regression testing "just in case" ?

Appart from that, I'll sort out with Jeff which tree this will go
through.

Cheers,
Ben.
