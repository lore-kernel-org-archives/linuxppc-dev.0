Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2928FDDDCA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Nov 2007 20:53:26 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Iv8kL-00082f-S4
	for linuxppc-embedded@ozlabs.org; Thu, 22 Nov 2007 01:53:21 -0800
Message-ID: <13893889.post@talk.nabble.com>
Date: Thu, 22 Nov 2007 01:53:21 -0800 (PST)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Firmware Support for USB Hub
In-Reply-To: <474468C5.8080402@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <13877282.post@talk.nabble.com> <474468C5.8080402@freescale.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Thank you for your reply.

Even i think that there is only out-of-tree driver for CPM USB. i would like
to know that some body used this driver and what is the problem that could
come and how could we customize for our requirement for the PPC-8248. 

Could you tell me what is the reason for not using inbuilt USB controler for
8248 than going for External controller.

If any body has already done USB driver than could you please share your
experience.

----misbah <><





Scott Wood-2 wrote:
> 
> Misbah khan wrote:
>> Hi all,
>> 
>> I am using a 8248 processor which has a USB controller and i need to
>> connect
>> a USB Hub to it, iam using Montavista Linux .I need to know that what are
>> the support i need form Montavista or Open source to have an interface
>> with
>> Usb hub. ???
>> 
>> Is there any driver that we need to make if so what type ???
> 
> I don't believe a driver currently exists for CPM USB.
> 
> -Scott
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/Firmware-Support-for-USB-Hub-tf4850180.html#a13893889
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
