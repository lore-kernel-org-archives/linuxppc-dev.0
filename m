Return-Path: <SRS0+9bc0dae761e93ec26ee7+1234+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7CBA0DDE40
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jan 2007 18:28:04 +1100 (EST)
Subject: Re: Linux 2.6.20-rc4
From: David Woodhouse <dwmw2@infradead.org>
To: Sylvain Munaut <tnt@246tNt.com>
In-Reply-To: <45A340E4.5030702@246tNt.com>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
	<200701081550.27748.m.kozlowski@tuxland.pl>
	<45A25C17.5070606@246tNt.com>
	<1168303139.22458.246.camel@localhost.localdomain>
	<20070109005624.GA598@suse.de>
	<1168308323.22458.254.camel@localhost.localdomain>
	<45A340E4.5030702@246tNt.com>
Content-Type: text/plain
Date: Tue, 09 Jan 2007 15:28:21 +0800
Message-Id: <1168327701.14763.324.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: Greg KH <gregkh@suse.de>, Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
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

On Tue, 2007-01-09 at 08:14 +0100, Sylvain Munaut wrote:
> But maybe the question we should ask is why would it build
> drivers/usb/host/ohci-ppc-soc.c for an iMac G3 ... Because that problem
> (ohci multiple glue in module) is there since a long time, just never
> spotted before.

Are you suggesting that distributions must choose to support OHCI from
_either_ PCI or OF but not both?

-- 
dwmw2
