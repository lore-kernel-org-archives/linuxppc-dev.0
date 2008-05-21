Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id E7A43DE29F
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 01:54:05 +1000 (EST)
Date: Wed, 21 May 2008 17:54:20 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [RFC/DRAFT] SPI OF bindings, MMC-over-SPI, chip-selects and so on
In-Reply-To: <20080521154103.GA32577@polina.dev.rtsoft.ru>
Message-ID: <Pine.LNX.4.64.0805211751160.5386@axis700.grange>
References: <20080521154103.GA32577@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Gary Jennejohn <garyj@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 21 May 2008, Anton Vorontsov wrote:

> This is just a bait for further discussion of OF/SPI, chip-selects,
> e.t.c.
> 
> I've converted the spi_mpc83xx to the OF driver (using Grant's
> SPI_MASTER_OF work + some additions), and implemented MMC-over-SPI
> bindings. This stuff extensively using GPIOs, and I think this will
> work for the "bridged SPI" too, since the SPI bridge could be
> represented as GPIO controller (inside the SPI controller node).

Yes, but do you really _want_ to represent them as GPIOs? Firstly they are 
not really "G" P, secondly, they are not even "I", rather only "O". And do 
you really want to register your SPI CS lines to the whole system for 
everyone's (ab)use?...

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
