Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 70D3DDE007
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 00:58:56 +1000 (EST)
Date: Thu, 17 Jul 2008 10:58:54 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] leds: implement OpenFirmare GPIO LED driver
Message-ID: <20080717105854.45427267@lappy.seanm.ca>
In-Reply-To: <20080717110730.GA24775@polina.dev.rtsoft.ru>
References: <20080714164114.GA18784@polina.dev.rtsoft.ru>
	<dc452eaab83710e7d6f86dcc5d77bdda@kernel.crashing.org>
	<20080717110730.GA24775@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Richard Purdie <rpurdie@rpsys.net>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 17 Jul 2008 15:07:30 +0400
"Anton Vorontsov" <avorontsov@ru.mvista.com> wrote:

> This is tricky question. Personally I place them inside the gpio
> controller node that is responsible for the LED. But I think placing
> the led nodes at top level would be also fine (maybe with "leds { }"
> node as a parent for all board's LEDs. What would you suggest for a
> "best practice"?

I also put the leds under the gpio controller for the Warp. It is then
very clear which gpio controller the leds belong to.

Putting them at the top level does not associate the leds with the
correct gpio controller.

Warning: I am *not* using the of gpio led driver, but I hope to move to
it once the dust settles and drop the current Warp specific driver ;)

Cheers,
   Sean
