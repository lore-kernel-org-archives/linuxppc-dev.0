Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A066ADDDF7
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 18:28:23 +1100 (EST)
Subject: Re: [PATCH 8/8] ibm_newemac: Skip EMACs that are marked unused by
	the firmware
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200711210813.51525.sr@denx.de>
References: <20071121060737.6AA72DDE0C@ozlabs.org>
	<200711210813.51525.sr@denx.de>
Content-Type: text/plain
Date: Wed, 21 Nov 2007 18:28:09 +1100
Message-Id: <1195630089.6970.62.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com, netdev@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2007-11-21 at 08:13 +0100, Stefan Roese wrote:
> On Wednesday 21 November 2007, Benjamin Herrenschmidt wrote:
> > From: Hugh Blemings <hugh@blemings.org>
> >
> > Depending on how the 44x processors are wired, some EMAC cells
> > might not be useable (and not connected to a PHY). However, some
> > device-trees may choose to still expose them (since their registers
> > are present in the MMIO space) but with an "unused" property in them.
> >
> > Signed-off-by: Hugh Blemings <hugh@blemings.org>
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Acked-by: Stefan Roese <sr@denx.de>

I noticed that I forgot to add your Ack's to the patches. I'll do so
before I ask Paul to pull them.

Thanks !

Ben.
