Return-Path: <khali@linux-fr.org>
Received: from kellthuzad.dmz.nerim.net (smtp-dmz-233-wednesday.dmz.nerim.net
	[195.5.254.233]) by ozlabs.org (Postfix) with ESMTP id C7F0EDDED0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Oct 2007 07:18:25 +1000 (EST)
Received: from kraid.nerim.net (smtp-103-wednesday.nerim.net [62.4.16.103])
	by kellthuzad.dmz.nerim.net (Postfix) with ESMTP id 1303725BBA
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Oct 2007 23:00:23 +0200 (CEST)
Date: Wed, 17 Oct 2007 23:00:27 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [i2c] [PATCH take2] [POWERPC] i2c: adds support for i2c bus on 8xx
Message-ID: <20071017230027.334a5f48@hyperion.delvare>
In-Reply-To: <47166085.1010608@scram.de>
References: <47134A94.60606@scram.de> <20071015183107.GA4361@loki.buserror.net>
	<47166085.1010608@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org, linux-kernel@vger.kernel.org,
	i2c@lm-sensors.org, Carsten Juttner <carjay@gmx.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 17 Oct 2007 21:20:37 +0200, Jochen Friedrich wrote:
> >> +	/* Select an arbitrary address.  Just make sure it is unique.
> >> +	 */
> >> +	out_8(&i2c->i2c_i2add, 0xfe);
> >>     
> >
> > It's a 7-bit address...  and are you sure that 0x7e is unique?  Does this
> > driver even support slave operation?
> >   
> 
> It's in fact 0x7F << 1. The same value is used in the 2.4 driver and
> in u-boot, as well. Slave operation is not supported.

I'm not sure what exactly you are doing here, but 0x7f isn't a valid
7-bit I2C address.

-- 
Jean Delvare
