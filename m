Return-Path: <dgibson@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 752C3DE088
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 11:45:30 +1000 (EST)
Date: Wed, 22 Apr 2009 11:32:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc/85xx: Add P2020DS board support
Message-ID: <20090422013206.GB12003@yookeroo.seuss>
References: <1240348762-13581-1-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1240348762-13581-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 21, 2009 at 04:19:22PM -0500, Kumar Gala wrote:
> The P2020 is a dual e500v2 core based SOC with:
> * 3 PCIe controllers
> * 2 General purpose DMA controllers
> * 2 sRIO controllers
> * 3 eTSECS
> * USB 2.0
> * SDHC
> * SPI, I2C, DUART
> * enhanced localbus
> * and optional Security (P2020E) security w/XOR acceleration
> 
> The p2020 DS reference board is pretty similar to the existing MPC85xx
> DS boards and has a ULI 1575 connected on one of the PCIe
> controllers.

[snip]
> +	soc@ffe00000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		device_type = "soc";
> +		compatible = "simple-bus";

If I understood the description correctly, this one doesn't have the
excuse of being a copy of an already broken device tree.  There needs
to be a soc-variant specific string in the compatible property here.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
