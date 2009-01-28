Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B56AFDDFCC
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jan 2009 06:18:23 +1100 (EST)
Message-Id: <F9EA18FC-BFF5-46A6-BD6D-7AD213192AE8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: =?ISO-8859-1?Q?R=E9gis_Odey=E9?= <regis.odeye@kontron.com>
In-Reply-To: <4980A076.3030905@kontron.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: MPIC Timers as clocksource
Date: Wed, 28 Jan 2009 13:17:55 -0600
References: <49806DE7.6090101@kontron.com>
	<9FE267F5-A95D-475D-A4EE-DD9174E6AC9E@kernel.crashing.org>
	<4980A076.3030905@kontron.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 28, 2009, at 12:14 PM, R=E9gis Odey=E9 wrote:

> Kumar Gala wrote:
>>
>> On Jan 28, 2009, at 8:38 AM, R=E9gis Odey=E9 wrote:
>>
>>> Hi everybody,
>>> Is there anyone who implemented a clocksource driver (drivers/=20
>>> clocksource) to deal with the MPIC timers especially with 86xx and =20=

>>> 85xx soc's ?
>>> Regards.
>>>
>>> --
>>
>> We have some code for using the timers but not as a clocksource.. =20
>> Out of interest why do want this?
>>
>> - k
> We have a plan to use an external clock signal to drive those =20
> timers. This signal is common with other boards in a same enclosure =20=

> so we could synchronize our boards with those timers.
> Could you point me out to the related code even if there is some =20
> adaptations to get a clocksource driver.

I'll post some code.

As for clocksource.. last time I looked at that it was more about =20
using a timer as the single kernel reference clock.

- k=
