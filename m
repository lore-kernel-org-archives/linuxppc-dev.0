Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6A200DDF3D
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2007 04:56:51 +1000 (EST)
In-Reply-To: <4630D9AB.2040605@mvista.com>
References: <20070425213700.GA8814@blade.az.mvista.com>
	<20070426000852.GA2193@localhost.localdomain>
	<20070426003748.GA30730@blade.az.mvista.com>
	<9903F55A-5E4E-42CE-8C27-6B7143B9FE25@kernel.crashing.org>
	<4630D9AB.2040605@mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e359e43198096bc73cdac058c6e5ad6d@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add EDAC platform devices for 85xx
Date: Thu, 26 Apr 2007 20:56:35 +0200
To: Dave Jiang <djiang@mvista.com>
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au,
	bluesmoke-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +		mem-ctrl@2000 {
>>> +			device_type = "mem-ctrl";
>>> +			compatible = "85xx";
>>>
>> I'm concerned this is too generic.
>>
> I'm supposing not all 85xx uses the same soc? Is there something more
> appropriate you can suggest? Thx!

"name" = "memory-controller"
"compatible" = "fsl,85xx-memory-controller"
(or a more specific 85xx model if the controller
isn't identical across those chips)
No "device_type" at all, since there is no binding
for this kind of device.


Segher
