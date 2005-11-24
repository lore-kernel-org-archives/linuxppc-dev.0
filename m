Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 8F03A6882D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Nov 2005 22:28:30 +1100 (EST)
To: pritha.bhattacharya@tcs.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 24 Nov 2005 14:20:05 +0530."
	<OF8DE1E835.620AF9B1-ON652570C3.001D9C79-652570C3.003087C6@tcs.com>
Date: Thu, 24 Nov 2005 12:28:27 +0100
Sender: wd@denx.de
Message-Id: <20051124112827.DD3F6353A49@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 8260ADS Ethernet compilation 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <OF8DE1E835.620AF9B1-ON652570C3.001D9C79-652570C3.003087C6@tcs.com> you wrote:
>
> I have a custom board built around MPC8260ADS. I am trying to cross 

I  understand  that  this  means  you  also  use   a   custom   board
configuration, right?

> m8260_setup.c:62: error: `bd_t' undeclared here (not in a function)
...
> m8260_setup.c:120: error: `binfo' undeclared (first use in this function)
...
> m8260_setup.c:229: error: `NR_SIU_INTS' undeclared (first use in this 
> function)

Seems your port and/or board configuration is incomplete / broken.

> 1.I understand that bd_t is a board information structure. Which is 
> defined in linux/include/asm-ppc/ppcboot.h. Somehow it is not visible to 
> the linux/arch/kernel/m8260_setup.c  I dont know what I may be doing 
> wrong.

Bad configuration...

> 2.Similarly NR_SIU_INTS, which is defined in linux/include/asm/irq.h is 
> also not visible.

Bad configuration...

> 3.I did not understand what __res[ ] is. I came across somewhere that it 
> is the residual information which the bootloader is supposed to hand over 
> to the linux. How would that be done. I could not identify in the code 
> where __res is populated. 

Use "grep"; __res points to the board information structure.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"The more data I punch in this card,  the lighter it becomes, and the
lower the mailing cost."
                     - Stan Kelly-Bootle, "The Devil's DP Dictionary"
