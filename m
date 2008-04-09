Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 18DF4DDF4E
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 04:57:03 +1000 (EST)
Message-ID: <47FD118F.8050407@freescale.com>
Date: Wed, 09 Apr 2008 13:57:19 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Andre Schwarz <andre.schwarz@matrix-vision.de>
Subject: Re: MPC8343 - "unable to handle paging request @ 0"
References: <47F73625.9040903@matrix-vision.de>
	<20080407161036.GA2688@loki.buserror.net>
	<47FB7822.6090401@matrix-vision.de>
	<20080408164853.GH2552@loki.buserror.net>
	<47FCBC73.40703@matrix-vision.de>
In-Reply-To: <47FCBC73.40703@matrix-vision.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andre Schwarz wrote:
>  -> find_legacy_serial_port()
> stdout is /soc8343@e0000000/serial@4500

It looks like you have some memory corruption between here...

> clocksource: timebase mult[3c00001] shift[22] registered
> 
> !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
>  -> check_legacy_serial_console()
>  can't find stdout package /soc8343@e0000000/serial@4500 !
> !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

...and here.

-Scott
