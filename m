Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 9247CDDE23
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 06:48:30 +1000 (EST)
Date: Wed, 23 Jul 2008 00:48:27 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Brownell <david-b@pacbell.net>
Subject: Re: latest tree build failure -- cpm uart & gpio
Message-ID: <20080722204827.GA16227@polina.dev.rtsoft.ru>
References: <FBE46DB6-A457-4AD8-9D6E-9D639AD04325@freescale.com>
	<20080722145330.GA2315@polina.dev.rtsoft.ru>
	<200807221233.16723.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <200807221233.16723.david-b@pacbell.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Kumar Gala <kumar.gala@freescale.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 22, 2008 at 12:33:16PM -0700, David Brownell wrote:
> On Tuesday 22 July 2008, Anton Vorontsov wrote:
> > On Tue, Jul 22, 2008 at 08:54:16AM -0500, Kumar Gala wrote:
> > > can someone look at the following compile failure in linus's tree.  I'm 
> > > guessing part of this has to do with Alan's tty changes (and might  
> > > already be addressed?).
> > >
> > > include/asm-generic/gpio.h:131: error: implicit declaration of function 
> > > 'gpio_get_value'
> > > include/asm-generic/gpio.h:137: error: implicit declaration of function 
> > > 'gpio_set_value'
> > 
> > I think this patch should help:
> > 
> > [OF] of_gpio: should use new <linux/gpio.h> header
> > http://patchwork.ozlabs.org/linuxppc/patch?id=18750
> 
> Is that confirmed as fixing this, vs just being the Right Thing To Do?

Just applied the patch locally and the issue is not reproducible
anymore.

> > David, can you please Ack it? See Benjamin's mail:
> > http://ozlabs.org/pipermail/linuxppc-dev/2008-July/060109.html
> 
> If you like ... but this is an OF-specific change, making
> it conform with the interface spec, so I wouldn't expect
> this to need more approvals than it's already got.
> 
> Acked-by: David Brownell <dbrownell@users.sourceforge.net>

Thanks.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
