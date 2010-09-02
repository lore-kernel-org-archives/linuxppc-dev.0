Return-Path: <sposelenov@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ADAA1B717F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Sep 2010 00:04:59 +1000 (EST)
Date: Thu, 2 Sep 2010 17:34:56 +0400
From: Sergei Poselenov <sposelenov@emcraft.com>
To: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 1/2] [PPC] Motion-PRO: Added LED support for the Promess
	Motion-Pro board. The driver is based on the original
	version(http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg06694.html),
	adapted for the current kernel structures.
Message-ID: <20100902173456.3fdef6b8@emcraft.com>
In-Reply-To: <20100902124617.GA27957@oksana.dev.rtsoft.ru>
References: <1283422832-9620-1-git-send-email-sposelenov@emcraft.com>
	<20100902124617.GA27957@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Anton,

On Thu, 2 Sep 2010 16:46:17 +0400
Anton Vorontsov <cbouatmailru@gmail.com> wrote:

> On Thu, Sep 02, 2010 at 12:20:31PM +0200, sposelenov@emcraft.com
> wrote: [...]
> > +config LEDS_MOTIONPRO
> > +	tristate "Motionpro LEDs Support"
> > +	depends on LEDS_CLASS
> > +	help
> > +	  This option enables support for status and ready LEDs
> > connected
> > +	  to GPIO lines on Motionpro board.
> 
> Why not expose these GPIOs via GPIOLIB[1] and use generic GPIO
> LEDs[2] driver, along with the timer LED trigger[3] for blinking?
> 
> Thanks,
> 
> [1] Documentation/gpio.txt
>     Documentation/powerpc/dts-bindings/gpio/gpio.txt
> [2] drivers/leds/leds-gpio.c
>     Documentation/powerpc/dts-bindings/gpio/led.txt
> [3] drivers/leds/ledtrig-timer.c
> 

Yes, this seem possible to implement (and thanks for pointing into
this), however, the driver is already exists (actually, since 2007),
so why to not add it to save efforts?

Regards,
Sergei
