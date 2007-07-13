Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 75BBCDDDF7
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jul 2007 03:17:29 +1000 (EST)
Message-ID: <4697B421.6010005@ru.mvista.com>
Date: Fri, 13 Jul 2007 21:19:29 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2.6.21-rt2] PowerPC: revert fix for threaded fasteoi	IRQ
	handlers
References: <200611192243.34850.sshtylyov@ru.mvista.com>	
	<200705171719.34968.sshtylyov@ru.mvista.com>	
	<46965B28.7000703@ru.mvista.com> <1184259173.12353.227.camel@chaos>
In-Reply-To: <1184259173.12353.227.camel@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, mingo@elte.hu, linux-kernel@vger.kernel.org,
	dwalker@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Thomas Gleixner wrote:

>>    Now that the -rt patch has been first release in the broken-out version, 
>>let me tell you that the following 3 patches in the series can be just 
>>annihilated:

>>preempt-irqs-ppc-ack-irq-fixups.patch
>>preempt-irqs-ppc-fix-b5.patch
>>preempt-irqs-ppc-fix-more-fasteoi.patch

>>as all that the latter two are doing is undoing the former one.

> Really ? I know for quite a while. 

    Just reminding. :-)

> We kept some of those files to document contributions. Go read back on
> the LKML archives, where we were accused more than once not to keep
> track of these things.

    Yeah, I figured that out. This case is somewhat special though since the 
patch that started this should't even have been there in the firts place.

> They can be folded together and fixed up, one thing after the other
> please.

    OK, no hurry. :-)

> 	tglx

WBR, Sergei
