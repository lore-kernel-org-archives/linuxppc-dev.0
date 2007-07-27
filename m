Return-Path: <david-b@pacbell.net>
Received: from smtp101.sbc.mail.mud.yahoo.com (smtp101.sbc.mail.mud.yahoo.com
	[68.142.198.200]) by ozlabs.org (Postfix) with SMTP id 7ACDFDDE0A
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 13:15:03 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: spi-devel-general@lists.sourceforge.net
Subject: Re: [spi-devel-general] [PATCH 2/3] [SPI] Add new mode: SPI_LOOP
Date: Thu, 26 Jul 2007 20:07:07 -0700
References: <20070726134754.GA3539@localhost.localdomain>
	<20070726135051.GB5550@localhost.localdomain>
In-Reply-To: <20070726135051.GB5550@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200707262007.07537.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org, Stephen Street <stephen@streetfiresound.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 26 July 2007, Anton Vorontsov wrote:
> Loopback mode is supported by various controllers, this mode
> is useful for testing, especially in conjunction with spidev
> driver.

ISTR that Stephen Street provided a loopback mode for debug
in his pxa2xx_spi code.  And I know you're fight that this
mode shows up in a lot of hardware.

Comments, anyone?  This seems like a fair way to expose this
mechanism.  And I tend to agree that it'd mostly be useful in
conjunction with "spidev".

Anton -- assuming this goes in, it'd be nice if you could
contribute a simple test program using this, which we could
keep in Documentation/spi somewhere.  (Maybe with other testing
notes, if anyone comes up with such.)

- Dave


>	...
>
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -77,6 +77,7 @@ struct spi_device {
>  #define	SPI_CS_HIGH	0x04			/* chipselect active high? */
>  #define	SPI_LSB_FIRST	0x08			/* per-word bits-on-wire */
>  #define	SPI_3WIRE	0x10			/* SI/SO signals shared */
> +#define	SPI_LOOP	0x20			/* loopback mode */
>  	u8			bits_per_word;
>  	int			irq;
>  	void			*controller_state;
