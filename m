Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2E8D7DE256
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 04:00:00 +1100 (EST)
Date: Wed, 12 Dec 2007 10:59:54 -0600
From: Scott Wood <scottwood@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH RFC 7/7] [POWERPC] MPC8360E-RDK: add support for NAND
	on UPM
Message-ID: <20071212165954.GE4329@loki.buserror.net>
References: <20071210204705.GA31263@localhost.localdomain>
	<20071210204951.GG32278@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071210204951.GG32278@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 10, 2007 at 11:49:51PM +0300, Anton Vorontsov wrote:
> +	localbus@e0005000 {
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		compatible = "fsl,mpc8360erdk-localbus",
> +			     "fsl,mpc8360e-localbus",
> +			     "fsl,pq2pro-localbus";

The board name shouldn't be in there.

> +		reg = <0xe0005000 0xd8>;
> +		ranges = <1 0 0x60000000 1>;
> +
> +		nand-flash@1,0 {
> +			compatible = "STMicro,NAND512W3A2BN6E", "fsl,upm-nand";

Technically, if the vendor part begins with a capital letter it's supposed
to be either a stock symbol or an OUI.

-Scott
