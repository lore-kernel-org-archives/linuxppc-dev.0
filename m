Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 79F4D2C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2013 13:17:39 +1100 (EST)
Message-ID: <1383704240.4776.115.camel@pasglop>
Subject: Re: [PATCH 3/7] IBM Akebono: Add support for a new PHY to the IBM
 emac driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alistair Popple <alistair@popple.id.au>
Date: Wed, 06 Nov 2013 13:17:20 +1100
In-Reply-To: <9250529.5UedqhaNce@mexican>
References: <1383629471-16979-1-git-send-email-alistair@popple.id.au>
 <81419762.0SyAdYsUqu@mexican>
 <CAGVrzcYzBtDcxYXDopOJn_=vW_58SFs9y0uKeGNB9TDPh6J4wg@mail.gmail.com>
 <9250529.5UedqhaNce@mexican>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: netdev <netdev@vger.kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
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

On Wed, 2013-11-06 at 12:38 +1100, Alistair Popple wrote:
> > Right, rgmii_mode_name() just has informative purposes and should be
> > removed, I would suggest using standard device tree bindings
> property
> > (phy-mode) anyway such that you could use of_get_phy_mode() and use
> > phy_interface_t types.
> 
> Ok, that's what is currently done in the core IBM EMAC driver. As this
> is used 
> just for informative purposes I will remove it. Thanks.

Why ? Information is useful...

Ben.
