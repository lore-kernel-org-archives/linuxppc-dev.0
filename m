Return-Path: <tosettofabio83@libero.it>
Received: from polito.it (unknown [130.192.3.44])
	by ozlabs.org (Postfix) with ESMTP id B9488DDF18
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 15:54:47 +1000 (EST)
Message-ID: <4844DC96.6060807@libero.it>
Date: Tue, 03 Jun 2008 07:54:30 +0200
From: Fabio Tosetto <tosettofabio83@libero.it>
MIME-Version: 1.0
To: Andre Schwarz <andre.schwarz@matrix-vision.de>
Subject: Re: slow MMC over SPI
References: <4843AD1C.4010901@matrix-vision.de>
In-Reply-To: <4843AD1C.4010901@matrix-vision.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I am trying to enable the SD over SPI on a emebedded system with one
processor powerpc mpc5200b; you have enabled mmc over spi into a native 
spi or psc spi?

regards,
Fabio

Andre Schwarz ha scritto:
> All,
>
> has anybody made some investigations about performance of a SD/MMC card
> on SPI ?
>
> Actually I'm using various cards (different speed classes) on an SPI bus
> of a MPC8343 cpu.
> Everything is working fine basically, i.e. card is detected properly and
> block device can be mounted and used.
>
> SPI clock is adjusted to the card's capabilities and is running quite
> fast (>30MHz).
>
> But between consecutive reads/writes there's a fixed gap of 2us thus
> yielding a poor performance of approx. 300KBytes/sec.
> The spi bus is utilized only ~10%.
>
> Any ideas where this comes from ?
> Ist it a fixed delay regarding to some kind of spec or is it possibly a
> spi driver/mmc layer issue ?
>
>
> regards,
> Andre Schwarz
>
> MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
> Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> .
>
>   
