Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id E57ECDDED7
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 02:22:19 +1000 (EST)
Message-ID: <46A8CAB2.5050706@ru.mvista.com>
Date: Thu, 26 Jul 2007 20:24:18 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2] [POWERPC] MPC8349E-mITX: use platform IDE driver
	for CF	interface
References: <20070725165318.5331.23795.stgit@localhost.localdomain>	<20070725165326.5331.19920.stgit@localhost.localdomain>	<46A78322.3080607@ru.mvista.com>
	<46A78E3F.1030904@ru.mvista.com>	<20070725180145.GA29689@ld0162-tx32.am.freescale.net>	<46A7941F.2050300@ru.mvista.com>
	<46A798D8.7020906@freescale.com> <46A7A4EC.2020503@ru.mvista.com>
In-Reply-To: <46A7A4EC.2020503@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello, I wrote:

>>>>>   Also, what mmio-ide in the compat properly means in the context 
>>>>>of ide_platform which is able to handle both port and memory mapped 
>>>>>IDE.

>>>>I/O-space is only valid in the context of PCI, ISA, or similar buses, 
>>>>and
>>>>the bus-specific reg format indicates whether it's mmio-space or
>>>>io-space.

>>>   You could save time on lecturing me (and use it to look on the 
>>>driver ;-).

>>Sorry, I misread the question as being a mismatch between the 
>>capabilities of the device binding and the driver, not about the 
>>specific compatible name.

>     That too. :-)

>>Something like "generic-ide" would probably be better.

>     I strongly disagree with "generic" part. The generic IDE could only be 
> said of 1:1 I/O mapped IDE ports, not about this fancy mapping.

    BTW, there's already something called drivers/ide/ide-generic.c... :-)

MBR, Sergei
