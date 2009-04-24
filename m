Return-Path: <lhthanh@kobekara.com>
Received: from phobos.lunarpages.com (phobos.lunarpages.com [67.210.120.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 10EA0DDEF3
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 16:15:01 +1000 (EST)
Message-ID: <49F15831.9080507@kobekara.com>
Date: Fri, 24 Apr 2009 13:12:01 +0700
From: lhthanh <lhthanh@kobekara.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: MPC8349E's DMA controller like ISA controller but with more
	feature?
References: <49EC6CB5.2020300@kobekara.com>
	<20090420155511.GA25470@ld0162-tx32.am.freescale.net>
	<49EFEA26.2010602@kobekara.com>
	<20090423154311.GA19717@ld0162-tx32.am.freescale.net>
	<49F08FBC.9010903@freescale.com>
In-Reply-To: <49F08FBC.9010903@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thank Scott and Timur!  
> Scott Wood wrote:
>   
>> Timur Tabi (CCed) has written an audio
>> driver that does something very similar; he could probably tell you more
>> about how to do that (this is why such discussions should be kept on the
>> mailing list rather than taken to private e-mail).
>>     
>
> The code in drivers/dma cannot be used to send a buffer of data to a
> single I/O port.  That code is just an elaborate version of memcpy that
> uses the DMA engine to copy data in the background.
>
>   
Thanks for your explaination! So if I want to transfer a buffer of data 
from a single I/O port,  will not DMA framework
also be able ? Have I to write aother driver?
> If you want to transfer a buffer to a single I/O port, you will need to
> write your own DMA driver, similar to what I've done in
> sound/soc/fsl/fsl_dma.c.  This is not trivial.  You will need to
> understand the DMA hardware programming model to determine whether you
> can use direct mode or if you need to create link descriptors.
>
>   
Actually, I don't want write all because there are  serveral DMA code at 
hand. I only want to use a framework instead of re-writing.
And I afraid that I can not write code which assure sharing DMA channels.
 
Regards!
