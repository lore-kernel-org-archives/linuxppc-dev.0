Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 91847DDD1B
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 19:01:19 +1000 (EST)
Date: Tue, 28 Apr 2009 02:01:09 -0700 (PDT)
Message-Id: <20090428.020109.216217114.davem@davemloft.net>
To: grant.likely@secretlab.ca
Subject: Re: "leds: Add openfirmware platform device support" breaks sparc
From: David Miller <davem@davemloft.net>
In-Reply-To: <fa686aa40904272059q604d61c5u1fe584a2166545f1@mail.gmail.com>
References: <20090303.163713.131742043.davem@davemloft.net>
	<20090427152051.5067e888.akpm@linux-foundation.org>
	<fa686aa40904272059q604d61c5u1fe584a2166545f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: monstr@monstr.eu, linuxppc-dev@ozlabs.org, rpurdie@linux.intel.com,
	smaclennan@pikatech.com, sparclinux@vger.kernel.org,
	akpm@linux-foundation.org, tpiepho@freescale.com,
	john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 27 Apr 2009 21:59:39 -0600

>     of: make of_(un)register_platform_driver common code.
> 
>     Some drivers using of_register_platform_driver() wrapper break on sparc
>     because the wrapper isn't in the header file.  This patch moves it from
>     Microblaze and PowerPC implementations and makes it common code.
> 
>     Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Looks great:

Acked-by: David S. Miller <davem@davemloft.net>
