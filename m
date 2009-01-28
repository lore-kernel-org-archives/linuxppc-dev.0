Return-Path: <Regis.Odeye@kontron.com>
Received: from mail.kontron-modular.com (mail.kontron-modular.com
	[213.179.130.140]) by ozlabs.org (Postfix) with ESMTP id 2644ADDFC2
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jan 2009 05:14:17 +1100 (EST)
Message-ID: <4980A076.3030905@kontron.com>
Date: Wed, 28 Jan 2009 19:14:14 +0100
From: =?ISO-8859-1?Q?R=E9gis_Odey=E9?= <regis.odeye@kontron.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: MPIC Timers as clocksource
References: <49806DE7.6090101@kontron.com>
	<9FE267F5-A95D-475D-A4EE-DD9174E6AC9E@kernel.crashing.org>
In-Reply-To: <9FE267F5-A95D-475D-A4EE-DD9174E6AC9E@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>
> On Jan 28, 2009, at 8:38 AM, Régis Odeyé wrote:
>
>> Hi everybody,
>> Is there anyone who implemented a clocksource driver 
>> (drivers/clocksource) to deal with the MPIC timers especially with 
>> 86xx and 85xx soc's ?
>> Regards.
>>
>> --
>
> We have some code for using the timers but not as a clocksource.. Out 
> of interest why do want this?
>
> - k
We have a plan to use an external clock signal to drive those timers. 
This signal is common with other boards in a same enclosure so we could 
synchronize our boards with those timers.
Could you point me out to the related code even if there is some 
adaptations to get a clocksource driver.
Regards.

-- 
Régis ODEYE

Kontron Modular Computers SA
150, rue M. Berthelot / ZI Toulon Est / BP 244 / Fr 83078 TOULON Cedex 9
Phone: (33) 4 98 16 34 86           Fax: (33) 4 98 16 34 01
E-mail: regis.odeye@kontron.com  Web : www.kontron.com
