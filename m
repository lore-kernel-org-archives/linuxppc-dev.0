Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 78688DE28B
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Jan 2009 04:29:25 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n0GHT49W002225
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 10:29:16 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n0GHT35w001103
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 11:29:03 -0600 (CST)
Date: Fri, 16 Jan 2009 11:29:03 -0600
From: Scott Wood <scottwood@freescale.com>
To: Jean-Michel Hautbois <jhautbois@gmail.com>
Subject: Re: [MPC8272ADS]Cannot start my Linux Kernel
Message-ID: <20090116172903.GA722@ld0162-tx32.am.freescale.net>
References: <8cad0aa0901150342s2362e53bqf9472c1dc239636c@mail.gmail.com>
	<496F318D.6010302@denx.de>
	<8cad0aa0901150510o7a8146f1m2045e252c5e1cf24@mail.gmail.com>
	<496F4760.1010007@denx.de>
	<8cad0aa0901150706u72538941rbc22655d5a8905ea@mail.gmail.com>
	<8cad0aa0901160406l3db9c025ubdcac40b4b464d23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8cad0aa0901160406l3db9c025ubdcac40b4b464d23@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 16, 2009 at 01:06:06PM +0100, Jean-Michel Hautbois wrote:
> Could it be a problem in my bootargs command line ?
> I mean, maybe the console=ttyS0,11500 wrong ?
> Because my "Run" LED is on...
> 
> I tried ttyS0, ttyCPM0, tty0.

It should be ttyCPM0, or just leave it out and make sure that
/chosen/linux,stdout-path is set properly.

Have you tried enabling early CPM debugging output?

-Scott
