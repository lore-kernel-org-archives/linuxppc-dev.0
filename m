Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 23FFCDDED2
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 09:47:59 +1000 (EST)
In-Reply-To: <0c3907573f12a0731d03335fe3334363@kernel.crashing.org>
References: <1179245829.8132.100.camel@rhino> <1179246470.8132.112.camel@rhino>
	<1179333421.7018.17.camel@ld0161-tx32>
	<b77c4b3dd22795a73cd32a0623722e51@kernel.crashing.org>
	<1179346653.8132.223.camel@rhino>
	<0c3907573f12a0731d03335fe3334363@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <de11cd25e499f5bb07607e5ae9d60b2f@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/5] Add legacy devices to mpc8641_hpcn.dts
Date: Thu, 17 May 2007 01:47:40 +0200
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> +			isa@f0 {
>>>
>>> isa@1e
>
> You didn't reply to this one, but you *really* need
> to fix it.

Oh you did reply, heh.

>> Is there a recommended "compatible" property for a standard PC-like
>> CMOS
>> RTC?
>
> None in the bindings that I know of.  It typically would
> be the model name/number of the oldest chip used, or one
> that is very commonly used.

"pnpPNP,b00"


Segher
