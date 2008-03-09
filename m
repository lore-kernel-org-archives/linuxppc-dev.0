Return-Path: <phdm@macqel.be>
Received: from mail.macqel.be (mail.macqel.be [194.78.208.39])
	by ozlabs.org (Postfix) with ESMTP id 40875DDDEB
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2008 09:31:12 +1100 (EST)
Date: Sun, 9 Mar 2008 23:31:09 +0100
From: Philippe De Muyter <phdm@macqel.be>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ARCH=ppc -> ARCH=powerpc : help needed for dts file
Message-ID: <20080309223109.GA3989@netgate.macqel>
References: <20080303212622.GB20382@netgate.macqel>
	<47CC73CE.4080801@freescale.com>
	<20080304080828.GA18829@netgate.macqel>
	<1204618939.21545.52.camel@pasglop>
	<20080304091059.GD18829@netgate.macqel>
	<1204693264.21545.165.camel@pasglop>
	<47CECB21.3060704@freescale.com>
	<1204760811.21545.231.camel@pasglop>
	<20080307001025.GA27321@netgate.macqel>
	<1204849197.21545.272.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1204849197.21545.272.camel@pasglop>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben,

I now have a working linux on my mpc8540 based board, with support for
the compactflash disk and the i2c rtc.

The network tough, does not work yet. altough the the integrated ethernet
controller (FEC) seems to be recognized.  Could it be a problem with the phy ?
I notice that I do not have an entry for gfar_interrupt in /proc/interrupts
on my ethernet-missing linux, while I have one ont the working arch/ppc linux ?
Do I need to give the phy type in the dts file, and how ?

I would also like to know if it is possible to still get in linux the mac
address known by uboot when using a dts file, and how ?

Thanks for listening.

Philippe
