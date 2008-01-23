Return-Path: <khali@linux-fr.org>
Received: from mallaury.nerim.net (smtp-103-wednesday.noc.nerim.net
	[62.4.17.103]) by ozlabs.org (Postfix) with ESMTP id E680BDDDF6
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 21:24:04 +1100 (EST)
Date: Wed, 23 Jan 2008 11:23:50 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH POWERPC] i2c: adds support for i2c bus on Frescale
	CPM1/CPM2 controllers
Message-ID: <20080123112350.629ee615@hyperion.delvare>
In-Reply-To: <20071222001112.691b80c8@kernel.crashing.org>
References: <476C15BC.3090807@scram.de>
	<20071222001112.691b80c8@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 22 Dec 2007 00:11:12 +0300, Vitaly Bordug wrote:
> On Fri, 21 Dec 2007 20:36:28 +0100
> Jochen Friedrich wrote:
> 
> > Using the port of 2.4 code from Vitaly Bordug
> > <vitb@kernel.crashing.org> and the actual algorithm used by the i2c
> > driver of the DBox code on cvs.tuxboc.org from Tmbinc, Gillem
> > (htoa@gmx.net). Renamed i2c-rpx.c and i2c-algo-8xx.c to i2c-cpm.c and
> > converted the driver to an of_platform_driver.
> > 
> 
> I had an attempt a while ago to do this but haven't had enough time to get it completed, so
> I am glad to see it finally picked up. There was some sort of discussion that time, you seem to have some of those points
> addressed but  something not, please
> check: http://lkml.org/lkml/2007/5/8/45
> 
> (for instance, cpm_i2c_shutdown() and i2c_cpm_del_bus() are void because they cant' fail) 
> 
> Also, why this was directed to Scott? This is lm-sensors stuff and is
> Jean Delvare <khali@linux-fr.org> material...

This is _i2c_ stuff and doesn't have _anything_ to do with lm-sensors.
(Don't let the i2c list address fool you.)

As the i2c subsystem maintainer, I am very pleased when contributors
get their patches reviewed and tested by people with the knowledge and
access to the target architecture and hardware. So Jochen did the right
thing by sending this patch to Scott at first.

-- 
Jean Delvare
