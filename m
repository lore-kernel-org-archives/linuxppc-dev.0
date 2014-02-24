Return-Path: <alistair@popple.id.au>
Received: from ipmail04.adl6.internode.on.net (ipmail04.adl6.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:6:4])
 by ozlabs.org (Postfix) with ESMTP id 301412C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Feb 2014 13:09:22 +1100 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/7] IBM Akebono: Add support for a new PHY interface to
 the IBM emac driver
Date: Mon, 24 Feb 2014 13:09:19 +1100
Message-ID: <7545458.ltLKFumBkZ@mexican>
In-Reply-To: <20140221111823.GA8783@e106331-lin.cambridge.arm.com>
References: <1392964293-13687-1-git-send-email-alistair@popple.id.au>
 <1392964293-13687-3-git-send-email-alistair@popple.id.au>
 <20140221111823.GA8783@e106331-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 21 Feb 2014 11:18:23 Mark Rutland wrote:
> On Fri, Feb 21, 2014 at 06:31:28AM +0000, Alistair Popple wrote:

[...]

> 
> > +       /* Check for RGMII flags */
> > +       if (of_get_property(ofdev->dev.of_node, "has-mdio", NULL))
> > +               dev->flags |= EMAC_RGMII_FLAG_HAS_MDIO;
> 
> You can use of_property_read_bool here.

Thanks. I will update it.

Regards,

Alistair

> 
> Cheers,
> Mark.
