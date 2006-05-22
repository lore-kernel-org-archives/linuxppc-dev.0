Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 977D6679FD
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 May 2006 23:00:33 +1000 (EST)
To: nreddy@netenrich.com
From: Wolfgang Denk <wd@denx.de>
Subject: Re: "How to change the Magic number" 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 22 May 2006 05:21:01 PDT."
	<45530.61.95.208.2.1148300461.squirrel@61.95.208.2>
Date: Mon, 22 May 2006 15:00:30 +0200
Sender: wd@denx.de
Message-Id: <20060522130030.B45D23525D9@atlas.denx.de>
Cc: u-boot-users@lists.sourceforge.net, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <45530.61.95.208.2.1148300461.squirrel@61.95.208.2> you wrote:
> 
>  I have a specific requirement to change the Magic number of the linux
> kernel in my embedded system.

You are off track.

>  I cound see the Magic number is defined in U-boot files:
>  1.include/image.h:#define IH_MAGIC        0x27051956
>  2.cpu/ppc4xx/start.S:     .long   0x27051956

This magic number is only used by U-Boot, and  ther  e  only  in  the
image header. It has no relevance in any way to the LInu xkernel.

>   So i can modify in u-boot to make it compatible to my Kernel (i am using
> montavista linux version 2.4.20), but i am not able to see this kindof
> info anywhere in the kernel source files.

You are looking at the wrong place. This magic number is not used  or
accessed anywhere in the Linu xkernel.

> If anyone knows how the linux magic number is generated and what are the
> files
>  need modifications inorder to change magic number please let me know.

Linux itself has no such magic number. Especially not on PPC.

[But if you find a way to change  that  magic  number,  I  would  not
protest  if  you  added 10 or 20 to the last 4 digits. Just make sure
the change is propagated back to it's origin. :-) ]

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The easiest way to figure the cost of living is to take  your  income
and add ten percent.
