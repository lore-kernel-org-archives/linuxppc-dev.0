Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id B067ADDF0D
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 May 2007 04:17:18 +1000 (EST)
Date: Wed, 2 May 2007 19:36:29 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Asier Llano Palacios <a.llano@usyscom.com>
Subject: Re: mpc5200 and spi bus
Message-ID: <20070502173629.GA5797@pengutronix.de>
References: <1177595421.9950.4.camel@a.llano.llano> <4630BBF9.7000305@aotek.es>
	<1177670193.9950.9.camel@a.llano.llano> <4631EF88.3060808@aotek.es>
	<1178092964.25579.7.camel@a.llano.llano>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1178092964.25579.7.camel@a.llano.llano>
Cc: Txema Lopez <tlopez@aotek.es>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

On Wed, May 02, 2007 at 10:02:44AM +0200, Asier Llano Palacios wrote:
> > 
> 
> I'll have a look. If don't see anything the code from 2.4.x is good
> starting point to port it.

There was a patch for the PSC in SPI mode for 2.6 posted here:

http://sourceforge.net/mailarchive/forum.php?thread_name=45DD9ABF.9010009%40toptica.com&forum_name=spi-devel-general

I can forward you the patch if you like, because the sourceforge server
only replies with "Insufficient parameters" when I click on the patch
link :(

I myself wrote a driver for the dedicated SPI port which I can post on
spi-devel-general tomorrow (after I looked over it again).

Best regards,
  Sascha
