Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl2.internode.on.net (ipmail06.adl2.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:2:6])
 by ozlabs.org (Postfix) with ESMTP id 534ED2C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2013 12:38:04 +1100 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 3/7] IBM Akebono: Add support for a new PHY to the IBM
 emac driver
Date: Wed, 06 Nov 2013 12:38:37 +1100
Message-ID: <9250529.5UedqhaNce@mexican>
In-Reply-To: <CAGVrzcYzBtDcxYXDopOJn_=vW_58SFs9y0uKeGNB9TDPh6J4wg@mail.gmail.com>
References: <1383629471-16979-1-git-send-email-alistair@popple.id.au>
 <81419762.0SyAdYsUqu@mexican>
 <CAGVrzcYzBtDcxYXDopOJn_=vW_58SFs9y0uKeGNB9TDPh6J4wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: netdev <netdev@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 5 Nov 2013 16:16:08 Florian Fainelli wrote:

[snip]

> 2013/11/5 Alistair Popple <alistair@popple.id.au>:
> >> Any reasons why you are duplicating what is available in
> >> drivers/of/of_net.c ::of_get_phy_mode()?
> > 
> > Unless I'm missing something of_get_phy_mode() is going the other way.
> > rgmii_mode_name() is converting PHY_MODE_* into a human-readable string. I
> > couldn't find any obvious kernel method to do this but maybe I missed it?
> 
> Right, rgmii_mode_name() just has informative purposes and should be
> removed, I would suggest using standard device tree bindings property
> (phy-mode) anyway such that you could use of_get_phy_mode() and use
> phy_interface_t types.

Ok, that's what is currently done in the core IBM EMAC driver. As this is used 
just for informative purposes I will remove it. Thanks.

Regards,

Alistair
