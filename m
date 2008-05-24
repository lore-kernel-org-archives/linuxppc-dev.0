Return-Path: <david-b@pacbell.net>
Received: from smtp119.sbc.mail.sp1.yahoo.com (smtp119.sbc.mail.sp1.yahoo.com
	[69.147.64.92]) by ozlabs.org (Postfix) with SMTP id C1B87DDF0F
	for <linuxppc-dev@ozlabs.org>; Sun, 25 May 2008 03:45:55 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/4] spi: Add OF binding support for SPI busses
Date: Sat, 24 May 2008 10:45:47 -0700
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<48384D13.6010608@scram.de>
	<fa686aa40805241033x128c30b0v826717cc879a712e@mail.gmail.com>
In-Reply-To: <fa686aa40805241033x128c30b0v826717cc879a712e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200805241045.47448.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net,
	fabrizio.garetto@gmail.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 24 May 2008, Grant Likely wrote:
> > Isn't the same true for drivers/of/gpio.c or drivers/of/of_i2c.c, as well?
> 
> I would argue 'yes!'

... all the more reason to have the SPI glue go there too,
matching the ACPI/PCI precedent as well as those others!
