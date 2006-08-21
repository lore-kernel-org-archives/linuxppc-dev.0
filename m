Return-Path: <Artur.Barkhudaryan@epygiarm.am>
Received: from epygiarm.am (smtp.epygiarm.am [195.69.162.137])
	by ozlabs.org (Postfix) with ESMTP id 471D467B77
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Aug 2006 01:20:02 +1000 (EST)
Received: from [192.168.0.154] ([192.168.0.154])
	by epygiarm.am (epygiarm.am [192.168.0.156]) (MDaemon PRO v9.0.0)
	with ESMTP id md50001229456.msg
	for <linuxppc-embedded@ozlabs.org>; Mon, 21 Aug 2006 20:19:18 +0500
Date: Mon, 21 Aug 2006 20:14:09 +0500
From: Artur Barkhudaryan <Artur.Barkhudaryan@epygiarm.am>
Message-ID: <777574358.20060821201409@epygiarm.am>
To: linuxppc-embedded@ozlabs.org
Subject: u-boot problem with serial console on SMC1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Reply-To: Artur Barkhudaryan <Artur.Barkhudaryan@epygiarm.am>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I have an MPC8272 board with serial console on SMC1. I am trying to
make it work with u-boot 1.1.4. It does work, but it hangs when I
press Enter continuously (sometimes after just the first key press).
The trap code is 0200 and it appears to be some SMC1 receive problem.
Does anyone else experience the same problem ?

-- 
Thanks,
 Artur Barkhudaryan
