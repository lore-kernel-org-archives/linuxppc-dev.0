Return-Path: <greg.weeks@timesys.com>
Received: from exchange.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id 8608167A6C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Mar 2005 06:23:53 +1100 (EST)
Message-ID: <42373644.4060006@timesys.com>
Date: Tue, 15 Mar 2005 14:23:48 -0500
From: Greg Weeks <greg.weeks@timesys.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <4237320D.9040200@timesys.com> <423732E1.2090906@mvista.com>
In-Reply-To: <423732E1.2090906@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: [patch] mpc8560ads mtd map
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Mark A. Greer wrote:

> Greg Weeks wrote:
>
>>
>> Add an MTD map for the flash on the mpc8560ads board.
>>
>> Signed-off-by: Greg Weeks <greg.weeks@timesys.com> 
>
>
>
> <snip>
>
> Most of the code in this patch can be eliminated if you set up the 
> table in your platform file and use the proper CONFIG_MTD_xxx options.
>
> Mark
>
Yep, I pulled this off our 2.6.4 kernel tree. I think it should be in 
the platform code, but I've not tried moving it yet. That should get rid 
of the map file and the Kconfig changes to support it.

Greg Weeks
