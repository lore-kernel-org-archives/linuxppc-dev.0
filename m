Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 98BE5DDF4D
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 19:45:43 +1100 (EST)
Date: Wed, 31 Jan 2007 09:45:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/9] ps3: AV Settings Driver
Message-ID: <20070131084513.GB5596@lst.de>
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
	<Pine.LNX.4.62.0701251846460.24610@pademelon.sonytel.be>
	<20070126031236.GG18537@lst.de>
	<Pine.LNX.4.62.0701291442530.19906@pademelon.sonytel.be>
	<20070129161502.GA32313@lst.de>
	<E674F9E5-3FFC-4291-A03B-0C3BF0F833A6@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E674F9E5-3FFC-4291-A03B-0C3BF0F833A6@kernel.crashing.org>
Cc: Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	James Simmons <jsimmons@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 30, 2007 at 07:39:40PM +0100, Segher Boessenkool wrote:
> >obj-$(CONFIG_FB_PS3)	+= ps3_av.o
> >obj-$(CONFIG_SND_PS3)	+= ps3_av.o
> 
> I don't think Kbuild will be too happy with that.  Or does
> it filter out duplicate files everywhere (dep, build, link)?

Yes, it's a feature stamming from the first predecessor of the current
kbuild system (drivers/sound/Makefile in late 2.2.x).
