Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EB09EDDE44
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 23 Jul 2007 13:47:49 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1ICotf-00016V-Be
	for linuxppc-embedded@ozlabs.org; Sun, 22 Jul 2007 20:47:47 -0700
Message-ID: <11737504.post@talk.nabble.com>
Date: Sun, 22 Jul 2007 20:47:47 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Kmalloc returns which address
In-Reply-To: <469B92DC.50609@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <e5eb93010707160659m6a7d0b02p623542739d28ab29@mail.gmail.com>
	<469B92DC.50609@freescale.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


hi Scott

yes really it would really generate a machine check... but i guess if you
convert this virt address to physical address using __pa() then pass it to
the ioremap() i guess things will work .

Please correct me if i am wrong

regard 
misbah
 

Scott Wood-2 wrote:
> 
> suresh suresh wrote:
>> I want know the address return by kmalloc function? is it physical
>> address
>> or kernel virtual address.
> 
> Kernel virtual.
> 
>> For Tx and Rx, hardware uses buffers, so I have to allocate buffers and 
>> pass
>> the pointer to hardware. Can I pass the pointer returned kmalloc?  or  I
>> should convert it into physical address?
> 
> You need to convert it; read Documentation/DMA-mapping.txt.
> 
> -Scott
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/Kmalloc-returns-which-address-tf4086826.html#a11737504
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
