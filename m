Return-Path: <root@ucw.cz>
Received: from spitz.ucw.cz (gprs189-60.eurotel.cz [160.218.189.60])
	by ozlabs.org (Postfix) with ESMTP id 32774679E0
	for <linuxppc-dev@ozlabs.org>; Sun, 28 May 2006 02:32:21 +1000 (EST)
Date: Fri, 26 May 2006 17:39:09 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Stelian Pop <stelian@popies.net>
Subject: Re: [PATCH] make ams work with latest kernels
Message-ID: <20060526173908.GA3357@ucw.cz>
References: <1148383943.25971.2.camel@johannes>
	<1148465069.6723.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1148465069.6723.26.camel@localhost.localdomain>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi!

> From: Stelian Pop <stelian@popies.net>
> 
> This driver provides support for the Apple Motion Sensor (ams),
> which provides an accelerometer and other misc. data.
> Some Apple PowerBooks (the series the PowerBook5,6 falls into,
> later ones have a slightly different one the driver doesn't handle)
> are supported. The accelerometer data is readable via sysfs.
> 
> This driver also provides an absolute input class device, allowing
> the laptop to act as a pinball machine-esque joystick.

Is it useful to have /sysfs interface when we already have same data
available as joystick?

-- 
Thanks for all the (sleeping) penguins.
