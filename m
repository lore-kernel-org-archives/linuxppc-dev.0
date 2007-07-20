Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D40DADDE4A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Jul 2007 21:32:20 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IBqiX-0001rQ-V0
	for linuxppc-embedded@ozlabs.org; Fri, 20 Jul 2007 04:32:17 -0700
Message-ID: <11706536.post@talk.nabble.com>
Date: Fri, 20 Jul 2007 04:32:17 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: RE: How to access physical memory from user space for MPC8260 chip
In-Reply-To: <0B45E93C5FF65740AEAE690BF3848B7A4AB178@rennsmail04.eu.thmulti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <e5eb93010707120307h785bf195n7a649363e4e455f@mail.gmail.com>
	<0B45E93C5FF65740AEAE690BF3848B7A4AB178@rennsmail04.eu.thmulti.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Physical address you can map to  kernel space using ioremap() function 
but you are not clear whether you want to map it to the user space / kernel
space. To map kernel space to user space you should use mmap() functionality
in your driver.

I hope you got the answer to what you were expecting else send the clear
query

regard 
misbah


Fillod Stephane wrote:
> 
> suresh suresh wrote:
>>I have to map physical memory to user space or kernel space. I am
> writing >driver for MPC8260 chip and I want to know how to map any
> 32-bit address >space to user space and kernel space.
> 
> Your question is a linuxppc-embedded FAQ. User-land access is documented
> 
> in Denx's FAQ[1], and accessible through shorter URL[2]. For more 
> information, please follow this thread[3] (not ppc specific actually).
> 
> [1]
> http://www.denx.de/twiki/bin/view/PPCEmbedded/DeviceDrivers#Section_Acce
> ssingPeripheralsFromUserSpace
> [2] http://tinyurl.com/6c7th
> [3] http://article.gmane.org/gmane.linux.ports.ppc.embedded/5053
> 
> In kernel land, ioremap() is all you need.
> 
> Don't forget to use the 'eieio' asm instruction if you want explicit 
> I/O ordering.
> 
> Best Regards,
> -- 
> Stephane, the userland ioremap bot
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/How-to-access-physical-memory-from-user-space-for-MPC8260-chip-tf4067159.html#a11706536
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
