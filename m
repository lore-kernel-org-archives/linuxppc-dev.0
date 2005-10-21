Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 196EB685ED
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Oct 2005 04:33:28 +1000 (EST)
In-Reply-To: <200510212043.18615.rupert@ces.ch>
References: <200510211417.49651.rupert@ces.ch>
	<200510211711.02997.rupert@ces.ch>
	<B34FF652-6E5D-437D-812C-763B2D10C7CA@freescale.com>
	<200510212043.18615.rupert@ces.ch>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DEAB444E-A6E1-4733-9934-6DC99ABF5D87@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 21 Oct 2005 13:34:01 -0500
To: Rupert Eibauer <rupert@ces.ch>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH][RFT] please use this one
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 21, 2005, at 1:43 PM, Rupert Eibauer wrote:

> On Friday 21 October 2005 17:23, Kumar Gala wrote:
>
>>
>> On Oct 21, 2005, at 10:11 AM, Rupert Eibauer wrote:
>>
>>
>>> On Friday 21 October 2005 16:28, Kumar Gala wrote:
>>>
>>>
>>>> The concept of PPC_HIGH_BATS is already some what handled with
>>>> CPU_FTR_HAS_HIGH_BATS.  I recommend you use this feature instead of
>>>> introducing another one as well as a compile time option.
>>>>
>>>>
>>>
>>> CPU_FTR_HAS_HIGH_BATS only clears the high bats, but does
>>> not attempt to use them. My patch will use them.
>>>
>>
>> I understand, I'm suggesting you expand CPU_FTR_HAS_HIGH_BATS to
>> include your additional functionality.
>>
>
> How do you mean that exactly?
>
> Do you mean making the feature always-on (not selectable in Kconfig)?
> Having CONFIG_PPC_LARGE_BATS and CONFIG_HIGH_PATS always-on would
> be ok for me, but for PHYS_64BIT should be left up to the platform
> to decide if it should be presented to the user or not.

Yes, I think just making support for BATS 4-7 always on and use  
CONFIG_FTR_HAS_HIGH_BATS for any runtime fixup.

> Do you think the other two features, CPU_FTR_BIG_PHYS and
> CPU_FTR_LARGE_BATS should be merged into one bit? They could for now,
> because there is no processor supporting only one of them.

Yes, this should still be a config option.  Merging  
CPU_FTR_LARGE_BATS into CPU_FTR_BIG_PHYS should be ok.

- kumar
