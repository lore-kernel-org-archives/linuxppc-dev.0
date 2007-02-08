Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 89FD6DDE28
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 18:16:10 +1100 (EST)
In-Reply-To: <32F3CC26D4DAC44E8ECD07155727A46E8B7E55@zch01exm20.fsl.freescale.net>
References: <32F3CC26D4DAC44E8ECD07155727A46E8B7E55@zch01exm20.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <57721FE9-D85E-4FB6-AD5F-8342D99E7BD0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch][0/5] powerpc V2 : Add support to fully comply with
	IEEE-754 standard
Date: Thu, 8 Feb 2007 01:15:14 -0600
To: "Zhu Ebony-r57400" <ebony.zhu@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 8, 2007, at 1:06 AM, Zhu Ebony-r57400 wrote:

>
>
>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Thursday, February 08, 2007 1:19 PM
>> To: Zhu Ebony-r57400
>> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
>> Subject: Re: [patch][0/5] powerpc V2 : Add support to fully
>> comply with IEEE-754 standard
>>
>>
>> On Feb 7, 2007, at 9:50 PM, Zhu Ebony-r57400 wrote:
>>
>>> Hi Paul,
>>>
>>> These are the re-sent patches to add support to fully comply with
>>> IEEE-754 standard for E500/E500v2 core when hardware floating point
>>> compiling is used. Comparison with last patches I've submitted, the
>>> following points was changed:
>>>
>>> 1. Add a rounding exception handler, to handle the exceptions that
>>> would occur when rounding towards +Inf/-Inf
>>>
>>> 2. Using the existing exception entering/returning routine, and get
>>> the exception instructions from regs->nip instead of
>> reading from SRR0
>>>
>>> Thank you all for the comments you gave to me!
>>
>> Did you end up getting testfloat running?  I'd like to see
>> some testing results before accepting these patches.  I think
>> testfloat is our best bet at this point.
>>
> Hi Kumar,
>
> I looked into the testfloat suit, and found all the instructions it
> tests (more than 50)should be
> implemented based on ASM.

Don't follow?  Can't you build it with the e500 compiler?

> And also the SoftFloat test suite, which the
> Testfloat is comparing against, should be ported to powerpc  
> platform. I
> think these work needs some time do finish. So could you review my
> patches and
> give some comments first? Thank you.

Will do.  Just be aware we need to get testfloat running before this  
will make it in mainline.

- k
