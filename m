Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A82A367A3E
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Mar 2006 05:25:06 +1100 (EST)
In-Reply-To: <200603202014.44879.hollis@penguinppc.org>
References: <20060320195945.004fdf26.kim.phillips@freescale.com>
	<200603202014.44879.hollis@penguinppc.org>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1DBAE58F-2152-4074-B9BA-ADB1FA63DD1B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add FSL SEC node to documentation
Date: Tue, 21 Mar 2006 12:25:55 -0600
To: Hollis Blanchard <hollis@penguinppc.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 20, 2006, at 8:14 PM, Hollis Blanchard wrote:

> On Monday 20 March 2006 19:59, Kim Phillips wrote:
>> diff --git a/Documentation/powerpc/booting-without-of.txt
> b/Documentation/powerpc/booting-without-of.txt
>> index d02c649..72f3241 100644
>> --- a/Documentation/powerpc/booting-without-of.txt
>> +++ b/Documentation/powerpc/booting-without-of.txt
>> @@ -1365,6 +1365,79 @@ platforms are moved over to use the flat
>>       };
>>
>>
>> +   g) Freescale SOC SEC Security Engines
>> +
>> +   Required properties:
>> +
>> +    - device_type : Should be "crypto"
>> +    - model : Model of the device.  Should be "SEC1" or "SEC2"
>> +    - compatible : Should be "talitos"
> [snip]
>
> Have you consulted with any other vendors regarding these  
> properties? I know
> there is no IEEE1275 binding for these sorts of devices, but we can  
> at least
> attempt to standardize it (even in the absence of the Open Firmware  
> Working
> Group)...

Beyond the device_type, I'm not sure if there is much more one could  
standardize one.  The other fields that Kim spec'd are either generic  
OF fields (reg, interrupts, etc.) or specific to the Freescale devices.

- kumar
