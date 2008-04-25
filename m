Return-Path: <glikely@secretlab.ca>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.226])
	by ozlabs.org (Postfix) with ESMTP id 995B8DE232
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Apr 2008 05:30:52 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so3302183wxd.15
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 12:30:50 -0700 (PDT)
Message-ID: <fa686aa40804251230w3306ece2x1a10d06e3a83ed45@mail.gmail.com>
Date: Fri, 25 Apr 2008 13:30:49 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Sascha Hauer" <s.hauer@pengutronix.de>
Subject: Re: [PATCH] add gpiolib support for mpc5200
In-Reply-To: <20080425185141.GA17951@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080424153659.GJ6692@pengutronix.de>
	<fa686aa40804241145x39165ffp78108c53d0d5a911@mail.gmail.com>
	<4811F92F.70200@genesi-usa.com>
	<20080425185141.GA17951@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 25, 2008 at 12:51 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Fri, Apr 25, 2008 at 04:30:55PM +0100, Matt Sealey wrote:
>  > Can I make a suggestion for this chip support?
>  >
>  > On certain 5200 boards these devices are not usable since they are not
>  > connected. My concern is the Efika where we only have 2 wakeup and 1 simple
>  > GPIO available on the board and maybe a few others with a bit of tweaking
>  > and messing around.
>
>  This is probably true for most boards.
>  I haven't tested if this is true for all gpios, but the peripheral usage
>  settings seem to take precedence over the gpio settings. So at least you
>  can play with already for peripheral claimed gpios without bad things
>  happening. But ok, seems to be a bad idea to rely on this.

There must also be some level of assumption that the device tree data
is accurate.  If a pin is specified that is not enabled as a GPIO pin,
then it's not going to work.

Cheers,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
