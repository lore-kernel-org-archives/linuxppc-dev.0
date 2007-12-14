Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 09C6ADDF33
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Dec 2007 05:23:30 +1100 (EST)
Message-ID: <4762CA10.5040507@freescale.com>
Date: Fri, 14 Dec 2007 12:23:12 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/3] mpc82xx: Embedded Planet EP8248E support
References: <20071211212247.GB3620@loki.buserror.net>
	<EB293853-B27A-4B0E-AEEB-8D3F09E8F12D@kernel.crashing.org>
	<20071214155341.GB16269@ld0162-tx32.am.freescale.net>
	<5898D87A-231D-4CCB-9538-808562F08D57@kernel.crashing.org>
In-Reply-To: <5898D87A-231D-4CCB-9538-808562F08D57@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Dec 14, 2007, at 9:53 AM, Scott Wood wrote:
> 
>> On Thu, Dec 13, 2007 at 11:19:33PM -0600, Kumar Gala wrote:
>>> Can we make this a /dts-v1/; since its new.
>>
>> It's not really new; it's just been collecting dust for a while. :-P
> 
> Its new to us on the list :P

I thought it got sent out at least once a long time ago...

In any case, I thought that one of the main reasons for the version tag 
is so that the whole world doesn't have to switch at once?

>> Are there any tools to autoconvert (preferably without losing comments)?
> 
> Not sure of jon had a perl script or something.

Jon, anything?

>>>> +/ {
>>>> +    model = "EP8248E";
>>>> +    compatible = "fsl,ep8248e";
>>>> +    #address-cells = <1>;
>>>> +    #size-cells = <1>;
>>>
>>> Add a aliases { } and can we use that instead of linux,network-index
>>> and linux,planetcore-label.
>>
>> I don't see any support in the current bootwrapper for aliases.
> 
> Yeah, I was hoping you'd code something up :)

I'll leave that to those who actually care about using aliases. :-)

-Scott
