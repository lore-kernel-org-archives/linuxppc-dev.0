Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id A1DEB67C0F
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Nov 2006 18:14:57 +1100 (EST)
To: Jeff Mock <jeff@mock.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: PPC440GX ethernet oddities 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 26 Nov 2006 20:05:49 PST."
	<456A641D.7070904@mock.com>
Date: Mon, 27 Nov 2006 08:14:54 +0100
Sender: wd@denx.de
Message-Id: <20061127071454.93C73353A44@atlas.denx.de>
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

In message <456A641D.7070904@mock.com> you wrote:
>
> Here's the weird part.  On one of the four prototype boxes, if I plug
> the second ethernet port into gigabit switch and get a link light (2nd
> interface is not enabled under linux), the DMA behavior will change and
> I can see the ring buffer get as large as 25MB (up from 512kB!)
> 
> Only one of my four boxes shows this strange behavior, and only when the
> second ethernet port is connected to an ethernet switch. Everything

Are you using exactly the same switch,  and  the  same  port  on  the
switch, and the same network cable with all of your boxen?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The universe does not have laws - it has habits, and  habits  can  be
broken.
