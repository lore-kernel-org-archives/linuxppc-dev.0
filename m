Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [208.106.21.240])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 32DBBDDE17
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2007 04:55:37 +1000 (EST)
Date: Sun, 16 Sep 2007 11:55:35 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] i2c: devtree-aware iic support for PPC4xx
Message-ID: <20070916185535.GB32314@gate.ebshome.net>
References: <200709151108.01849.sr@denx.de>
	<20070915100434.GA4978@gate.ebshome.net>
	<20070915152921.36ccbec7@localhost.localdomain>
	<200709161107.23309.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200709161107.23309.sr@denx.de>
Cc: Jean Delvare <khali@linux-fr.org>, i2c@lm-sensors.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Sep 16, 2007 at 11:07:23AM +0200, Stefan Roese wrote:
> On Saturday 15 September 2007, Vitaly Bordug wrote:
> > > Where is dev->clkdiv initialized?
> > >
> > > My original version used iic_clkdiv() to calculate correct devider
> > > based on OPB frequency. Did you even test this code?
> 
> Yes, I tested it successfully on the Sequoia eval board.

I meant with the scope attached to i2c lines to verify correct i2c 
speed.

-- 
Eugene
