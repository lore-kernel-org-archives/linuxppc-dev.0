Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4CE41DE077
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 00:11:00 +1100 (EST)
Subject: Re: [PATCH] ibm_newemac: Add support for 460EX/GT-type MAL
	rx-channel handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200804031435.39999.sr@denx.de>
References: <1207223110-27281-1-git-send-email-sr@denx.de>
	<1207225740.10388.321.camel@pasglop>  <200804031435.39999.sr@denx.de>
Content-Type: text/plain
Date: Fri, 04 Apr 2008 00:10:20 +1100
Message-Id: <1207228220.10388.323.camel@pasglop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-04-03 at 14:35 +0200, Stefan Roese wrote:
> On Thursday 03 April 2008, Benjamin Herrenschmidt wrote:
> > On Thu, 2008-04-03 at 13:45 +0200, Stefan Roese wrote:
> > > On some 4xx PPC's (e.g. 460EX/GT), the rx channel number is a multiple
> > > of 8 (e.g. 8 for EMAC1, 16 for EMAC2), but enabling in MAL_RXCASR needs
> > > the divided by 8 value for the bitmask.
> >
> > Sounds ok, but I wonder if we ever have a MAL with more than 8 chans, do
> > we need to make this shift conditional to some device tree prop ?
> 
> I suggest we postpone such a conditional setup until we see such a MAL. OK?

Agreed. I got a bit carried away..

Ben.
