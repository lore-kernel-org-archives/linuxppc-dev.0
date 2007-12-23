Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B8E3DDDE0C
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Dec 2007 14:28:32 +1100 (EST)
Message-ID: <476DD5DF.5020806@freescale.com>
Date: Sat, 22 Dec 2007 21:28:31 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] [POWERPC] MPC8360E-RDK: Device tree and board file
References: <20071221202309.GA4557@localhost.localdomain>
In-Reply-To: <20071221202309.GA4557@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:

> +	qe@e0100000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "fsl,qe";
> +		ranges = <0 0xe0100000 0x00100000>;
> +		reg = <0xe0100000 0x480>;
> +		/* filled by u-boot */
> +		brg-frequency = <0>;

You need "bus-frequency" here too
