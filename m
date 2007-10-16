Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3AE2BDDED2
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 15:06:17 +1000 (EST)
In-Reply-To: <200710160640.47010.sr@denx.de>
References: <7DBC0977-0367-40F5-8A30-ACA02FD4E9FA@kernel.crashing.org>
	<200710160640.47010.sr@denx.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B9E8682B-5455-48EA-B078-CB0EDCB2060A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: boards in arch/ppc -> arch/powerpc for 85xx
Date: Tue, 16 Oct 2007 00:06:30 -0500
To: Stefan Roese <sr@denx.de>
Cc: David Woodhouse <dwmw2@infradead.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 15, 2007, at 11:40 PM, Stefan Roese wrote:

> Hi Kumar,
>
> On Tuesday 16 October 2007, Kumar Gala wrote:
>> I was wondering if you cared about the following boards existing in
>> arch/powerpc:
>>
>> * STX GP3
>> * TQM 85xx
>> * SBC 8560
>>
>> I'm told WR doesn't care about the SBC 8560, so I'll see if David  
>> does.
>>
>> I'm willing to look into doing the port over, but would need some
>> help testing.
>
> Yes, it would be greatly appreciated if you could start this  
> TQM85xx port. I
> will of course do the testing.

Ok, for the TQM85xx code in arch/ppc can I get a few things from you:

1. what processors does this actually support/run on.  I'm guessing  
MPC8541, MPC8555?  But not really sure
2. can you send the results of a bd_info from u-boot on the board
3. can you send me the results of cat /proc/iomem & /proc/ioports  
from a linux boot.

thanks

- k
