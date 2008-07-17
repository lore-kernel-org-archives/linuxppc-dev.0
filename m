Return-Path: <rukseninanir@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id 1AA6CDE47E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Jul 2008 21:22:42 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so608457ugf.0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Jul 2008 04:22:41 -0700 (PDT)
Message-ID: <487F2B7D.6080109@gmail.com>
Date: Thu, 17 Jul 2008 14:22:37 +0300
From: Ruksen INANIR <rukseninanir@gmail.com>
MIME-Version: 1.0
To: Marco Stornelli <marco.stornelli@coritel.it>, linuxppc-embedded@ozlabs.org
Subject: Re: increase lowmem value for ppc
References: <487F1FD2.7090909@gmail.com> <487F297B.4070806@coritel.it>
	<487F2B4C.7070409@coritel.it>
In-Reply-To: <487F2B4C.7070409@coritel.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Is there any side effects of changing the address splitting? What should 
i change for 2G/2G splitting? should i shift the kernel start?
Thanks


Marco Stornelli wrote:
> Marco Stornelli ha scritto:
>> Ruksen INANIR ha scritto:
>>>
>>> Is there a way to increase the lowmem value for ppc. The MAX_LOW_MEM 
>>> is defined as max 768 MB. But a value around 1.5 G works with no 
>>> problem. But when i try to increase this value to 1520 or more, 
>>> kernel complaints about no space for memory allocation when loading 
>>> kernel modules.
>>> I do not want to use HIGHMEM config. What is the max lowmem value 
>>> for a ppc system? What other setting are needed to use 1520 MB (or 
>>> more) as lowmem .
>>> The ppc card has 2G on board memory. 2.4.22 kernel is used.
>>>
>>> Thanks
>>> _______________________________________________
>>> Linuxppc-embedded mailing list
>>> Linuxppc-embedded@ozlabs.org
>>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>>
>> With 32-bit arch you may not use more than 1GB to map the memory 
>> (minus some space for some kernel operation). The value of 768MB was 
>> not there by chance.
>>
> Only an additional comment: I meant with the address splitting 3G/1G. 
> To map more than 1GB, you have to change the splitting 2G/2G for example.
>
