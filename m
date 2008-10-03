Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 249F7DDF3E
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Oct 2008 02:18:10 +1000 (EST)
Message-Id: <370072EA-CFCC-4027-8D8C-7730A1C8D9A5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <48E643A5.9060403@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: make Freescale QE support a selectable Kconfig
	option
Date: Fri, 3 Oct 2008 11:18:02 -0500
References: <1222961277-6166-1-git-send-email-timur@freescale.com>
	<20081003070416.GA460@oksana.dev.rtsoft.ru>
	<E50C84D1-E250-4827-B260-A5005CABE959@kernel.crashing.org>
	<20081003084849.GA18271@oksana.dev.rtsoft.ru>
	<20081003090804.GA29029@oksana.dev.rtsoft.ru>
	<48E63DB6.8030102@freescale.com>
	<20081003160545.GA29927@oksana.dev.rtsoft.ru>
	<48E643A5.9060403@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 3, 2008, at 11:09 AM, Timur Tabi wrote:

> Anton Vorontsov wrote:
>
>> Yup. David said that platform GPIO controllers should not go into the
>> drivers/gpio/, their place is in the arch/.
>
> Then when I do "make menuconfig", why doesn't that option appear  
> under "Platform
> support"?  This is what I see now:
>
> [*] Networking support  --->
>    Device Drivers  --->
>    File systems  --->
> [*] QE GPIO support
>    Library routines  --->
>    Kernel hacking  --->

I'm moving it under platform like the 8xxx GPIO config

- k
