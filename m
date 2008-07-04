Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id 6AF13DDE03
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 14:06:24 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id n7so664541wag.13
	for <linuxppc-dev@ozlabs.org>; Thu, 03 Jul 2008 21:06:23 -0700 (PDT)
Date: Thu, 3 Jul 2008 22:05:50 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Chen Gong <G.Chen@freescale.com>
Subject: Re: [PATCH v2 3/5] of-bindings: Add binding documentation for SPI
	bussesand devices
Message-ID: <20080704040550.GG12945@secretlab.ca>
References: <20080703005749.26187.71719.stgit@trillian.secretlab.ca>
	<20080703010308.26187.23037.stgit@trillian.secretlab.ca>
	<58A20A281BAF1047B4EAE68DE5C0BDC2010121B9@zch01exm21.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <58A20A281BAF1047B4EAE68DE5C0BDC2010121B9@zch01exm21.fsl.freescale.net>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: david-b@pacbell.net, linuxppc-dev@ozlabs.org, fabrizio.garetto@gmail.com,
	linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 04, 2008 at 11:59:07AM +0800, Chen Gong wrote:
> > +    - reg             - (required) chip select address of device.
> > +    - compatible      - (required) name of SPI device 
> > following generic names
> > +			recommended practice
> > +    - max-speed       - (required) Maximum SPI clocking 
> > speed of device in Hz
> > +    - spi,cpol        - (optional) Device requires inverse 
> > clock polarity
> > +    - spi,cpha        - (optional) Device requires shifted 
> > clock phase
> > +    - linux,modalias  - (optional, Linux specific) Force 
> > binding of SPI device
> > +			to a particular spi_device driver.  
> > Useful for changing
> > +			driver binding between spidev and a 
> > kernel SPI driver.
> > +
> 
> How about adding a "model" property to describe actual devie type.
> Such as using a "sst25vf040b" device with spi-interface, we can
> use model="sst25vf040b" to describe it.

That's what "compatible" is for.  First value in the compatible list is
the actual device, followed by devices it is compatible with.  In
your particular example, the value would be "sst,sst25vf040b" so that it
follows device tree conventions.

g.
