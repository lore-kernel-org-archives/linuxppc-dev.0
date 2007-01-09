Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D21E9DDDF2
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jan 2007 13:05:38 +1100 (EST)
Subject: Re: Linux 2.6.20-rc4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <gregkh@suse.de>
In-Reply-To: <20070109005624.GA598@suse.de>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
	<200701081550.27748.m.kozlowski@tuxland.pl>
	<45A25C17.5070606@246tNt.com>
	<1168303139.22458.246.camel@localhost.localdomain>
	<20070109005624.GA598@suse.de>
Content-Type: text/plain
Date: Tue, 09 Jan 2007 13:05:23 +1100
Message-Id: <1168308323.22458.254.camel@localhost.localdomain>
Mime-Version: 1.0
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

On Mon, 2007-01-08 at 16:56 -0800, Greg KH wrote:
> On Tue, Jan 09, 2007 at 11:38:59AM +1100, Benjamin Herrenschmidt wrote:
> > On Mon, 2007-01-08 at 15:58 +0100, Sylvain Munaut wrote:
> > > Don't build ohci as module for now.
> > > A fix for that is already in gregkh usb tree for 2.6.21
> > 
> > Do you mean that as-is, powerpc defconfigs cannot build USB as a module
> > in 2.6.20 ? That is unacceptable as a regression. We need a fix in
> > 2.6.20.
> > 
> > Greg, what is the status there ?
> 
> Hm, for some reason I thought your patches were not needed until 2.6.21.

My endian patches aren't, but Sylvain' are based on mines so ... Maybe
if Sylvain rebases his ?

> Should I forward them on to Linus now for 2.6.20?  Are they required for
> ppc to build?

Sylvain fixes are. My endian patches are for ps3 and toshiba celleb,
none of which is fully merged in 2.6.20 so they are fine to wait. It's
mostly a matter of being a PITA to rebase Sylvain stuff to apply before
mine and rebase mine on top of his I suppose :-)

Ben.
