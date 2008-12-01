Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7789FDDDDF
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2008 10:01:09 +1100 (EST)
Message-ID: <49346C9E.4090906@freescale.com>
Date: Mon, 01 Dec 2008 17:00:46 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Trent Piepho <tpiepho@freescale.com>
Subject: Re: i2c-mpc clocking scheme
References: <492EB606.9020703@matrix-vision.de>
	<ed82fe3e0811270724t26d2a8e2v233143722eb8587f@mail.gmail.com>
	<492EC031.9000802@matrix-vision.de>
	<Pine.LNX.4.64.0811281255001.12483@t2.domain.actdsltmp>
	<4933FBC6.50100@freescale.com> <49343DC2.3070601@matrix-vision.de>
	<Pine.LNX.4.64.0812011347450.10176@t2.domain.actdsltmp>
	<49346497.8050701@freescale.com>
	<Pine.LNX.4.64.0812011438550.10176@t2.domain.actdsltmp>
In-Reply-To: <Pine.LNX.4.64.0812011438550.10176@t2.domain.actdsltmp>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>,
	=?ISO-8859-1?Q?z?= <Andre.Schwarz@matrix-vision.de>,
	=?ISO-8859-1?Q?Andr=E9_Schwar?=, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Trent Piepho wrote:

> For a bus device like an i2c controller, you really have two clocks.  The
> input clock the controller runs from and the speed it runs the bus at.  One
> could say that one clock is for the device node and the other clock is for
> the device's sub-nodes.

We could add a property to each I2C device nodes that lists the maximum speed
that this supports.  Then the I2C driver could find the smallest of these
speeds, and program the I2C controller for that speed.

-- 
Timur Tabi
Linux kernel developer at Freescale
