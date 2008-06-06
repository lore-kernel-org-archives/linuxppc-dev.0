Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 46D64DE059
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 18:46:11 +1000 (EST)
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jean Delvare <khali@linux-fr.org>
In-Reply-To: <20080606082150.691da6a4@hyperion.delvare>
References: <200806041706.21557.sr@denx.de>
	<20080604220555.658ab13e@vader.jdub.homelinux.org>
	<20080604231641.786bb2dd@lappy.seanm.ca>
	<200806050822.00797.sr@denx.de>
	<20080605094852.164f0bc7@hyperion.delvare>
	<1212725783.12464.13.camel@pasglop>
	<20080606082150.691da6a4@hyperion.delvare>
Content-Type: text/plain
Date: Fri, 06 Jun 2008 18:45:20 +1000
Message-Id: <1212741920.12464.27.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Stefan Roese <sr@denx.de>, Timur Tabi <timur@freescale.com>,
	Sean MacLennan <smaclennan@pikatech.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-06-06 at 08:21 +0200, Jean Delvare wrote:
> We could certainly add a busname field to struct i2c_devinfo and
> implement i2c_register_board_info_by_name() if it seems to be worth
> the
> extra code and memory. I am open to the idea if it solves a problem
> with no other clean solution.
> 
> [1] radeonfb is notoriously bad at that ;)

radeonfb is notoriously bad at many things :-)

Ben.
