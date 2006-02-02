Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 424F568A5B
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Feb 2006 07:13:08 +1100 (EST)
To: Vitaly Bordug <vbordug@ru.mvista.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: opening the serial port from userspace application 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 02 Feb 2006 14:45:20 +0300."
	<20060202144520.3422129b@vitb.ru.mvista.com>
Date: Thu, 02 Feb 2006 21:13:06 +0100
Sender: wd@denx.de
Message-Id: <20060202201306.4212D3535EA@atlas.denx.de>
Cc: bharathi kandimalla <bharthik2004@yahoo.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20060202144520.3422129b@vitb.ru.mvista.com> you wrote:
>
> >From what I can see, you have misconfigured something. Dunno for certain, but 860T 
> might have 2 UARTs, when you have at least 4 enabled. Please enable in the kernel configuration only those which exist on your board.

You can have up to 6 UART ports on a 860 (2 x SMC + 4 x SCC).

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Don't tell me how hard you work.  Tell me how much you get done.
                                                     -- James J. Ling
