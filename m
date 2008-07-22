Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8C990DDECA
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 08:05:29 +1000 (EST)
Subject: Re: latest tree build failure -- cpm uart & gpio
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20080722145330.GA2315@polina.dev.rtsoft.ru>
References: <FBE46DB6-A457-4AD8-9D6E-9D639AD04325@freescale.com>
	<20080722145330.GA2315@polina.dev.rtsoft.ru>
Content-Type: text/plain
Date: Wed, 23 Jul 2008 08:05:09 +1000
Message-Id: <1216764309.11027.211.camel@pasglop>
Mime-Version: 1.0
Cc: David Brownell <david-b@pacbell.net>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Kumar Gala <kumar.gala@freescale.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-07-22 at 18:53 +0400, Anton Vorontsov wrote:
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
> 
> David, can you please Ack it? See Benjamin's mail:
> http://ozlabs.org/pipermail/linuxppc-dev/2008-July/060109.html
> 

Hrm.. I though I had that one in my latest batch. In fact, I just
checked and it got merged.

Ben.
