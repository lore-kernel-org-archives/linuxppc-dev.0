Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A1FBBDE3FA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Jul 2008 05:59:16 +1000 (EST)
Message-ID: <488E2510.7070209@freescale.com>
Date: Mon, 28 Jul 2008 14:59:12 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: matvejchikov@gmail.com
Subject: Re: No output from SMC1 console with the 2.6.26 kernel (PQ2FADS based
	board)
References: <8496f91a0807281243y2193dad5hc758444fe0a10258@mail.gmail.com>
In-Reply-To: <8496f91a0807281243y2193dad5hc758444fe0a10258@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Matvejchikov Ilya wrote:
> 		cpm@119c0 {
> 			#address-cells = <1>;
> 			#size-cells = <1>;
> 			#interrupt-cells = <2>;
> 			compatible = "fsl,mpc8280-cpm", "fsl,cpm2";

Add "simple-bus" to this compatible list.

Other than that, and that you should be using dts-v1, the tree looks 
fine.  If adding "simple-bus" doesn't fix it, check your pin setup; 
pq2fads doesn't have an SMC serial port, so its platform file doesn't 
set up those pins.

-Scott
