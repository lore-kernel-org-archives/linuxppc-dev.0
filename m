Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A865DDDEE1
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Aug 2007 06:39:06 +1000 (EST)
In-Reply-To: <5c9cd53b0708141321h62f0ddd1k3a57a37f52e93894@mail.gmail.com>
References: <5c9cd53b0708141321h62f0ddd1k3a57a37f52e93894@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <36201C92-F117-4273-9FA7-13665CF0C6DB@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: System crash on boot_e500.S on 2.4Kernel
Date: Tue, 14 Aug 2007 15:38:56 -0500
To: "mike zheng" <mail4mz@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 14, 2007, at 15:21, mike zheng wrote:

>
> Hi All,
>
> I am trying to bring up MPC8548 CDS board on 2.4 kernel. I have  
> problem in the head_e500.S. The "mtspr SRR0, r7; mtspr SRR1 r6"  
> does not work for me. The content of R7 and R6 are not moved to  
> SRR0 and SRR1.  I am using the tool-chain from Freescale for 2.6  
> kernel.
>
> Any idea on this issue?

Just to check...how do you know it doesn't work?

Andy
