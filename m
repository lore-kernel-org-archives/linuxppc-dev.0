Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (unknown [195.144.244.147])
	by ozlabs.org (Postfix) with ESMTP id CDDEB67A75
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Mar 2005 18:35:56 +1100 (EST)
Message-ID: <422FF8D6.6060500@varma-el.com>
Date: Thu, 10 Mar 2005 10:35:50 +0300
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <422FEFBE.4070903@varma-el.com>
	<6bac59cd11e3d6fd005b8630e67bee33@freescale.com>
In-Reply-To: <6bac59cd11e3d6fd005b8630e67bee33@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Sylvain Munaut <tnt@246tNt.com>, paulus@samba.org,
	linuxppc-embedded@ozlabs.org
Subject: Re: RFC/Commit: New ocp id for CANbus devs
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ok, accepted, I'll be delayed until driver will be done.

Andrey

Kumar Gala wrote:
> I would assume you plan on moving your driver over to the driver model 
> which will make all of this moot.
> 
> So I think Sylvain's suggestion of allocating a number for the time 
> being makes the most sense until we get 52xx convert over to platform 
> devices.
> 
> - kumar
> 
> On Mar 10, 2005, at 12:57 AM, Andrey Volkov wrote:
> 
>> Sylvain Munaut wrote:
>>  >
>> >> Sylvain, but what I wish now - only single number
>>  >> (until driver will done).
>>  >
>> > If you only need a temporary ocp ID, just fix it youself in your local
>> > tree, no need to try to push that upstream.
>>
>> I already use it as temp, but I don't want pitfalls in future (when
>>  smb. take this number).
>>
>> Also, since CAN ocp present not only in MPC5200, but, AFAIK, in another
>> chips too, IMHO, it must be well known constant id.
>>
>> Regards
>>  Andrey
> 
> 
> 
