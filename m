Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E1762DDE0D
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2007 08:10:34 +1000 (EST)
In-Reply-To: <20070726135738.GB5643@localhost.localdomain>
References: <20070726135738.GB5643@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <692e6dabbfb62dc6d6ace3ea7552ef68@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC][PATCH] MPC832x_RDB: update dts to use spi,
	register mmc_spi stub
Date: Wed, 1 Aug 2007 00:10:28 +0200
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +			spi1pio:spi_pin@01 {

There should be whitespace after the label.  @01 should be
spelled @1.  Except there is no "reg" property.  What is this
stuff, anyway?

> +				pio-map = <
> +			/* port  pin  dir  open_drain  assignment  has_irq    */
> +					3  0  3  0  1  0	/* SPI1 MOSI, I/O */
> +					3  1  3  0  1  0	/* SPI1 MISO, I/O */
> +					3  2  3  0  1  0	/* SPI1 CLK,  I/O */
> +					3  3  2  0  1  0>;	/* SPI1 SEL,  I   */
> +			};


Segher
