Return-Path: <boro@razvoj-verbic.si>
Received: from mta1.siol.net (mta1.siol.net [193.189.160.88])
	by ozlabs.org (Postfix) with ESMTP id 5AE5F67B59
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Jul 2006 18:14:29 +1000 (EST)
Received: from edge2.siol.net ([10.10.10.211]) by mta1.siol.net with ESMTP
	id <20060731081423.EWOQ4387.mta1.siol.net@edge2.siol.net>
	for <linuxppc-embedded@ozlabs.org>; Mon, 31 Jul 2006 10:14:23 +0200
Received: from [192.168.2.101] (really [86.61.75.118]) by edge2.siol.net
	with ESMTP
	id <20060731081423.WCNU4459.edge2.siol.net@[192.168.2.101]>
	for <linuxppc-embedded@ozlabs.org>; Mon, 31 Jul 2006 10:14:23 +0200
Message-ID: <44CDBBDD.6000401@razvoj-verbic.si>
Date: Mon, 31 Jul 2006 10:14:21 +0200
From: Uros Borovsak <boro@razvoj-verbic.si>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: Host USB on MPC8247
References: <44BF88A2.6080003@razvoj-verbic.si>
	<44C9F398.4060109@razvoj-verbic.si>
	<44CDBA3C.2040402@compulab.co.il>
In-Reply-To: <44CDBA3C.2040402@compulab.co.il>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks for reply,

I made a mistake while typing the message.

In reality I was asking how difficult would it be to port USB part  of 
kernel from 2.6.10 to 2.6.13, but I mixed kernel version's when typing.

Mike Rapoport wrote:
> Uros Borovsak wrote:
>
>  
>> Hello,
>>
>> Can you at least give me some idea how difficult would it be to patch 
>> USB part of kernel from 2.6.13 to 2.6.10?
>>  
>>
>>     
> As far as I know USB core undergone signifcant changes between 2.6.10 
> and 2.6.13. Still it's hard to tell how difficult would it be to 
> backport USB from 2.6.13 to 2.6.10.
> Besides, it maybe worth upgrading your kernel instead of backporing 
> USB to 2.6.10.
>
>   
Upgrading the whole kernel is not a way to go for me here, becouse 
company is using montavista kernel, and if I upgrade the whole kernel, I 
would have to port all their patches also.

I believe that MontaVista will use higher kernel version some time, so I 
wouldn't go backporting driver to 2.6.10, but I would prefer to port USB 
part of kernel from 2.6.10 to 2.6.13.

Do you think that is possible and how hard would it be?

Best regards

Uros
>> Are changes only in usb part of kernel, or are there also some 
>> changes in other parts of kernel, that I would have to port?
>>
>> Thanks,
>>
>> Best regards
>>
>> Uros
>>
>>
>>  
>>
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
>>
>>
>>  
>>
>
>
