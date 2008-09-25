Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B7A08DE007
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Sep 2008 03:18:58 +1000 (EST)
In-Reply-To: <48DBB402.8090402@ovro.caltech.edu>
To: David Hawkins <dwh@ovro.caltech.edu>
Subject: Re: How do I access nvRAM from user space?
MIME-Version: 1.0
Message-ID: <OF871A5E9F.D762FCD5-ON882574CF.005EDA9D-882574CF.005F1AE2@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Thu, 25 Sep 2008 10:18:48 -0700
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-embedded-bounces+brucle=selinc.com@ozlabs.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dave,

> > Sorry for the dumb question, I just can figure out the right google 
search 
> > to find what I'm trying to do.  I'm running 2.6.27-rc4 on an mpc8347 
with 
> > a 32KiB nvSRAM (Cypress CY14B256L) on the local bus.  We just want to 
be 
> > able to access this memory from user space seperately from "main" 
memory. 
> > We've got a process that needs to be able to remember info through 
power 
> > cycles.  Can anyone point me to an article or some code snippet that 
does 
> > something like this so I can sink my teeth into it?
> 
> Assuming your bootloader sets up the local bus access windows
> (physical address of the SRAM) and timing so that you can
> read/write to the SRAM, then once Linux boots, you should be
> able to just use /dev/mem as you would to access any other
> device registers at a specific address.
> 

Thanks for the reply.  So if my nvSRAM device is located at 0xb0000000 in 
physical memory, what would the mmap() call look like?  Also, do I need to 
have a device tree entry for the kernel to know about the memory?  I can 
access the device in uboot so I know it works, but I can't figure out the 
mmap to get it from linux

Bruce
