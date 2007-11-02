Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 532B7DDE07
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Nov 2007 02:54:26 +1100 (EST)
Date: Fri, 2 Nov 2007 11:03:04 -0500
From: Olof Johansson <olof@lixom.net>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] net: Add 405EX support to new EMAC driver
Message-ID: <20071102160304.GA5277@lixom.net>
References: <200711020814.43524.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200711020814.43524.sr@denx.de>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 02, 2007 at 08:14:43AM +0100, Stefan Roese wrote:
> This patch adds support for the 405EX to the new EMAC driver. Some as on
> AXON, the 405EX handles the MDIO via the RGMII bridge.

Hi,

This isn't feedback on your patch as much as on "new-emac" in general:

Isn't this the case where there should really be device tree properties
instead? If you had an "ibm,emac-has-axon-stacr" property in the device
node, then you don't have to modify the driver for every new board out
there. Same for the other device properties, of course.

I thought this was what having the device tree was all about. :(


-Olof
