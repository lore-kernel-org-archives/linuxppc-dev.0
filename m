Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EF042DDE23
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Jun 2007 09:51:05 +1000 (EST)
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1180720112.14219.62.camel@ld0161-tx32>
References: <1180720112.14219.62.camel@ld0161-tx32>
Content-Type: text/plain
Date: Sun, 03 Jun 2007 09:50:53 +1000
Message-Id: <1180828253.14025.22.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Minor nits (in addition to needing a "reg" property)

> +
> +						i8259: i8259@4d0 {

Name should probably be "interrupt-controller" as well to follow the
recommended naming practice.

> +							clock-frequency = <0>;
> +							interrupt-controller;
> +							device_type = "interrupt-controller";
> +							#address-cells = <0>;
> +							#interrupt-cells = <2>;
> +							built-in;
> +							compatible = "chrp,iic";
> +							big-endian;

big-endian ? On a 8259 ? 

> +							interrupts = <49 2>;
> +							interrupt-parent =
> +								<&mpic>;
> +						};
> +					};
> +				};
>  			};
>  
>  		};
