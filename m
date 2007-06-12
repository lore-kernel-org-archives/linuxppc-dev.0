Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8012DDDE24
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 23:25:44 +1000 (EST)
In-Reply-To: <1181628239.25503.15.camel@mark>
References: <989B956029373F45A0B8AF0297081890D2AA5B@zch01exm26.fsl.freescale.net>
	<1181628239.25503.15.camel@mark>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <ABFDA397-8D79-4FFC-86DB-27C7C5DB7F42@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 5/6]: 82xx: Add the support of Wind River SBC PowerQUICCII
	82xx
Date: Tue, 12 Jun 2007 08:26:08 -0500
To: Mark Zhan <rongkai.zhan@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> I don't believe the following are necessary.  New MTD mapping  
>> should be
>> defined in device tree.
>>
>
> Oh, here I just want to document the memory mapping for this board. I
> think, even we already have devtree, it is a good idea that we always
> document the H/W setting in platform header file, which will  
> definitely
> make life easier.

There is no requirement that you use the device tree for MTD.  If you  
decided that for your board port that you just want it hard coded in  
the code that is perfectly fine.

- k
