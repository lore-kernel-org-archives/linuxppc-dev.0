Return-Path: <SRS0=RRnR=P2=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id BBA30DDDFE
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Nov 2007 08:31:31 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] net: Add 405EX support to new EMAC driver
Date: Thu, 1 Nov 2007 22:31:11 +0100
References: <200711011554.04935.sr@denx.de> <1193949421.6541.10.camel@pasglop>
	<20071101160709.7e7c0181@weaponx.rchland.ibm.com>
In-Reply-To: <20071101160709.7e7c0181@weaponx.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711012231.11385.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 01 November 2007, Josh Boyer wrote:
> > > -	if (dev->type != RGMII_AXON)
> > > -		return;
> > > -
> > >  	mutex_lock(&dev->lock);
> >
> > That will break 440GX boards that need to use the RGMII for data and the
> > ZMII for MDIO.
> >
> > You may want to change the name RGMII_AXON something like RGMII_HAS_MDIO
> > instead and set that for 405EX as well instead.
>
> And perhaps adding a comment about that since the meaning of that code
> isn't very obvious. That way people that aren't the original author
> of the driver don't get confused again.

Will do. I'll send a fixed version tomorrow.

Best regards,
Stefan
