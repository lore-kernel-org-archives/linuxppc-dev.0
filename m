Return-Path: <wd@denx.de>
Received: from mailout01.sul.t-online.com (mailout01.sul.t-online.com
	[194.25.134.80]) by ozlabs.org (Postfix) with ESMTP id 0132367A33
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Apr 2005 20:23:40 +1000 (EST)
To: Sam Song <samlinuxppc@yahoo.com.cn>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 21 Apr 2005 15:19:10 +0800."
	<20050421071910.46237.qmail@web15808.mail.cnb.yahoo.com>
Date: Thu, 21 Apr 2005 12:23:26 +0200
Sender: wd@denx.de
Message-Id: <20050421102331.B09DCC1510@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8245 custom board,
	Linux 2.4 kernel hangs after uncompressing
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20050421071910.46237.qmail@web15808.mail.cnb.yahoo.com> you wrote:
>
> Interesting to me as well. I also have such a similar
> problem. But I wanna to know how I can return to 
> u-boot with software workaround after kernel hanging.

Press the reset button?

> At least, I must power-off and power-on my target to
> get back to u-boot console. If so, the last kernel 
> printk message would lost IMHO.

Isn't there a way to perform a hardware reset (by pressing the  reset
button, or through a JTAG debugger) ?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
You see things; and you say ``Why?'' But I dream  things  that  never
were; and I say ``Why not?''
       - George Bernard Shaw _Back to Methuselah_ (1921) pt. 1, act 1
