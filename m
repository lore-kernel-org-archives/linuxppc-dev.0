Return-Path: <david-b@pacbell.net>
Received: from smtp116.sbc.mail.sp1.yahoo.com (smtp116.sbc.mail.sp1.yahoo.com
	[69.147.64.89]) by ozlabs.org (Postfix) with SMTP id BC331DE127
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 05:33:19 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: avorontsov@ru.mvista.com
Subject: Re: latest tree build failure -- cpm uart & gpio
Date: Tue, 22 Jul 2008 12:33:16 -0700
References: <FBE46DB6-A457-4AD8-9D6E-9D639AD04325@freescale.com>
	<20080722145330.GA2315@polina.dev.rtsoft.ru>
In-Reply-To: <20080722145330.GA2315@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200807221233.16723.david-b@pacbell.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Kumar Gala <kumar.gala@freescale.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 22 July 2008, Anton Vorontsov wrote:
> On Tue, Jul 22, 2008 at 08:54:16AM -0500, Kumar Gala wrote:
> > can someone look at the following compile failure in linus's tree.  I'm 
> > guessing part of this has to do with Alan's tty changes (and might  
> > already be addressed?).
> >
> > include/asm-generic/gpio.h:131: error: implicit declaration of function 
> > 'gpio_get_value'
> > include/asm-generic/gpio.h:137: error: implicit declaration of function 
> > 'gpio_set_value'
> 
> I think this patch should help:
> 
> [OF] of_gpio: should use new <linux/gpio.h> header
> http://patchwork.ozlabs.org/linuxppc/patch?id=18750

Is that confirmed as fixing this, vs just being the Right Thing To Do?

 
> David, can you please Ack it? See Benjamin's mail:
> http://ozlabs.org/pipermail/linuxppc-dev/2008-July/060109.html

If you like ... but this is an OF-specific change, making
it conform with the interface spec, so I wouldn't expect
this to need more approvals than it's already got.

Acked-by: David Brownell <dbrownell@users.sourceforge.net>


> 
> -- 
> Anton Vorontsov
> email: cbouatmailru@gmail.com
> irc://irc.freenode.net/bd2
> 
