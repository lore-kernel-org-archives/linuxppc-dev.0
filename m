Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id 512E8DE1B6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Jul 2008 21:19:43 +1000 (EST)
Message-ID: <487F2B4C.7070409@coritel.it>
Date: Thu, 17 Jul 2008 13:21:48 +0200
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: Ruksen INANIR <rukseninanir@gmail.com>
Subject: Re: increase lowmem value for ppc
References: <487F1FD2.7090909@gmail.com> <487F297B.4070806@coritel.it>
In-Reply-To: <487F297B.4070806@coritel.it>
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

Marco Stornelli ha scritto:
> Ruksen INANIR ha scritto:
>>
>> Is there a way to increase the lowmem value for ppc. The MAX_LOW_MEM 
>> is defined as max 768 MB. But a value around 1.5 G works with no 
>> problem. But when i try to increase this value to 1520 or more, kernel 
>> complaints about no space for memory allocation when loading kernel 
>> modules.
>> I do not want to use HIGHMEM config. What is the max lowmem value for 
>> a ppc system? What other setting are needed to use 1520 MB (or more) 
>> as lowmem .
>> The ppc card has 2G on board memory. 2.4.22 kernel is used.
>>
>> Thanks
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
> With 32-bit arch you may not use more than 1GB to map the memory (minus 
> some space for some kernel operation). The value of 768MB was not there 
> by chance.
> 
Only an additional comment: I meant with the address splitting 3G/1G. To 
map more than 1GB, you have to change the splitting 2G/2G for example.

-- 
Marco Stornelli
Embedded Software Engineer
CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
http://www.coritel.it

marco.stornelli@coritel.it
+39 06 72582838
