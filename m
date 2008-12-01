Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 66826DDD0B
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  1 Dec 2008 22:08:45 +1100 (EST)
Message-ID: <4933C5AF.5040406@embedded-sol.com>
Date: Mon, 01 Dec 2008 13:08:31 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Accessing PCI-E resources on 460EX
References: <490F6882.6050101@embedded-sol.com>
	<1228118085.7356.115.camel@pasglop>
In-Reply-To: <1228118085.7356.115.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Benjamin Herrenschmidt wrote:
> On Mon, 2008-11-03 at 23:09 +0200, Felix Radensky wrote:
>   
>> Hi,
>>
>> I'm currently struggling with some application
>> that tries to access PCI-E memory by mmaping
>> address found in /sys/bus/pci/devices/<device>/resource
>>
>> mmap() fails with "invalid argument" error, apparently
>> because on 460EX PCI addresses are 36-bit.
>>
>> What is the correct way of accessing PCI-E from
>> userspace on this platform.
>>     
>
> I fixed a lot of these problems recently. Can you try again with
> 2.6.28-latest-rc ?
>   

Thanks a lot for this input.
The problem is that I have a custom board with quite a few kernel 
modifications,
and I'm afraid it can take me some time to move from 2.6.26 to 2.6.28.
Any chance I can backport you modifications to 2.6.26 ? Have you modified
other files except arch/powerpc/sysdev/ppc4xx_pci.c to fix these problems ?

> Cheers,
> Ben.
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>   
