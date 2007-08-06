Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 76942DDE3B
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 04:25:21 +1000 (EST)
In-Reply-To: <20070801141614.ad6604bb.kim.phillips@freescale.com>
References: <20070726135738.GB5643@localhost.localdomain>
	<7BACDD73-9097-4139-8331-A1A14A6134D0@kernel.crashing.org>
	<20070727114559.GB11463@localhost.localdomain>
	<b3d36996792216ddd9dbae12212a4168@kernel.crashing.org>
	<20070801141614.ad6604bb.kim.phillips@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5e9344956c9e6d81f75d14d67064b78e@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC][PATCH] MPC832x_RDB: update dts to use spi,
	register mmc_spi stub
Date: Mon, 6 Aug 2007 20:25:13 +0200
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> +				max-speed-hz = <bebc20>; /* 12500000 Hz */
>>
>> Just max-speed.
>
> Segher, how is this different from:
>
> http://ozlabs.org/pipermail/linuxppc-dev/2007-April/034557.html

Not sure what you mean.  I'm just saying that "speed-hz" is a
terrible name, I'm not saying that "max-speed" is perfect at all.


Segher
