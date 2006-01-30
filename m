Return-Path: <mike@compulab.co.il>
Received: from alexmail (62-90-235-247.barak.net.il [62.90.235.247])
	by ozlabs.org (Postfix) with ESMTP id 278C068A22
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Jan 2006 22:39:56 +1100 (EST)
Message-ID: <43DDF76D.1070501@compulab.co.il>
Date: Mon, 30 Jan 2006 13:24:29 +0200
From: Mike Rapoport <mike@compulab.co.il>
MIME-Version: 1.0
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: Question on USB gadget device driver for mpc 8272 on linux	2.6.14.
References: <32A7B31E4005134E8BA805EBAAFB9DCD9C7A20@hellskitchen.haliplex.com.au>
	<20060127154323.40e9404e@vitb.ru.mvista.com>
In-Reply-To: <20060127154323.40e9404e@vitb.ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Vitaly,
Can you send me this patch?


Vitaly Bordug wrote:

>Jonathan,
>
>I have implemented the PQ2 usb-serial functionality a while ago, but the code needs a lot of cleanup, which is sometimes very tricky due to the tight timings required by this device. If you are interested, I can try to find the patch...
>
>On Fri, 27 Jan 2006 11:45:39 +1100
>"Jonathan Qiang" <jonathan@haliplex.com.au> wrote:
>
>  
>
>>Hi, all
>> 
>>Currently, I am doing on the USB gadget device driver for mpc8272, I
>>already got some packets on interruption route when my board in which
>>mpc82xx settled connect to Host.
>>But the SOF is always generated as the first interruption source. When
>>plugged USB cable in HOST, the USB controller will be set to reset
>>(USBER is [0x308]), and after reset, the interruption source event
>>changes its status to [0x108], which means running on IDLE and SOF.  Why
>>It is not IN token?
>>I already disabled Frame timer when I probe the USB gadget controller. 
>>    
>>
>
>
>  
>

-- 
Sincerely yours,
Mike Rapoport
