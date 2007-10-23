Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9D9F2DDED0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Oct 2007 14:08:23 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IkB3z-00082I-K1
	for linuxppc-embedded@ozlabs.org; Mon, 22 Oct 2007 21:08:19 -0700
Message-ID: <13357088.post@talk.nabble.com>
Date: Mon, 22 Oct 2007 21:08:19 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Difference between ioremap() and phy_to_virt() Kernel function
In-Reply-To: <200710221304.44275.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <13339930.post@talk.nabble.com> <200710221304.44275.arnd@arndb.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Thanks Arnd 

But i wish to know that could i use phy_to_virt() function in place io
ioremap() ????? And could you give me an example where we could use
phy_to_virt(). ioremap() implementation i have already done.

---Misbah


Arnd Bergmann wrote:
> 
> On Monday 22 October 2007, Misbah khan wrote:
>> Could you Please let me know what is the difference between ioremap() and
>> phy_to_virt() function being provided by the Kernel.
> 
> ioremap gives you a new mapping for I/O addresses that you can access
> with functions like in_be32 and the like.
> 
> phy_to_virt() is rarely used at all, it only serves to convert a physical
> address for main memory (RAM) into the address used inside of the kernel.
> 
> 	Arnd <><
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/Difference-between-ioremap%28%29-and-phy_to_virt%28%29-Kernel-function-tf4669833.html#a13357088
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
