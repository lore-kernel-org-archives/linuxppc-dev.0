Return-Path: <SRS0=zNDV=QB=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 22490DDDFB
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2007 20:24:41 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 5/6] ibm_newemac: Cleanup/Fix RGMII MDIO support detection
Date: Thu, 8 Nov 2007 10:24:53 +0100
References: <20071108080732.0C355DDE21@ozlabs.org>
In-Reply-To: <20071108080732.0C355DDE21@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711081024.53336.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 08 November 2007, Benjamin Herrenschmidt wrote:
> More than just "AXON" version of EMAC RGMII supports MDIO, so replace
> the current test with a generic property in the device-tree that
> indicates such support.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Stefan Roese <sr@denx.de>

> Should we set that in Sequoia DTS ?

I suppose yes. 440EPx support MDIO over ZMII and RGMII, but Sequoia uses RGMII 
so we should enable it.

I tested it with your patches and has-mdio set on Sequoia and it works (though 
it also works without this property in the RGMII node).

Thanks.

Best regards,
Stefan
