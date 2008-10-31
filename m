Return-Path: <Sergej.Stepanov@ids.de>
Received: from ares.ids.de (ares.ids.de [213.144.29.131])
	by ozlabs.org (Postfix) with SMTP id 93E12DDE0D
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Nov 2008 00:19:05 +1100 (EST)
From: "Stepanov, Sergej" <Sergej.Stepanov@ids.de>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Fri, 31 Oct 2008 13:49:31 +0100
Subject: mmc_spi with GPIO_MODE_3
Message-ID: <4206182445660643B9AEB8D4E55BBD0A17724C7E@HERMES2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Anton,

could you say me please, would the mmc_spi-driver function with GPIO_MODE_3=
?

I have seen in mmc_spi_probe() this spi->mode =3D SPI_MODE_0.
What should come back if i have CI and CP other then in SPI_MODE_0?

Thank you for any advice.
Sergej.
