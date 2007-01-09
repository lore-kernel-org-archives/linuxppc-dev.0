Return-Path: <SRS0+9bc0dae761e93ec26ee7+1234+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2EDB0DDDF3
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jan 2007 18:04:33 +1100 (EST)
Subject: Re: Linux 2.6.20-rc4
From: David Woodhouse <dwmw2@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1168308323.22458.254.camel@localhost.localdomain>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
	<200701081550.27748.m.kozlowski@tuxland.pl>
	<45A25C17.5070606@246tNt.com>
	<1168303139.22458.246.camel@localhost.localdomain>
	<20070109005624.GA598@suse.de>
	<1168308323.22458.254.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 09 Jan 2007 15:04:33 +0800
Message-Id: <1168326274.14763.313.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: Sylvain Munaut <tnt@246tNt.com>, Greg KH <gregkh@suse.de>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-01-09 at 13:05 +1100, Benjamin Herrenschmidt wrote:
> Sylvain fixes are. My endian patches are for ps3 and toshiba celleb,
> none of which is fully merged in 2.6.20 so they are fine to wait. It's
> mostly a matter of being a PITA to rebase Sylvain stuff to apply before
> mine and rebase mine on top of his I suppose :-) 

Er, doesn't Efika need the same endian patches?

-- 
dwmw2
