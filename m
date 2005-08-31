Return-Path: <wd@denx.de>
Received: from mailout05.sul.t-online.com (mailout05.sul.t-online.com
	[194.25.134.82]) by ozlabs.org (Postfix) with ESMTP id CB3E4681C6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Aug 2005 17:04:32 +1000 (EST)
To: "FCG WANG Baohua" <Baohua.WANG@alcatel-sbell.com.cn>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 31 Aug 2005 08:51:29 +0800."
	<A9DE2BAF233E444FA9C5E77A5825A01E865067@ydmail.sbell.com.cn>
Date: Wed, 31 Aug 2005 09:03:54 +0200
Sender: wd@denx.de
Message-Id: <20050831070354.F3D7935258E@atlas.denx.de>
Cc: Jack_liu@usish.com, Tsi-Chung.Liew@freescale.com,
	linuxppc-embedded@ozlabs.org
Subject: Re: Question about SMC serial port on MPC8270 in u-boot 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <A9DE2BAF233E444FA9C5E77A5825A01E865067@ydmail.sbell.com.cn> you wrote:
> 
>  When i port the u-boot 1.1.3 on my MPC8270 board, the serial port has

Your question is off topic on this list. Please send  U-Boot  related
questions to the u-boot-users list instead.

>   1. the Dual port ram cannot be revised manually, but can be revised by
> the u-boot code. What's the problem?

You're doing something wrong.

>    2. the serial_putc() in serial_smc.c is loop forever on  "while
> (tbdf->cbd_sc & BD_SC_READY);". How to slove the bug?

Make sure your clocks / BRG's are configured correctly.

>    3. the speed.c calc the wrong cpm, cpu, brg_clk, I had hard coded the
> right   cpm, cpu, brg_clk values. But the "m8260_cpm_setbrg()" is still
> wrong? Why?

Your system is misconfigured.

>         data structures, they all seems right, but the UART cannot work.
> How could I find the problem? 

Fix the problems as you encounter them. If the clocks show  up  wrong
you  should fix this problem first. Then all the rest might just fall
into place.

> Content-Type: text/html;
> Content-Transfer-Encoding: quoted-printable
> 
> <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
> <HTML>

And please don't post HTML.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A meeting is an event at which the minutes are kept and the hours are
lost.
