Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 62ACF68654
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Oct 2005 01:22:42 +1000 (EST)
In-Reply-To: <200510211711.02997.rupert@ces.ch>
References: <200510211417.49651.rupert@ces.ch>
	<200510211442.08477.rupert@ces.ch>
	<30B37541-CAC4-4052-B33D-AE1373C16FD3@freescale.com>
	<200510211711.02997.rupert@ces.ch>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B34FF652-6E5D-437D-812C-763B2D10C7CA@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 21 Oct 2005 10:23:16 -0500
To: "Rupert Eibauer" <rupert@ces.ch>
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


On Oct 21, 2005, at 10:11 AM, Rupert Eibauer wrote:

> On Friday 21 October 2005 16:28, Kumar Gala wrote:
>
>> The concept of PPC_HIGH_BATS is already some what handled with
>> CPU_FTR_HAS_HIGH_BATS.  I recommend you use this feature instead of
>> introducing another one as well as a compile time option.
>>
>
> CPU_FTR_HAS_HIGH_BATS only clears the high bats, but does
> not attempt to use them. My patch will use them.

I understand, I'm suggesting you expand CPU_FTR_HAS_HIGH_BATS to  
include your additional functionality.

- kumar
