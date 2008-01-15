Return-Path: <linux@sundmangroup.com>
Received: from proxy2.bredband.net (proxy2.bredband.net [195.54.101.72])
	by ozlabs.org (Postfix) with ESMTP id B2BA9DDE09
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Jan 2008 21:59:30 +1100 (EST)
Received: from ironport.bredband.com (195.54.101.120) by proxy2.bredband.net
	(7.3.127) id 47285ABF0194F415 for linuxppc-embedded@ozlabs.org;
	Tue, 15 Jan 2008 11:38:51 +0100
Message-ID: <478C8D38.3090602@sundmangroup.com>
Date: Tue, 15 Jan 2008 11:38:48 +0100
From: Matias Sundman <linux@sundmangroup.com>
MIME-Version: 1.0
CC: linuxppc-embedded@ozlabs.org
Subject: Re: PPC vs POWERPC
References: <23145.147.11.3.128.1200054808.squirrel@www.sundmangroup.com>
	<fa686aa40801110652s67b2a05al79f78144c5b527bd@mail.gmail.com>
In-Reply-To: <fa686aa40801110652s67b2a05al79f78144c5b527bd@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 >>Documentation/powerpc/booting-without-of.txt to find out what is
 >>expected in the device tree.

Is there any more information on how the "of_*" ( e.g. of_node_put ,  
of_find_node_by_type ) functions should be implemented in  the 
"arch/powerpc/platforms/myplatform/myboard_setup.c" file
or is the documentation the existing "*.c" c files under 
arch/powerpc/platforms ?

Since I have a 82xx board I assume that "myboard_setup.c" file shall be 
put under arch/powerpc/platforms/82xx.

Cheers // Matias


Grant Likely skrev:
> On 1/11/08, samppa@sundmangroup.com <samppa@sundmangroup.com> wrote:
>   
>> Hi,
>> I want to port a board ( WRS SBC8265 ) from the PPC branch to the POWERPC
>> branch in the Linux Kernel -- do you have any good starting points that
>> describes what I need to pay attention to?
>>
>> I've already made a port of U-boot-1.3.1 and enabled CONFIG_OF_LIBFDT.
>>
>> So I need to create a DTS file, compile it with the DTC compiler and port
>> the current PPC branch to the POWERPC branch to my understanding.
>>     
>
> Yes, you're exactly right.  Use one of the dts files in
> arch/powerpc/boot/dts as a starting point and read
> Documentation/powerpc/booting-without-of.txt to find out what is
> expected in the device tree.
>
> Cheers,
> g.
>
>   
