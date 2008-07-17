Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id EBEC3DE1EC
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Jul 2008 18:34:42 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KJOwh-00069I-Tq
	for linuxppc-embedded@ozlabs.org; Thu, 17 Jul 2008 01:34:39 -0700
Message-ID: <18503965.post@talk.nabble.com>
Date: Thu, 17 Jul 2008 01:34:39 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: how to allocate 9MB of memory in kernel ?
In-Reply-To: <487EFA1E.8060804@coritel.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <18503022.post@talk.nabble.com> <487EFA1E.8060804@coritel.it>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


>>You can use the mem option to tell to the kernel that you've got less 
>>ram you really have. 
I really didnt got the point you made. Can you please elaborate it for my
understanding.
>>However you can read Linux device drivers chapter 8 
i dont need to allocate large memory at the boot time also vmalloc and
kmalloc i cant use as it can allocate free page up to 128kb, hence if you
could suggest me a better technique i would really appriciate .

---Misbah <><


Marco Stornelli wrote:
> 
> Misbah khan ha scritto:
>> Hi all,
>> 
>> I need to allocate 9 MB of memory in to the kernel space which i need to
>> mmap for the application to access.
>> 
>> I need to know what could be the best possible way of doing the same.
>> 
>> Please share your experience in this regard .
>> 
>> Thank you in advance 
>> 
>> ----Misbah <><
> You can use the mem option to tell to the kernel that you've got less 
> ram you really have. However you can read Linux device drivers chapter 8 
> "Obtaining Large Buffers" :).
> 
> Regards,
> 
> -- 
> Marco Stornelli
> Embedded Software Engineer
> CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
> http://www.coritel.it
> 
> marco.stornelli@coritel.it
> +39 06 72582838
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/how-to-allocate-9MB-of-memory-in-kernel---tp18503022p18503965.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
