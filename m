Return-Path: <bj@mhlabs.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CB6EAB6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 Aug 2009 16:15:12 +1000 (EST)
Received: from mhsecure.serverpowered.net (mhsecure.serverpowered.net
	[204.8.182.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7F31FDDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2009 16:15:11 +1000 (EST)
Message-Id: <035EB555-8914-48CD-BFCB-DDDA4FDD1794@mhlabs.com>
From: "B.J. Buchalter" <bj@mhlabs.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <705D9914-7AC7-42AB-A7F9-AD2447B9DDD8@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: Problem with PCIe -> PCI bridge on MPC8377E-RDB
Date: Wed, 12 Aug 2009 02:14:56 -0400
References: <4D3BDC67-986A-482D-BB3F-497F64C68531@mhlabs.com>
	<9E566D12-1A26-41BC-BB71-27D4CCE54E20@kernel.crashing.org>
	<2D2EDFA8-E51F-4A2D-BEB7-8F9258518DA1@mhlabs.com>
	<705D9914-7AC7-42AB-A7F9-AD2447B9DDD8@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 12, 2009, at 1:20 AM, Kumar Gala wrote:

>
> On Aug 11, 2009, at 10:25 PM, B.J. Buchalter wrote:
>
>> I don't know the model of the board off the top of my head.
>>
>> I do know that it uses the Texas Instruments XIO2000A/XIO2200 PCI  
>> Express-to-PCI Bridge (rev 03), with the TSB82AA2 OHCI Link behind  
>> the bridge.
>>
>> The same board definitely works as expected in a Mac Pro.
>>
>> In doing some Google searches about this, I have seen the TI part  
>> listed in the PCI configuration of folks running linux (though  
>> probably on Intel) and apparently having no problems with the  
>> busses behind the bridge being enumerated.
>>
>> I am guessing that the problem is related the the PCIe root complex  
>> on the 8377, but I am just guessing.
>>
>> Is PCIe known to work on the MPC837x?
>
> It is suppose to.  I would recommend updating u-boot to something  
> newer and see what you get on that side.

Ok -- I can try that; I have been using the u-boot that shipped with  
the board to avoid having to worry about wiping out the boot-load  
accidently.

> Also I'll try see if we have a PCIe board w/a p2p bridge on it.  I'm  
> guessing no one has tried PCIe on 83xx w/a p2p bridge on it.

I see. A lot of the FireWire parts are based upon p2p bridges...

Thanks!

B.J. Buchalter
	
