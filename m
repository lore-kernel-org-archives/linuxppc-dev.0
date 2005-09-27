Return-Path: <wd@denx.de>
Received: from mailout10.sul.t-online.com (mailout10.sul.t-online.com
	[194.25.134.21]) by ozlabs.org (Postfix) with ESMTP id 5AEA567B48
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Sep 2005 19:33:57 +1000 (EST)
To: "TXEMA LOPEZ" <tlopez@aotek.es>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 27 Sep 2005 09:24:51 +0200."
	<918EB199DDDFFA42BEA2EB3A1C6021F3628924@correo.fagorautomation.net>
Date: Tue, 27 Sep 2005 10:33:52 +0200
Sender: wd@denx.de
Message-Id: <20050927083352.6DA02353BE5@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Kernel debugging problem on MPC5200. 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Jose,

in message <918EB199DDDFFA42BEA2EB3A1C6021F3628924@correo.fagorautomation.net> you wrote:
> 
> We are planning to develop a new product based on a MPC5200 and Linux
> RTAI. So we are evaluating the BDI2000 and we have found some problems
> when we pretend to debug de linux kernel. Starting with U-boot we are
> able to break at start_kernel() and do some steps and software
> breakpoints. But suddenly (inside the init() function) all the memory
> map becomes all 0's and the U-boot reboots. We think could be the

Did you read the processor's errata sheet?
Especially ID 330 "LSRL corrupts XLB Arbiter" ?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
What was sliced bread the greatest thing since?
