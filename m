Return-Path: <wd@denx.de>
Received: from mailout01.sul.t-online.com (mailout01.sul.t-online.com
	[194.25.134.80]) by ozlabs.org (Postfix) with ESMTP id EC5EB2BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Dec 2004 20:14:08 +1100 (EST)
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP id 1BB2B422ED
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Dec 2004 10:13:43 +0100 (MET)
Received: from atlas.denx.de (localhost [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 4A84313D6DB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Dec 2004 10:13:31 +0100 (MET)
To: linuxppc-embedded@ozlabs.org
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 27 Dec 2004 21:30:48 CST."
	<41D0D368.3080702@conspiracy.net>
Date: Tue, 28 Dec 2004 10:13:26 +0100
Sender: wd@denx.de
Message-Id: <20041228091331.4CE6BC1430@atlas.denx.de>
Subject: Re: simple bootloader 2.6.10-rc3 8xx 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <41D0D368.3080702@conspiracy.net> Paul Bilke wrote:
>
...
> If you are running a duet variant (870,880,885) there is a CPU errata 
> which was the cause in my case.
...
> I hired Wolfgang to implement the suggested work around and I believe he 
> has put the necessary code into his 2.4 tree already.

Yes, the CPU15 workaround code is in the linuxppc_2_4_devel  tree  on
our CVS server:

---------------------
PatchSet 295 
Date: 2004/08/25 16:16:30
Author: wd
Branch: HEAD
Tag: (none)  
Log:
Implement work-around for CPU15 Silicon Errata on MPC8xx processors.
  
Members: 
        arch/ppc/8xx_io/Config.in:1.8->1.9 
        arch/ppc/kernel/head_8xx.S:1.6->1.7 
        include/linux/sysctl.h:1.8->1.9 
        kernel/sysctl.c:1.8->1.9 
  
---------------------


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Real computer scientists despise the idea of actual  hardware.  Hard-
ware has limitations, software doesn't. It's a real shame that Turing
machines are so poor at I/O.
