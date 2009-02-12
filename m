Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B057BDDF01
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 10:52:07 +1100 (EST)
Message-Id: <F0245D03-4191-4482-B007-603C3DAC8A1A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <3A45394FD742FA419B760BB8D398F9ED1D2D8B@zch01exm26.fsl.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc/83xx: Revive Marvell PHY option on MPC8313E-RDB
	rev. C boards
Date: Thu, 12 Feb 2009 17:51:57 -0600
References: <20090205201040.GB3425@oksana.dev.rtsoft.ru>
	<2a27d3730902082347n7f0eb48dq8c4ecccda290f9c8@mail.gmail.com>
	<ED186496-3882-4E87-9BEC-B56FE09C5827@kernel.crashing.org>
	<20090210151047.GA25086@oksana.dev.rtsoft.ru>
	<60C07231-C830-440E-8425-D3069AB3620B@kernel.crashing.org>
	<3A45394FD742FA419B760BB8D398F9ED1D2D8B@zch01exm26.fsl.freescale.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 11, 2009, at 11:40 PM, Li Yang-R58472 wrote:

>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Thursday, February 12, 2009 1:25 PM
>> To: Li Yang-R58472
>> Cc: linuxppc-dev list; Anton Vorontsov
>> Subject: Re: [PATCH] powerpc/83xx: Revive Marvell PHY option
>> on MPC8313E-RDB rev. C boards
>>
>>
>> On Feb 10, 2009, at 9:10 AM, Anton Vorontsov wrote:
>>
>>>
>>> Li, thanks for heads-up!
>>>
>>> One thing though: documentation says that Marvell PHY
>> address is 0x3,
>>> while old device tree and this patch:
>>>
>>>
>> http://www.bitshrine.org/gpp/linux-fsl-2.6.23-MPC8313ERDB-add- 
>> default-
>>> dts.patch
>>>
>>> says "0x1"... I don't have any rev. C boards, so it would
>> be great if
>>> somebody could confirm that 0x1 is the actual address.
>
> The correct address is 0x3.  The previous patch in revB BSP used a  
> guess
> value before the revC documentation is available.  The latest BSP has
> been updated to use the correct address.

Anton, will you spin a new patch with this change?

- k
