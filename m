Return-Path: <rukseninanir@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id 9439EDDFDE
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Jul 2008 23:32:13 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so474832ugf.0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 02 Jul 2008 06:32:11 -0700 (PDT)
Message-ID: <486B8353.7030604@gmail.com>
Date: Wed, 02 Jul 2008 16:32:03 +0300
From: Ruksen INANIR <rukseninanir@gmail.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: High Memory problem on 2.4.22 Linux, 2GB ppc card
References: <4868A5C0.5080409@gmail.com>
In-Reply-To: <4868A5C0.5080409@gmail.com>
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



I want to change the MAX_LOW_MEM to 1520 MB, what other settings do i 
need to change? I do not want to use HIGHMEM because the Fiber channel 
does not support highmem. The card is 2 GB ppc. 1520 MB is enough. At 
the moment card works with 1456 MB MAX_LOW_MEM.

Thanks





Ruksen INANIR wrote:
>
> Hi all,
>   I am working on a PPC Motorola card, which runs Linux 2.4.22.  The 
> card has 2 GB onboard memory. But with use 1456 MB of  the available 
> memory.  To increase the memory capacity i  need  to  increase the 
> used memory at least 64 MB. With CONFIG_HIGHMEM option all of the 2 GB 
> memory can be used but, but the fc driver on the card has no high 
> memory support, so this caused problems.
>     Then i saw that the memory is limited to 1456 by
>   #define MAX_LOW_MEM        0x5B000000  setting in pgtable.c.  I 
> tried to increase it by 64 MB but i could only increase the value of 
> MAX_LOW_MEM by 47 MB (1503 MB) without CONFIG_HIGHMEM option.
>
>   1)Is there any other setting that i should set other than     
> MAX_LOW_MEM to increase the usable memory to 1520 ?
>   2)I knew that the addressable physical memory without high memory 
> option was 1 G.  How was it possible to address 1503 MB without 
> CONFIG_HIGHMEM ? What is the max usable memory for 2.4.22 kernel?
>
>   Thanks,
>   Rinanir.
