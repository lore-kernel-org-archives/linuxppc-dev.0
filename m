Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 486AD68714
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Nov 2005 02:49:54 +1100 (EST)
In-Reply-To: <437A016C.8070405@ru.mvista.com>
References: <a79669360510062205v629affb9ga687078f018afae@mail.gmail.com>		<200510120859.12362.sr@denx.de>	<434CB71E.5000603@compulab.co.il>		<200510120927.56692.sr@denx.de>		<20051012133414.7f7e2faf.ajz@cambridgebroadband.com>		<4365BD71.9010507@compulab.co.il>	<1131960060.7748.9.camel@hawk.pwav.net>	<43798741.5070604@compulab.co.il>
	<D95D5881-250C-4B54-BD5A-54C79D9E0496@kernel.crashing.org>
	<437A016C.8070405@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F9559612-EC8F-44BB-BA15-05DB48D4F031@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Wed, 16 Nov 2005 09:50:18 -0600
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC8555 USB host support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hmm, we should understand what caveats it has and still look at  
getting it into mainline.

Also, are you aware of Freescale's driver for this?

- kumar

On Nov 15, 2005, at 9:40 AM, Vitaly Bordug wrote:

> Kumar Gala wrote:
>> Any reason not to get this driver into the kernel main line?
> I guess because this device is known to work in some specific  
> instance, but bot generic one. The best we can do is to consolidate  
> our efforts to make it more usable or state that it is impossible.
>
>> - kumar
>> On Nov 15, 2005, at 12:59 AM, Mike Rapoport wrote:
>>> Hans Schillstrom wrote:
>>>
>>>> Hi Mike
>>>> I'm working with a 8270 board and 2.6.12 kernel and searching  
>>>> for USB
>>>> drivers.
>>>>
>>>> Could you help me finding the files ?
>>>>
>>> I've opened a project on the SourceForge, http:// 
>>> cpm2usb.sourceforge.net. The file containing patch against  
>>> 2.6.12.3 can be downloaded at http://sourceforge.net/projects/ 
>>> cpm2usb.
>>>
>>>> I can help you with the testing.
>>>> What status do they have right now ?
>>>>
>>> The driver was developed on MPC8272ADS, but should go as well on  
>>> 8270 since they have the same USB host controller AFAIK.
>>> Currently, as far as I tested it works fine with full-speed  
>>> single device attached through hub, but fails is there are  
>>> transfers from/to several devices simultaneously.
>>> As for the code itself, it's far from being perfect.
>>>
>>>> Regards Hans
>>>>
>>>
>>>
>>> --Sincerely yours,
>>> Mike Rapoport
>>>
>>>
>>> _______________________________________________
>>> Linuxppc-embedded mailing list
>>> Linuxppc-embedded@ozlabs.org
>>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
> -- 
> Sincerely,
> Vitaly
