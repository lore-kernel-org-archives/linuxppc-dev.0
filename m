Return-Path: <jpl@xiphos.ca>
Received: from mail.net (custpop.ca.mci.com [142.77.1.111])
	by ozlabs.org (Postfix) with ESMTP id 399AE67A9A
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Feb 2005 07:28:51 +1100 (EST)
Message-ID: <4207CFBE.2000109@xiphos.ca>
Date: Mon, 07 Feb 2005 20:29:50 +0000
From: Joshua Lamorie <jpl@xiphos.ca>
MIME-Version: 1.0
To: Andrei Konovalov <akonovalov@ru.mvista.com>
References: <4202E286.1010206@xiphos.ca> <42035D27.50901@ru.mvista.com>
In-Reply-To: <42035D27.50901@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Edge Interrupts (Virtex-II Pro)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrei Konovalov wrote:

> As this code is not board specific at all,
> I would move it to arch/ppc/syslib/xilinx_pic.c:ppc4xx_pic_init().
> Does it sound reasonable (I'll prepare the patch this weekend then)?

This sounds useful, since I am using a custom developed board using the 
Virtex-II Pro. Unfortunately, the patch wouldn't help me much because I 
am doing my interrupt setup for most of my custom devices within 
modules. You see my hardware has a Virtex-II Pro and a Virtex-II with a 
shared (logically) address space (OPB). I have cascaded interrupt 
controllers (ask me if anyone wants the code). So it is quite often that 
I have a changed hardware and therefore require different drivers. 
Rather than downloading to flash the 700k kernel each time while I am 
developing, I just download the 6k - 20k modules. Then I store them in 
onboard NOR flash.

That's a long way of saying YES, isn't it?

Joshua

-- 

Xiphos Technologies
(514) 848-9640 x227
(514) 848-9644 fax

www.xiplink.com
_______________________________________________
The information transmitted is intended only for the
person or entity to which it is addressed and may contain
confidential and/or privileged material.  If you have
received this in error, please contact the sender and delete
this communication and any copy immediately. Thank you.
