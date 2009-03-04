Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 8221FDDDFA
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 11:37:31 +1100 (EST)
Date: Tue, 03 Mar 2009 16:37:13 -0800 (PST)
Message-Id: <20090303.163713.131742043.davem@davemloft.net>
To: smaclennan@pikatech.com
Subject: Re: "leds: Add openfirmware platform device support" breaks sparc
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090303192932.31705cf7@lappy.seanm.ca>
References: <20090303160906.9b30b376.akpm@linux-foundation.org>
	<20090303192932.31705cf7@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org,
	akpm@linux-foundation.org, tpiepho@freescale.com, rpurdie@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Sean MacLennan <smaclennan@pikatech.com>
Date: Tue, 3 Mar 2009 19:29:32 -0500

> It has been..... uhhhh carry the two... longer than I want to admit
> since I worked on a sparc. Would GPIO based LEDS make sense on a sparc
> platform? Is sparc used much in the embedded world?
> 
> If yes, the of_register_platform_driver is just a nice wrapper. It
> would be trivial to either change it to work on sparc, or add the
> wrapper to the sparc includes.

We generally create the platform devices by hand for LED
devices on sparc64.

I'd CONFIG_POWERPC depend this thing for now.
