Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E85C467A01
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Mar 2006 03:59:38 +1100 (EST)
In-Reply-To: <004901c64207$a31403c0$6401a8c0@CHUCK2>
References: <927594BA71733F4BAA815162B79A3F513B2958@ala-mail04.corp.ad.wrs.com>
	<BAB64425-65CD-4311-9A93-004EBA27729A@kernel.crashing.org>
	<004901c64207$a31403c0$6401a8c0@CHUCK2>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <84F54A3B-0B2A-45B5-968D-68266C6EDEDA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Calling PCI Autoconfig again
Date: Tue, 7 Mar 2006 10:59:50 -0600
To: Mark Chambers <markc@mail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Mar 7, 2006, at 10:53 AM, Mark Chambers wrote:

>> I'm dealing with this exact same situation and having a discussion  
>> on  lkml regarding the proper way to do this.  In your case, do  
>> you care  what addresses the FPGA is assigned at?
>> http://marc.theaimsgroup.com/?l=linux-kernel&m=114140791428032&w=2
>
> Why does the PCI device have to have a fixed address?   And how do
> you load an FPGA from user space - mmap?

In my case it does because we have other devices (DSPs) that are hard  
coded to know where in PCI address space the FPGA is.

As for how does one load it.  We have GPIO pins connected to the FPGA  
and load it from a file in user space with a kernel driver  
implementing the bit "protocol" over GPIO.

- kumar
