Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 31C8BDDF23
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 01:47:42 +1000 (EST)
In-Reply-To: <200710191937.23638.yur@emcraft.com>
References: <200710181108.19413.yur@emcraft.com>
	<18199.60025.563689.10810@cargo.ozlabs.ibm.com>
	<200710191937.23638.yur@emcraft.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D3506DCC-01F5-48C1-900D-2D827AB6BE19@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] ppc44x: support for 256K PAGE_SIZE
Date: Fri, 19 Oct 2007 10:48:01 -0500
To: Yuri Tikhonov <yur@emcraft.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 19, 2007, at 10:37 AM, Yuri Tikhonov wrote:

> On Friday 19 October 2007 03:21, Paul Mackerras wrote:
>> Have you measured the performance using a 64kB page size?  If so, how
>> does it compare with the 256kB page size?
>
>  I measured the performance of the sequential full-stripe write  
> operations to
> a RAID-5 array (P values below are in MB per second) using the h/w  
> accelerated
> RAID-5 driver.
>
>  Here are the comparative results for the different PAGE_SIZE values:
>
> PAGE_SIZE = 4K:
>  P = 66 MBps;
>
> PAGE_SIZE = 16K:
>  P = 145 MBps;
>
> PAGE_SIZE = 64K:
>  P = 196 MBps;
>
> PAGE_SIZE = 256K:
>  P = 217 MBps.

Is this all in kernel space? or is there a user space aspect to the  
benchmark?

>> The 64kB page size has the attraction that no binutils changes are
>> required.
>
>  That's true, but the additional performance is an attractive thing  
> too.

- k
