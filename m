Return-Path: <wd@denx.de>
Received: from mailout01.sul.t-online.com (mailout01.sul.t-online.com
	[194.25.134.80]) by ozlabs.org (Postfix) with ESMTP id 0472B2BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 26 Dec 2004 04:10:06 +1100 (EST)
To: Suresh Chandra Mannava <msuresh@gamebox.net>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 25 Dec 2004 13:16:35 +0530."
	<41CD1ADB.3010807@gamebox.net>
Date: Sat, 25 Dec 2004 18:09:25 +0100
Sender: wd@denx.de
Message-Id: <20041225170931.05B4DC14C8@atlas.denx.de>
Cc: etux@embeddedtux.org, linuxppc-embedded@ozlabs.org
Subject: Re: kernel for MPC8260 SBC 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Suresh,

please read the  netiquette.  Please  never  post  the  same  message
several times to different newsgroups.

In message <41CD1ADB.3010807@gamebox.net> you wrote:
> 
> We developed a SBC based on MPC8260. We are planing to port Linux on it.
> I downloaded mpc8260 cross compiling tools from denx.de.
> 
> I started cross-compiling linux-2.4.4.

Why? 2.4.4 ist very, very old. Use a more recent kernel tree. If  you
want   to   stay   in   our   source   tree,   then  please  use  the
linuxppc_2_4_devel module on our CVS server.

> The problem is
> I am not able to compile kernel. 8260 specific files in arch/ppc are not 
> compiling due to not inclusion of

Then your configuration is broken. The kkernel compiles fine for many boards.

> "bd_t" structure. I Included the file "asm-ppc/bseip.h".
> Still encountering many errors.

This is not a big surprise. The "bseip.h" header file is for a MPC8xx
based board - what makes you think that this might work on your  8260
based hardware?

> I even tried with linux-2.4.20 and encountered the same problems.
> Is there any patch required for compiling the kernel cleanly.

No. There is no patch needed. The kernel trees are  clean.  You  just
have  to  select a correct configuration. Ummm... and for your custom
board you will probably have to port Linux first.

> Please provide pointer to the sutiable kernel along with patch.

See for example the linuxppc_2_4_devel module on our CVS server.


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Every little picofarad has a nanohenry all its own.      - Don Vonada
