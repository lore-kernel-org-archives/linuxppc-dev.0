Return-Path: <jens@de.ibm.com>
From: Jens Osterkamp <jens@de.ibm.com>
To: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: spidernet: add improved phy support in sungem_phy.c
Date: Thu, 1 Feb 2007 11:54:49 +0100
References: <200701261407.48237.jens@de.ibm.com>
	<200701262331.58491.jens@de.ibm.com>
	<20070126233809.GA16660@electric-eye.fr.zoreil.com>
In-Reply-To: <20070126233809.GA16660@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702011154.49558.jens@de.ibm.com>
Cc: jgarzik@pobox.com, James K Lewis <jim@jklewis.com>, linuxppc-dev@ozlabs.org,
	netdev@vger.kernel.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Francois,

thank you for your comments. I'll send a revised patch soon.

> +#define BCM5421_MODE_MASK	1 << 5
> 
> Please add parenthesis.

Done.

> "&" is fine despite the lack of parenthesis above but it is error-prone.

Corrected.

> 
> +
> +	if ( mode == GMII_COPPER) {
>            ^^^
> +		return genmii_poll_link(phy);
> +	}
> 
> No curly-braces for single line statements please.

I corrected this on all my additions.

> Ternary operator ?

I dont like ternary operators. Yes, I know, they are cool, but
they make the code much less readable IMHO.

> +#define BCM5461_FIBER_LINK	1 << 2
> +#define BCM5461_MODE_MASK	3 << 1
> 
> Please add parenthesis.

Done.

> Join the dark side and use a ternary operator.

See above.

> +static int bcm5461_enable_fiber(struct mii_phy* phy, int autoneg)
> +{
> +	/*
> +	phy_write(phy, MII_NCONFIG, 0xfc0c);
> +	phy_write(phy, MII_BMCR, 0x4140);
> +	*/
> 
> Remove ?

Done.

Jens
