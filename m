Return-Path: <gregkh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D743EDDE27
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jan 2007 18:19:42 +1100 (EST)
Date: Mon, 8 Jan 2007 23:18:47 -0800
From: Greg KH <gregkh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Linux 2.6.20-rc4
Message-ID: <20070109071847.GC6013@suse.de>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
	<200701081550.27748.m.kozlowski@tuxland.pl>
	<45A25C17.5070606@246tNt.com>
	<1168303139.22458.246.camel@localhost.localdomain>
	<20070109005624.GA598@suse.de>
	<1168308323.22458.254.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1168308323.22458.254.camel@localhost.localdomain>
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

On Tue, Jan 09, 2007 at 01:05:23PM +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2007-01-08 at 16:56 -0800, Greg KH wrote:
> > On Tue, Jan 09, 2007 at 11:38:59AM +1100, Benjamin Herrenschmidt wrote:
> > > On Mon, 2007-01-08 at 15:58 +0100, Sylvain Munaut wrote:
> > > > Don't build ohci as module for now.
> > > > A fix for that is already in gregkh usb tree for 2.6.21
> > > 
> > > Do you mean that as-is, powerpc defconfigs cannot build USB as a module
> > > in 2.6.20 ? That is unacceptable as a regression. We need a fix in
> > > 2.6.20.
> > > 
> > > Greg, what is the status there ?
> > 
> > Hm, for some reason I thought your patches were not needed until 2.6.21.
> 
> My endian patches aren't, but Sylvain' are based on mines so ... Maybe
> if Sylvain rebases his ?

Yes, if something needs to get in now, please let me know, I don't have
any USB patches pending in the "2.6.20" queue at this moment.

thanks,

greg k-h
