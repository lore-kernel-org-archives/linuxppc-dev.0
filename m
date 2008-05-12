Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 12B8DDDEF0
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 05:45:06 +1000 (EST)
Message-ID: <48289E33.3030100@scram.de>
Date: Mon, 12 May 2008 21:44:51 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/3] [WATCHDOG] mpc83xx_wdt: add support for MPC86xx CPUs
References: <20080512185206.GA25818@polina.dev.rtsoft.ru>
	<64629276-8337-4FFE-B3E1-306678BF179D@kernel.crashing.org>
In-Reply-To: <64629276-8337-4FFE-B3E1-306678BF179D@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Wim Van Sebroeck <wim@iguana.be>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Kumar,

>> Also move the probe code into subsys_initcall, because we want start
>> pinging the watchdog ASAP, and misc devices are available in
>> subsys_initcall.
>>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>> ---
>> drivers/watchdog/Kconfig       |    4 +-
>> drivers/watchdog/mpc83xx_wdt.c |   63 +++++++++++++++++++++++++++++++ 
>> +++++----
> 
> we should rename it to mpc8xxx_wdt.c

IIRC, even MPC8xx also has the same style of wdt device, just with a different
prescale factor.

Thanks,
Jochen
