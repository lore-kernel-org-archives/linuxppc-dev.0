Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 2C5E0DDFB0
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 08:26:36 +1000 (EST)
Date: Wed, 23 Jul 2008 02:26:34 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: latest tree build failure -- cpm uart & gpio
Message-ID: <20080722222634.GA4427@polina.dev.rtsoft.ru>
References: <FBE46DB6-A457-4AD8-9D6E-9D639AD04325@freescale.com>
	<20080722145330.GA2315@polina.dev.rtsoft.ru>
	<1216764309.11027.211.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <1216764309.11027.211.camel@pasglop>
Cc: David Brownell <david-b@pacbell.net>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
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

On Wed, Jul 23, 2008 at 08:05:09AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2008-07-22 at 18:53 +0400, Anton Vorontsov wrote:
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
> > 
> > David, can you please Ack it? See Benjamin's mail:
> > http://ozlabs.org/pipermail/linuxppc-dev/2008-July/060109.html
> > 
> 
> Hrm.. I though I had that one in my latest batch. In fact, I just
> checked and it got merged.

Ah, great. So the issue should be fixed already... I just pulled the
Linus' tree, and it is there indeed.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
