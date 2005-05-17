Return-Path: <gautran@mrv.com>
Received: from mailman.xyplex.com (mailman.xyplex.com [140.179.176.116])
	by ozlabs.org (Postfix) with ESMTP id 8277D679F5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 May 2005 22:10:10 +1000 (EST)
Message-ID: <4289DF4F.4060301@mrv.com>
Date: Tue, 17 May 2005 08:10:55 -0400
From: Guillaume Autran <gautran@mrv.com>
MIME-Version: 1.0
To: Pantelis Antoniou <panto@intracom.gr>
References: <20050517081558.74BA0C1512@atlas.denx.de>
	<4289A635.5000509@intracom.gr>
In-Reply-To: <4289A635.5000509@intracom.gr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC885 - USB HCI drivers.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Pantelis,

Are your drivers compatible with linux kernel 2.6.x ?
I'll be interested to have a look at them if you don't mind.

Also, do you think an USB bus analyzer is a *must have* in order to work 
on the drivers ?

Regards,
Guillaume.


Pantelis Antoniou wrote:

> Wolfgang Denk wrote:
>
>> Dear Mike,
>>
>> in message <428995CB.4050301@compulab.co.il> you wrote:
>>
>>> Do you know if the same is applicable to CPM2 USB controllers 
>>> present for example on mpc8247?
>>
>>
>>
>> Sorry, I don't know from personal experience. But from what  I  heard
>> there might be some "surprises", too.
>>
>>
>>> The Freescale sales representative we work with actually says that 
>>> CPM2 USB host controller is working well.
>>
>>
>>
>> Of course they do. They say the same for the 850 and 823 :-(
>>
>> Best regards,
>>
>> Wolfgang Denk
>>
>
> Well I have USB host drivers for both 8xx & 82xx working.
>
> It was not a piece of cake exactly to get them to work
> but they seem to work fine even under heavy traffic.
>
> However I use them connected to a specific peripheral
> so I don't know how well they fare when used as a PC
> style USB host controller.
>
> YMMV
>
> Regards
>
> Pantelis
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

-- 
=======================================
Guillaume Autran
Senior Software Engineer
MRV Communications, Inc.
Tel: (978) 952-4932 office
E-mail: gautran@mrv.com
======================================= 
