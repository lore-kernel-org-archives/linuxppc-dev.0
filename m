Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao12.cox.net (fed1rmmtao12.cox.net [68.230.241.27])
	by ozlabs.org (Postfix) with ESMTP id E0E0368321
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Sep 2005 23:59:44 +1000 (EST)
Date: Mon, 19 Sep 2005 06:59:42 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
Message-ID: <20050919065942.A25356@cox.net>
References: <ea43f4f9050825183121655ba2@mail.gmail.com>
	<200509161306.17103.sr@denx.de>
	<20050916162733.GA8019@gate.ebshome.net>
	<200509191302.15462.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200509191302.15462.sr@denx.de>;
	from sr@denx.de on Mon, Sep 19, 2005 at 01:02:14PM +0200
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc32: cleanup AMCC PPC4xx eval boards to better
	support U-Boot
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Sep 19, 2005 at 01:02:14PM +0200, Stefan Roese wrote:
> Hi Eugene,
> 
> On Friday 16 September 2005 18:27, Eugene Surovegin wrote:
> > On Fri, Sep 16, 2005 at 01:06:16PM +0200, Stefan Roese wrote:
> > > Add U-Boot support to AMCC PPC405 eval boards (bubinga, sycamore and
> > > walnut) and cleanup PPC440 eval boards (bamboo, ebony, luan and ocotea)
> > > to better support U-Boot as bootloader.
> >
> > In general, 44x pieces look OK, but 40x aren't. Notice, that we don't
> > have any #ifdef CONFIG_UBOOT in 44x sources. Let's not add them for
> > 40x, try to replicate the same boot-wrapper approach as Matt used for
> > 44x.
> 
> OK. I'll split the patch in two (44x and 40x stuff) so we can get the 44x 
> pieces on the way.
> 
> Just to be sure: The 44x boot-wrapper approach you mention is 
> "boot/simple/pibs.c"?

Yes, there's both boot/simple/pibs.c and boot/simple/openbios.c that
were created so we could have the default firmware and u-boot use the
same kernel build.

-Matt
