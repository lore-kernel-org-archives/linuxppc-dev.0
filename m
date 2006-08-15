Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 5544967B64
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Aug 2006 07:18:56 +1000 (EST)
To: pranav choudhary <dimensions_infinite@yahoo.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: U-boot and 2.6 kernel 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 14 Aug 2006 04:35:26 PDT."
	<20060814113526.71320.qmail@web33213.mail.mud.yahoo.com>
Date: Tue, 15 Aug 2006 23:18:54 +0200
Sender: wd@denx.de
Message-Id: <20060815211854.639EB353B9E@atlas.denx.de>
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

In message <20060814113526.71320.qmail@web33213.mail.mud.yahoo.com> you wrote:
>
> I am using an old version of u-boot and 2.6.13 kernel on IXDP425 hardware. The booting process stalls. After a little debugging i found that the booting stalls sfter call to jump() [__FUNCTION__ = CON_Run_Firmware, __FILE__ == conleaf.c. It seems that t
> he correct image is not copied to KERNEL_RUN_ADDRESS.
> I found another thread that talked of old u-boot and 2.6 kernels but i could not make out anything useful from it. Can someone please give me some pointers on where to start debugging...

Start debugging at the kernel's entry point.

The kernel is independent from U-Boot. 

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Always borrow money from a pessimist; they don't expect  to  be  paid
back.
