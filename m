Return-Path: <boro@razvoj-verbic.si>
Received: from mta1.siol.net (mta1.siol.net [193.189.160.88])
	by ozlabs.org (Postfix) with ESMTP id CA5DB67B62
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Jul 2006 22:54:34 +1000 (EST)
Received: from edge2.siol.net ([10.10.10.211]) by mta1.siol.net with ESMTP
	id <20060728125431.JXKE4387.mta1.siol.net@edge2.siol.net>
	for <linuxppc-embedded@ozlabs.org>; Fri, 28 Jul 2006 14:54:31 +0200
Received: from [192.168.2.101] (really [86.61.75.118]) by edge2.siol.net
	with ESMTP
	id <20060728125431.PKUU4459.edge2.siol.net@[192.168.2.101]>
	for <linuxppc-embedded@ozlabs.org>; Fri, 28 Jul 2006 14:54:31 +0200
Message-ID: <44CA0905.7010001@razvoj-verbic.si>
Date: Fri, 28 Jul 2006 14:54:29 +0200
From: Uros Borovsak <boro@razvoj-verbic.si>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: Host USB on MPC8247
References: <44BF88A2.6080003@razvoj-verbic.si>
In-Reply-To: <44BF88A2.6080003@razvoj-verbic.si>
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

Hello,

Can you at least give me some idea how difficult would it be to patch 
USB part of kernel from 2.6.13 to 2.6.10?

Are changes only in usb part of kernel, or are there also some changes 
in other parts of kernel, that I would have to port?

Thanks,

Best regards

Uros

Uros Borovsak wrote:
> Hello,
>
> I'm looking for host USB driver for MPC8247. We are using MV kernel 
> 2.6.10 and I'm wondering, if there is a driver for this specific kernel.
>
> I'm aware of cpm2usb project on sourceforge, but it is for kernel 
> 2.6.13. How difficult would it be to patch only usb part of kernel from 
> 2.6.10 to 2.6.13 so I could use that drivers. I only need suport for USB 
> storage devices, so that driver is enough for me.
>
> Thanks,
>
> Best regards,
>
> Uros
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>   
