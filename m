Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9BE48DDE2E
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 23:56:42 +1000 (EST)
In-Reply-To: <20070914083907.321820@gmx.net>
References: <20070914083907.321820@gmx.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <721E5D4F-1BDD-4A63-90B7-92D62386DF24@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: RTC class drivers and powerpc arch
Date: Fri, 14 Sep 2007 08:59:37 -0500
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 14, 2007, at 3:39 AM, Gerhard Pircher wrote:

> Hi,
>
> Since todc was removed from arch/powerpc I wonder how to use the  
> rtc-cmos
> RTC class driver for my AmigaOne with its VIA southbridge. Do I  
> have to
> define a platform device and the get/set_rtc_time hook functions or  
> can
> the driver probe for and access the hardware automatically, if  
> there's a
> device node for the RTC in the device tree?

Take a look at the RTC nodes that exist in arch/powerpc/boot/dts/ 
mpc8544ds.dts for an example related to rtc-cmos.

- k
