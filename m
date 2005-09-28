Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 9ED0668336
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Sep 2005 01:34:27 +1000 (EST)
In-Reply-To: <1CFEB358338412458B21FAA0D78FE86D4F0DF7@rennsmail02.eu.thmulti.com>
References: <1CFEB358338412458B21FAA0D78FE86D4F0DF7@rennsmail02.eu.thmulti.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <06E75914-965A-4D05-A36A-717891EF8051@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Date: Wed, 28 Sep 2005 10:34:37 -0500
To: Fillod Stephane <stephane.fillod@thomson.net>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: How to use SPE on MPC8541
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Sep 28, 2005, at 03:12, Fillod Stephane wrote:

> Bonjour G=E9rard,
>
> G=E9rard Gu=E9vel wrote:
>
>> I don't especially want to see if the bit is set, I just want
>> to improve the board performance for a Linux application :-).
>>
>
> Do you know where your CPU is spending much of its time?
> It looks like a job for OProfile. Support for e500 exists in 2.6.x
> thanks to the fine folks of Freescale. We appreciate their involvement
> in OSS community.


Yeah, oprofile would probably help here.

>
>> with the standard glibc (strcpy, strcmp, ...) on one part, and with
>> the freescale SPE library on the other part (vstrcpy, vstrcmp, ...).
>>
>
> Will the SPE enhanced C library calls will be integrated in Glibc =20
> one day?
>

I don't think the glibc people integrate processor-specific changes, =20
so it's not likely.

Andy=
