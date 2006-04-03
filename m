Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 98975679FF
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Apr 2006 20:10:46 +1000 (EST)
Received: from leda.ptxnet.pengutronix.de ([10.1.0.71])
	by metis.extern.pengutronix.de with esmtp (Exim 3.36 #1 (Debian))
	id 1FQM1E-0007fP-00
	for <linuxppc-embedded@ozlabs.org>; Mon, 03 Apr 2006 12:10:44 +0200
Received: from sha by leda.ptxnet.pengutronix.de with local (Exim 4.51)
	id 1FQM1D-0001NL-Sn
	for linuxppc-embedded@ozlabs.org; Mon, 03 Apr 2006 12:10:43 +0200
Date: Mon, 3 Apr 2006 12:10:43 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: mpc5200b and floating point
Message-ID: <20060403101043.GB4857@localhost.localdomain>
References: <20060331133619.GD7738@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060331133619.GD7738@localhost.localdomain>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Mar 31, 2006 at 03:36:20PM +0200, Sascha Hauer wrote:
> Hi,
> 
> I'm working with a mpc5200b custom board and I'm trying to run an
> application with floating point. All floating point variables seem to
> zero all the time. Since I'm not very familiar with powerpc it might be
> something stupid I have overlooked.
> Any hints?

The problem turned out to be toolchain related. We chrooted into the
rootfs on an Ibook, same problem there. I'll take a closer look in my
toochain.

Thank you for your replies,

Sascha Hauer
