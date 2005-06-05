Return-Path: <wd@denx.de>
Received: from mailout08.sul.t-online.com (mailout08.sul.t-online.com
	[194.25.134.20]) by ozlabs.org (Postfix) with ESMTP id E396B67B1A
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  5 Jun 2005 10:28:49 +1000 (EST)
To: Edward Hong <edward.qin.hong@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 04 Jun 2005 17:40:42 MDT."
	<21fb73bc0506041640736e3020@mail.gmail.com>
Date: Sun, 05 Jun 2005 02:28:27 +0200
Sender: wd@denx.de
Message-Id: <20050605002832.6311AC1512@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: kernel ported from ELDK 3.0 hangs (loops in idled()) on my
	custom MPC870 Board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <21fb73bc0506041640736e3020@mail.gmail.com> you wrote:
>
> My debug lines at the beginning of init never get printed on the
> console or in the log_buf.

With "beginning of init" you mean init() in "init/main.c", right?
So gets rest_init() called?
Did you add a few printk's to start_kernel()?
How far does it get?

> Any suggestions for debugging?

Attach a BDI2000 and start GDB...

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
If something is different, it's either better or worse,  and  usually
both.                                                    - Larry Wall
