Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id D175BDDEE4
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 01:23:30 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: PPC440EPx gpio driver
Date: Thu, 9 Oct 2008 16:23:22 +0200
References: <48ED1E96.4060406@harris.com>
In-Reply-To: <48ED1E96.4060406@harris.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810091623.22725.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 08 October 2008, Steven A. Falco wrote:
> I have begun writing a driver for the GPIOs of the PPC440EPx.  I just
> noticed that the PIKA Warp .dts references a device "ibm,gpio-440ep",
> but so far I have not been able to find a driver for that device.
>
> So, here is what I have so far (patch is off 2.6.27-rc9).  It is not
> sufficiently general to be merged at this point, but it does appear
> to function with my Sequoia board (only tested gpio input, so far).

Thanks for this driver.

I have "another" 4xx-gpiolib driver version in my patch queue. It's also not 
polished yet. That's the reason why I didn't post it till now. I'll post my 
driver version in a short while. It's tested on a 405EP and an 440EPx system 
and "should" work on all other 4xx based platforms.

The community then can decide which driver version should be polished for 
upstream merge...

Best regards,
Stefan
