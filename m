Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 9A04FDDD07
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jul 2007 05:22:19 +1000 (EST)
Message-ID: <4697CFB3.8090009@anagramm.de>
Date: Fri, 13 Jul 2007 21:17:07 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Vikram Kone <vikramkone@gmail.com>
Subject: Re: Help required for porting ISP1362 usb device driver
References: <003d01c7c4d8$07ea3cc0$66dd47ab@cisco.com>
In-Reply-To: <003d01c7c4d8$07ea3cc0$66dd47ab@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello, Vikram!

Vikram Kone schrieb:
> Hi..
> I'm a linux newbie and im working on porting the USB driver ISP1362 by 
> Philips on to my Freescale ppc board.

Please don't crosspost.
Please don't write HTML.

> I dont know how to do this... so if any of you can tell me how to do 
> this step by step, i would be very grateful to you
>  
> Few details..
> I'm running RHEL with kernel 2.4.21 on a PC (i386 machine)
> Target Machine is MPC8548 CDS by Free scale (ppc architecture) running 
> kernel version 2.6.11

Did you try something like:
http://www.freescale.com/files/32bit/doc/app_note/AN3094.pdf?fsrch=1
I think it's one of these "step by step" things.

(You should consider moving up to the latest Kernel which is 2.6.22.1
as of today. Nobody fixes bugs on that old kernel.)

> I do have a ppc tool chain, if that helps.....

What tool chain?

 > but i dont know how to use it

Did you read the documentation?
What problem do you have?

> P.S. I downloaded the deive driver and host controller drivers from 
> sourceforge.net and both of them seem to work for 2.6.6 kernel for i386 
> arch ..

Fine!

> P.P.S : Wolfgang ??!1 Can you help me out... I went through the archives 
> on the list and seems thatu answered many Qs on this driver. But i didnt 
> find any post specifcally for my problem..so

Sorry, my crystal ball is broken.
You didn't tell us any details about your problem.

  > This e-mail may contain confidential and privileged material for the
> sole use of the intended recipient. Any review, use, distribution or 
> disclosure by others is strictly prohibited. If you are not the intended 
> recipient (or authorized to receive for the recipient), please contact 
> the sender by reply e-mail and delete all copies of this message.

Oops... If I am not the intended recipient, please: > /dev/null my mail.

Regards,
-- 
Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Straße 45/1
Linhof Werksgelände
D-81379 München
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com
