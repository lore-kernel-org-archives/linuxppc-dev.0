Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 92FB3474C1
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Nov 2008 05:55:31 +1100 (EST)
Date: Thu, 6 Nov 2008 12:54:33 -0600
From: Scott Wood <scottwood@freescale.com>
To: Nate Case <ncase@xes-inc.com>
Subject: Re: Passing I2C platform_data from device tree to i2c driver
Message-ID: <20081106185433.GA26616@loki.buserror.net>
References: <1225756486.27415.258.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1225756486.27415.258.camel@localhost.localdomain>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 03, 2008 at 05:54:46PM -0600, Nate Case wrote:
> Of course, I could put some code in my board specific file to parse the
> device tree properties and set pdata accordingly, but this hardly seems
> ideal.  After all, the device tree bindings -> pdata translation itself
> does not have to be board-specific.
> 
> Basically, I think we need to have some common code somewhere that does
> the task of populating platform_data for a specific I2C chip based on a
> device tree node -- similarly to how we register the I2C devices
> already.  Is anyone working on this?  Did anyone have anything else in
> mind?

It should be fairly straightforward to add an optional function pointer to
the i2c device table that turns the device tree properties into platform
data.

-Scott
