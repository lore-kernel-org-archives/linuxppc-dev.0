Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id DEAA8688A1
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Dec 2005 21:11:04 +1100 (EST)
To: batsayan.das@tcs.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 16 Dec 2005 10:19:53 +0530."
	<OFB8CF31AB.E132BC0B-ON652570D9.001789DD-652570D9.001A8A99@tcs.com>
Date: Fri, 16 Dec 2005 11:11:01 +0100
Sender: wd@denx.de
Message-Id: <20051216101101.7B82B353416@atlas.denx.de>
Cc: u-boot-users@lists.sourceforge.net, linuxppc-embedded@ozlabs.org
Subject: Re: [U-Boot-Users] Help required to bring up kernel from U-Boot 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <OFB8CF31AB.E132BC0B-ON652570D9.001789DD-652570D9.001A8A99@tcs.com> you wrote:
>
> I copied uImage to location 0x04000000 and  the Load Address=0x00000000 
> and Entry point=0x00000000.  The bootm 0x04000000 gives the o/p 
> "Transferring Control to Linux" and then nothing comes. Where is the 
> wrong?

This is a FAQ. Please see http://www.denx.de/wiki/DULG/Faq

> 1. What are the minimum information Linux needs from U-Boot to come up 
> properly?  In the Linux source tree we have put some printk statement and 
> found that base address of SDRAM, size, etc are passed correctly to Linux 
> by U-Boot. 

Be careful with printk() at inappropieate places (i.e. too early).

But tell me - how where you  able  to  see  anthing  with  printk  if
"nothing comes" as you write above ???

> 2. Is the info passed from U-Boot is sufficient enough to make the kernel 
> up?

Yes, of course. It works on thousands of systems.

> 3. If not, where should I concentrate in Linux tree?

On your changes.

And please keep this off the U-Boot list. It is off topic here.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
CONSUMER NOTICE:  Because  of  the  "Uncertainty  Principle,"  It  Is
Impossible  for  the  Consumer  to  Find  Out  at  the Same Time Both
Precisely Where This Product Is and How Fast It Is Moving.
