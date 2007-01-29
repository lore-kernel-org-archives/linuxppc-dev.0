Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C54CBDDDF9
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 03:15:47 +1100 (EST)
Date: Mon, 29 Jan 2007 17:15:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 1/9] ps3: AV Settings Driver
Message-ID: <20070129161502.GA32313@lst.de>
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
	<Pine.LNX.4.62.0701251846460.24610@pademelon.sonytel.be>
	<20070126031236.GG18537@lst.de>
	<Pine.LNX.4.62.0701291442530.19906@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.62.0701291442530.19906@pademelon.sonytel.be>
Cc: Paul Mackerras <paulus@samba.org>, Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>,
	James Simmons <jsimmons@infradead.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 29, 2007 at 03:10:16PM +0100, Geert Uytterhoeven wrote:
> On Fri, 26 Jan 2007, Christoph Hellwig wrote:
> > Btw, the Kconfig and/or top of file comment really needs a better
> > explanation what this "driver" is for.  I also wonder why it's
> 
> What about `PS3 AV settings driver library' instead of `PS3 AV controller
> support'?

Makes a little more sense, yes.

> We can make FB_PS3 (and SND_PS3 later) select PS3_PS3AV. Is that better?
> I prefer not to make it unconditional, as people who want to run their PS3s
> headless don't need it.

Ok.  Even better would be handling it on the makefile level, by doing

obj-$(CONFIG_FB_PS3)	+= ps3_av.o
obj-$(CONFIG_SND_PS3)	+= ps3_av.o

> I guess you want us to do the same for the virtual uart, i.e. let PS3_PS3AV and
> PS3_SYS_MANAGER select PS3_VUART?

Yes, that probably makes sense aswell.
