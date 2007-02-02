Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BBFC5DDE44
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Feb 2007 17:50:45 +1100 (EST)
In-Reply-To: <1170118707.26655.299.camel@localhost.localdomain>
References: <1170118707.26655.299.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <70A55501-3409-460B-8EBA-B880F3EA9A5F@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: EMAC device-tree binding (#2)
Date: Fri, 2 Feb 2007 07:50:35 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>  - phy-mode          : 1 cell, Mode of operations of the PHY  
> interface:
>                          #define PHY_MODE_NA    0
>                          #define PHY_MODE_MII   1
>                          #define PHY_MODE_RMII  2
>                          #define PHY_MODE_SMII  3
>                          #define PHY_MODE_RGMII 4
>                          #define PHY_MODE_TBI   5
>                          #define PHY_MODE_GMII  6
>                          #define PHY_MODE_RTBI  7
>                          #define PHY_MODE_SGMII 8
>                        For axon, it is PHY_MODE_RGMII

Just use a string here...  phy-mode = "rgmii" etc.

> * In the McMAL node
>
>  - name               : "mcmal"
>  - device_type        : "mcmal-dma"

"dma-controller" instead?

>  - device_type        : "emac-zmii"

Similar.


Segher
