Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AAD3BDE314
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 05:23:54 +1100 (EST)
Message-ID: <472776AE.2060009@freescale.com>
Date: Tue, 30 Oct 2007 13:23:42 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Sergej Stepanov <Sergej.Stepanov@ids.de>
Subject: Re: [PATCH v2] using mii-bitbang on different processor ports
References: <1193767812.6244.46.camel@p60635-ste.ids.de>
In-Reply-To: <1193767812.6244.46.camel@p60635-ste.ids.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sergej Stepanov wrote:
> +	if( !of_address_to_resource(np, 1, &res[1])) {

The spacing is still wrong.

> -	iounmap(bitbang->dir);
> +	if ( bitbang->mdio.dir != bitbang->mdc.dir)
> +		iounmap(bitbang->mdio.dir);
> +	iounmap(bitbang->mdc.dir);

And here.

-Scott
