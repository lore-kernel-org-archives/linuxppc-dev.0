Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id D4A8667A04
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 May 2006 00:46:08 +1000 (EST)
To: Gautam Borad <gautam@eisodus.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: frequent sig 11 with malloc() on mpc8xx 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 04 May 2006 13:18:31 +0530."
	<4459B1CF.60909@eisodus.com>
Date: Thu, 04 May 2006 16:46:05 +0200
Sender: wd@denx.de
Message-Id: <20060504144605.B18B3353BE7@atlas.denx.de>
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

In message <4459B1CF.60909@eisodus.com> you wrote:
> We are having a frequent sig 11 problem on our custom mpc852t board
> with linux kernel 2.6.14 and U-boot version 1.1.3

That's a FAQ.

> I had the same problem with 2.4 kernel and after posting the problem 

This confirms that the FAQ matches your problem. See
http://www.denx.de/wiki/view/DULG/LinuxCrashesRandomly

> here, was asked to move to 2.6 kernel.

Ummm... I have yet to see a single case where moving to 2.6  improved
the stability for a MPC8xx system :-(

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
News is what a chap who doesn't care much  about  anything  wants  to
read. And it's only news until he's read it. After that it's dead.
                           - Evelyn Waugh _Scoop_ (1938) bk. 1, ch. 5
