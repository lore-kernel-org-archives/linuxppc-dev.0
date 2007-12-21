Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E1147DDEAB
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 08:14:03 +1100 (EST)
Date: Sat, 22 Dec 2007 00:11:12 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH POWERPC] i2c: adds support for i2c bus on Frescale
	CPM1/CPM2 controllers
Message-ID: <20071222001112.691b80c8@kernel.crashing.org>
In-Reply-To: <476C15BC.3090807@scram.de>
References: <476C15BC.3090807@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	khali@linux-fr.org, linux-kernel@vger.kernel.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 21 Dec 2007 20:36:28 +0100
Jochen Friedrich wrote:

> Using the port of 2.4 code from Vitaly Bordug
> <vitb@kernel.crashing.org> and the actual algorithm used by the i2c
> driver of the DBox code on cvs.tuxboc.org from Tmbinc, Gillem
> (htoa@gmx.net). Renamed i2c-rpx.c and i2c-algo-8xx.c to i2c-cpm.c and
> converted the driver to an of_platform_driver.
> 

I had an attempt a while ago to do this but haven't had enough time to get it completed, so
I am glad to see it finally picked up. There was some sort of discussion that time, you seem to have some of those points
addressed but  something not, please
check: http://lkml.org/lkml/2007/5/8/45

(for instance, cpm_i2c_shutdown() and i2c_cpm_del_bus() are void because they cant' fail) 

Also, why this was directed to Scott? This is lm-sensors stuff and is
Jean Delvare <khali@linux-fr.org> material...

-- 
Sincerely, Vitaly
