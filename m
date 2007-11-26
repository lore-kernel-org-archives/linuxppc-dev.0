Return-Path: <joel@fabiotec.com>
Received: from mtaout1.barak.net.il (mtaout1.barak.net.il [212.150.49.171])
	by ozlabs.org (Postfix) with ESMTP id 4D6D1DDF14
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 04:22:17 +1100 (EST)
Received: from [192.168.200.140] ([62.90.35.117])
	by mtaout1.barak.net.il (Sun Java System Messaging Server 6.2-7.04
	(built Aug
	17 2006)) with ESMTP id <0JS4008T1IW8WWG0@mtaout1.barak.net.il> for
	linuxppc-dev@ozlabs.org; Mon, 26 Nov 2007 19:21:44 +0200 (IST)
Date: Mon, 26 Nov 2007 19:21:37 +0200
From: Joel Rouch <joel@fabiotec.com>
Subject: Re: sys_mpc83xx spi driver not probed
In-reply-to: <20071126163956.GB4408@loki.buserror.net>
To: Scott Wood <scottwood@freescale.com>
Message-id: <474B00A1.2020808@fabiotec.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
References: <4747079F.60703@fabiotec.com>
	<20071126163956.GB4408@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Unfortunately not as I still need to use ARCH=ppc.

I am just using a platform_driver_probe() from the module_init.

static int __init mpc83xx_spi_init(void)
{
return platform_driver_probe(&mpc83xx_spi_driver, mpc83xx_spi_probe);

}

Thanks

Scott Wood wrote:
> On Fri, Nov 23, 2007 at 07:02:23PM +0200, Joel Rouch wrote:
>   
>> I have a custom 8349 ppc board. I have defined the spi master in the 
>> configuration.
>> While booting my board, I driver is well added and linked to platform 
>> bus, however I don't see that the probe entry point is reached.
>> I don't succeed to understand who is triggering the probe. Can someone 
>> point me to the right link or explain me how to force it ?
>>     
>
> Are you calling of_platform_bus_probe() from your board file?
>
> -Scott
>   
