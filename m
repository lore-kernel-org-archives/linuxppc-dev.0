Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 22B99DDE1F
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 23:24:22 +1000 (EST)
In-Reply-To: <18199.60025.563689.10810@cargo.ozlabs.ibm.com>
References: <200710181108.19413.yur@emcraft.com>
	<18199.60025.563689.10810@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E0BC0C69-03B1-4F7A-9DEC-0EA9DAC92FB7@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] ppc44x: support for 256K PAGE_SIZE
Date: Fri, 19 Oct 2007 08:24:38 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 18, 2007, at 6:21 PM, Paul Mackerras wrote:

> Yuri Tikhonov writes:
>
>> The following patch adds support for 256KB PAGE_SIZE on ppc44x- 
>> based boards.
>> The applications to be run on the kernel with 256KB PAGE_SIZE have  
>> to be
>> built using the modified version of binutils, where the MAXPAGESIZE
>> definition is set to 0x40000 (as opposite to standard 0x10000).
>
> Have you measured the performance using a 64kB page size?  If so, how
> does it compare with the 256kB page size?

I was wondering about this as well?  Isn't this technically in  
violation of the ABI?

- k
