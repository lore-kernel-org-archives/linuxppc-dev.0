Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 87CD8DDD0A
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 11:45:34 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1J04rr-0001Z3-PG
	for linuxppc-dev@ozlabs.org; Wed, 05 Dec 2007 16:45:31 -0800
Message-ID: <14184234.post@talk.nabble.com>
Date: Wed, 5 Dec 2007 16:45:31 -0800 (PST)
From: sivaji <rameshmrm@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Regarding MPC8641D
In-Reply-To: <1196874416.32356.3.camel@kaboom.lisle.iphase.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <14166848.post@talk.nabble.com>
	<1196874416.32356.3.camel@kaboom.lisle.iphase.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hai,
             The kernel was compiled in SMP mode. The low memory offset mode
is only for AMP mode means, then how we test both the core 0 and 1 in the
linux kernel ?. Asper my understanding if we enable the Low Memory Offset
mode, then only the core1 translation is enabled. If we disalbed the Low
Memory offset mode, Only Core 0  will work in SMP mode and Core 1 will idle.
If we want to test the efficient of Dual core means we need to enable both
the core and Low Memory Offset Mode. For this configuration linux kernel was
not up.
( Please correct me if I am wrong )

Thanks and Regards
Sivaji


Chris Fester wrote:
> 
> On Tue, 2007-12-04 at 23:51 -0800, sivaji wrote:
>>             We have designed  a MPC8641D based AMC card. We are using the
>> kernel (2.6.23-rc4) and uboot (1.2.0).  When we disable the core1 Low
>> Memory
>> offset mode the kernel was up and when we enable this core1 Low Memory
>> offset mode kernel was not up, It was hang after MPIC initialization.
> [snip!]
>>                      After this the kernel was hang, i want to know why
>> kernel was hang when we enalbe Low memory Offset mode. Please help me to
>> fix
>> this issue.
> 
> Have you compiled your kernel for SMP mode?  I believe the Low memory
> offset mode is only for AMP mode (vxworks can use this, probably other
> OSes).  I don't know if the kernel has support for any multiprocessing
> mode other than SMP.
> 
> Hope that helps,
> Chris
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 

-- 
View this message in context: http://www.nabble.com/Regarding-MPC8641D-tf4948004.html#a14184234
Sent from the linuxppc-dev mailing list archive at Nabble.com.
