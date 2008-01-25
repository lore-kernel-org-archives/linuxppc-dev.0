Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A31CDDE13A
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 03:08:47 +1100 (EST)
Date: Fri, 25 Jan 2008 10:08:20 -0600
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] [POWERPC] 85xx: Port STX GP3 board over from arch/ppc
Message-ID: <20080125160820.GA7750@ld0162-tx32.am.freescale.net>
References: <Pine.LNX.4.64.0801242245390.22024@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0801242245390.22024@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 24, 2008 at 10:47:21PM -0600, Kumar Gala wrote:
> +	soc8560@fdf00000 {

soc@fdf00000

-Scott
> +		cpm@919c0 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "fsl,mpc8560-cpm", "fsl,cpm2";

This is also a simple-bus.

> +static struct of_device_id __initdata of_bus_ids[] = {
> +	{ .name = "soc", },
> +	{ .type = "soc", },
> +	{ .name = "cpm", },
> +	{ .name = "localbus", },
> +	{ .compatible = "simple-bus", },
> +	{},
> +};

You should be able to get rid of the others besides simple-bus (there may
have been some confusion in what you asked over IRC yesterday -- I
thought you were talking about compatible in the device tree, not here).

-Scott
