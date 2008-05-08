Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id BF720DDF03
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 May 2008 23:14:18 +1000 (EST)
Message-ID: <4822F5DE.80502@coritel.it>
Date: Thu, 08 May 2008 14:45:18 +0200
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: Sanal Kumar V K <sanalvk@centillium.com>
Subject: Re: Running a section of code from internal memory
References: <4822E5CE.3090701@centillium.com>
In-Reply-To: <4822E5CE.3090701@centillium.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sanal Kumar V K ha scritto:
> Hi All,
> 
> I am porting a GW/router application to embedded Linux for a product
> based on SoC; following is the version information:
> 
> kernel: 2.6.10
> uClibc: 0.9.27
> gcc: 3.4.3
> binutils: 2.15.94.0.2.2
> 
> A small part of the code needs to run from the on-chip "L2 scratch" for
> getting optimum performance. I would really appreciate if some could
> give me some pointers regarding the following questions:
> 
> 1. Is #pragma section supported by gcc.
> The compiler prints this warning "ignoring #pragma section" and the
> pragma is ignored indicating that it is not supported. Is there any way
> I can get the pragma working for gcc or any alternative?
> 
> 2. Is there any patch available to modify the kernel thread creation so
> as to place the stack and tcb in the user configured addresses for
> kernel threads (similar to taskInit() in VxWorks)?
> 
> Thanks in advance,
> Sanal
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
I think at application level you can use the #pragma directive but I'm 
sure that you can't use this directive at kernel level.
