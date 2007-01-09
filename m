Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1CF7ADDE35
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jan 2007 20:11:11 +1100 (EST)
Subject: Re: Linux 2.6.20-rc4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1168327701.14763.324.camel@shinybook.infradead.org>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
	<200701081550.27748.m.kozlowski@tuxland.pl>
	<45A25C17.5070606@246tNt.com>
	<1168303139.22458.246.camel@localhost.localdomain>
	<20070109005624.GA598@suse.de>
	<1168308323.22458.254.camel@localhost.localdomain>
	<45A340E4.5030702@246tNt.com>
	<1168327701.14763.324.camel@shinybook.infradead.org>
Content-Type: text/plain
Date: Tue, 09 Jan 2007 20:08:54 +1100
Message-Id: <1168333734.22458.269.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Sylvain Munaut <tnt@246tNt.com>, Greg KH <gregkh@suse.de>,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-01-09 at 15:28 +0800, David Woodhouse wrote:
> On Tue, 2007-01-09 at 08:14 +0100, Sylvain Munaut wrote:
> > But maybe the question we should ask is why would it build
> > drivers/usb/host/ohci-ppc-soc.c for an iMac G3 ... Because that problem
> > (ohci multiple glue in module) is there since a long time, just never
> > spotted before.
> 
> Are you suggesting that distributions must choose to support OHCI from
> _either_ PCI or OF but not both?

I think not. What he meant I suppose is that in -addition- to the
problem that needs to be fixed, there is another one where efika support
defaults to y in Kconfig, thus gets enabled for pmac32_defconfig etc...

Ben.
