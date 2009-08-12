Return-Path: <bj@mhlabs.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 94F19B7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 Aug 2009 13:26:05 +1000 (EST)
Received: from mhsecure.serverpowered.net (mhsecure.serverpowered.net
	[204.8.182.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 35B20DDD0C
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2009 13:26:05 +1000 (EST)
Message-Id: <2D2EDFA8-E51F-4A2D-BEB7-8F9258518DA1@mhlabs.com>
From: "B.J. Buchalter" <bj@mhlabs.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <9E566D12-1A26-41BC-BB71-27D4CCE54E20@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: Problem with PCIe -> PCI bridge on MPC8377E-RDB
Date: Tue, 11 Aug 2009 23:25:55 -0400
References: <4D3BDC67-986A-482D-BB3F-497F64C68531@mhlabs.com>
	<9E566D12-1A26-41BC-BB71-27D4CCE54E20@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 11, 2009, at 9:43 PM, Kumar Gala wrote:

>
> On Aug 11, 2009, at 5:27 PM, B.J. Buchalter wrote:
>
>>
>> I have been trying to use a PCIe FireWire card on a MPC8377E-RDB  
>> board.
>
> is this an off the shelf PCIe FireWire card?

Yes.

> If so which one?


I don't know the model of the board off the top of my head.

I do know that it uses the Texas Instruments XIO2000A/XIO2200 PCI  
Express-to-PCI Bridge (rev 03), with the TSB82AA2 OHCI Link behind the  
bridge.

The same board definitely works as expected in a Mac Pro.

In doing some Google searches about this, I have seen the TI part  
listed in the PCI configuration of folks running linux (though  
probably on Intel) and apparently having no problems with the busses  
behind the bridge being enumerated.

I am guessing that the problem is related the the PCIe root complex on  
the 8377, but I am just guessing.

Is PCIe known to work on the MPC837x?

Thanks!

B.J. Buchalter
