Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 321BFDDDF9
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2008 09:37:01 +1100 (EST)
Subject: Re: ARCH=ppc -> ARCH=powerpc : help needed for dts file
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Philippe De Muyter <phdm@macqel.be>
In-Reply-To: <20080309223109.GA3989@netgate.macqel>
References: <20080303212622.GB20382@netgate.macqel>
	<47CC73CE.4080801@freescale.com>
	<20080304080828.GA18829@netgate.macqel>
	<1204618939.21545.52.camel@pasglop>
	<20080304091059.GD18829@netgate.macqel>
	<1204693264.21545.165.camel@pasglop> <47CECB21.3060704@freescale.com>
	<1204760811.21545.231.camel@pasglop>
	<20080307001025.GA27321@netgate.macqel>
	<1204849197.21545.272.camel@pasglop>
	<20080309223109.GA3989@netgate.macqel>
Content-Type: text/plain
Date: Mon, 10 Mar 2008 09:36:26 +1100
Message-Id: <1205102186.8621.1.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sun, 2008-03-09 at 23:31 +0100, Philippe De Muyter wrote:
> Hi Ben,
> 
> I now have a working linux on my mpc8540 based board, with support for
> the compactflash disk and the i2c rtc.
> 
> The network tough, does not work yet. altough the the integrated ethernet
> controller (FEC) seems to be recognized.  Could it be a problem with the phy ?
> I notice that I do not have an entry for gfar_interrupt in /proc/interrupts
> on my ethernet-missing linux, while I have one ont the working arch/ppc linux ?
> Do I need to give the phy type in the dts file, and how ?
> 
> I would also like to know if it is possible to still get in linux the mac
> address known by uboot when using a dts file, and how ?

I'll let the freescale people answer here as I don't know the gianfar
driver at all.

Ben.
