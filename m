Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 52BC167A91
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Feb 2005 05:57:29 +1100 (EST)
Date: Wed, 9 Feb 2005 10:57:26 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Clemens Koller <clemens.koller@anagramm.de>
Message-ID: <20050209185726.GA2638@gate.ebshome.net>
References: <420A4CF3.5090902@anagramm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <420A4CF3.5090902@anagramm.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Are the I2C drivers on MPC8540 Kernel 2.6.10 working?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Feb 09, 2005 at 06:48:35PM +0100, Clemens Koller wrote:
> My problems:
> I try to get a I2C Philips PCF8563 Real Time Clock working which
> is connected to the I2C of my MPC8540 processor.
> The chip should be sw-compatible with the Epson RTC8564 component
> (according to the datasheets), so I tried to enable the MPC85xx
> I2C bus, the EPSON RTC8564 and the Kernel RTC support.
> I tried several configs - compiled i2c into the kernel or as a
> modules to load and unload them with debug=1
> 
> I cannot access /dev/misc/rtc with the hwclock (latest version=2.23):

Make sure I2C address for your RTC clock is correct. They may be 
compatible, but usually I2C address depends on board design and you 
may have to tweak the driver a little.

--
Eugene.
