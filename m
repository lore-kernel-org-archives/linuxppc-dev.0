Return-Path: <gregkh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 972D8DDEC9
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jan 2007 11:57:07 +1100 (EST)
Date: Mon, 8 Jan 2007 16:56:24 -0800
From: Greg KH <gregkh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Linux 2.6.20-rc4
Message-ID: <20070109005624.GA598@suse.de>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
	<200701081550.27748.m.kozlowski@tuxland.pl>
	<45A25C17.5070606@246tNt.com>
	<1168303139.22458.246.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1168303139.22458.246.camel@localhost.localdomain>
Cc: Sylvain Munaut <tnt@246tNt.com>, Linus Torvalds <torvalds@osdl.org>,
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

On Tue, Jan 09, 2007 at 11:38:59AM +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2007-01-08 at 15:58 +0100, Sylvain Munaut wrote:
> > Don't build ohci as module for now.
> > A fix for that is already in gregkh usb tree for 2.6.21
> 
> Do you mean that as-is, powerpc defconfigs cannot build USB as a module
> in 2.6.20 ? That is unacceptable as a regression. We need a fix in
> 2.6.20.
> 
> Greg, what is the status there ?

Hm, for some reason I thought your patches were not needed until 2.6.21.
Should I forward them on to Linus now for 2.6.20?  Are they required for
ppc to build?

thanks,

greg k-h
