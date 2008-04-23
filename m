Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ED88EDE601
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 22:48:23 +1000 (EST)
Date: Wed, 23 Apr 2008 14:47:56 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Laurent Pinchart <laurentp@cse-semaphore.com>, Jochen Friedrich
	<jochen@scram.de>
Subject: Re: [PATCH] rtc-pcf8563: Add device ids table
Message-ID: <20080423144756.3fc9b1bf@hyperion.delvare>
In-Reply-To: <200804231412.40038.laurentp@cse-semaphore.com>
References: <200804171708.32847.laurentp@cse-semaphore.com>
	<200804221612.06745.laurentp@cse-semaphore.com>
	<20080423131657.71d6312f@hyperion.delvare>
	<200804231412.40038.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Alessandro Zummo <alessandro.zummo@towertech.it>,
	i2c@lm-sensors.org, rtc-linux@googlegroups.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 23 Apr 2008 14:12:37 +0200, Laurent Pinchart wrote:
> On Wednesday 23 April 2008 13:16, Jean Delvare wrote:
> > I still don't know exactly what happened there... I think I saw some
> > "OpenFirmware i2c" patches go upstream yesterday? But not the ones
> > listed below, which I thought they depended upon.
> 
> The code that went upstream introduces helper functions to create i2c devices 
> from information supplied by the OF device tree. It doesn't strictly depend 
> on the below patches, but the new devices won't be properly bound to a driver 
> without them.

OK. So... Out of the 7 patches Jochen sent originally, only 1 ([3/7] OF
helpers for the i2c API) went upstream. Am I correct?

Jochen, I'm a bit confused by the dependencies that exist - or not -
between these 7 patches you sent at once. I thought they had to be
applied in sequence but it seems not? And some of them should
apparently go through me i2c tree but others (e.g. [7/7]) not?

I would appreciate if you could summarize quickly which patches depend
on others in which way. If we can make smaller subsets of patches, that
will be easier for me to review and push upstream on my limited time.

Thanks,
-- 
Jean Delvare
