Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BE904DDEFD
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Oct 2008 02:09:18 +1000 (EST)
Message-ID: <48E643A5.9060403@freescale.com>
Date: Fri, 03 Oct 2008 11:09:09 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] powerpc: make Freescale QE support a selectable Kconfig
	option
References: <1222961277-6166-1-git-send-email-timur@freescale.com>
	<20081003070416.GA460@oksana.dev.rtsoft.ru>
	<E50C84D1-E250-4827-B260-A5005CABE959@kernel.crashing.org>
	<20081003084849.GA18271@oksana.dev.rtsoft.ru>
	<20081003090804.GA29029@oksana.dev.rtsoft.ru>
	<48E63DB6.8030102@freescale.com>
	<20081003160545.GA29927@oksana.dev.rtsoft.ru>
In-Reply-To: <20081003160545.GA29927@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:

> Yup. David said that platform GPIO controllers should not go into the
> drivers/gpio/, their place is in the arch/.

Then when I do "make menuconfig", why doesn't that option appear under "Platform
support"?  This is what I see now:

[*] Networking support  --->
    Device Drivers  --->
    File systems  --->
[*] QE GPIO support
    Library routines  --->
    Kernel hacking  --->

-- 
Timur Tabi
Linux kernel developer at Freescale
