Return-Path: <wei.li4@elf.mcgill.ca>
Received: from drizzle.cc.mcgill.ca (drizzle.cc.mcgill.ca [132.206.27.48])
	by ozlabs.org (Postfix) with ESMTP id B6A5E67B5A
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Sep 2006 05:51:51 +1000 (EST)
Received: from mailscan1.cc.mcgill.ca (mailscan1.CC.McGill.CA [132.216.77.248])
	by drizzle.cc.mcgill.ca (8.12.11/8.12.3) with ESMTP id k8FJpnmu010158
	for <linuxppc-embedded@ozlabs.org>; Fri, 15 Sep 2006 15:51:49 -0400
Received: from wgrappe1.cc.mcgill.ca (wgrappe1.CC.McGill.CA [132.216.46.250])
	by mailscan1.cc.mcgill.ca (8.13.6/8.13.0) with ESMTP id
	k8FJpeMi027221 for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Sep 2006 15:51:40 -0400 (EDT)
Received: from wgrappe1.cc.mcgill.ca (localhost.localdomain [127.0.0.1])
	by wgrappe1.cc.mcgill.ca (8.13.7/8.13.4) with ESMTP id k8FJpdAP015120
	for <linuxppc-embedded@ozlabs.org>; Fri, 15 Sep 2006 15:51:39 -0400
Received: (from apache@localhost)
	by wgrappe1.cc.mcgill.ca (8.13.7/8.13.7/Submit) id k8FJpdSj015117
	for linuxppc-embedded@ozlabs.org; Fri, 15 Sep 2006 15:51:39 -0400
Message-ID: <20060915155139.3u0q0lb5s0g0ww0s@webmail.mcgill.ca>
Date: Fri, 15 Sep 2006 15:51:39 -0400
From: wei.li4@elf.mcgill.ca
To: linuxppc-embedded@ozlabs.org
Subject: Kernel Blocked
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,

First, if anyone wants to use linux 2.6.18-rc2-g73a589b5 with ppc, he 
should patch inflate.c from linux 2.6.18-rc7 to fix Uncompressing 
failure problem. But new problem is: when relocate and gunzip functions 
are finished, and 'Now booting the kernel' is shown, the system is 
halted. My bootloader is working fine with linux 2.6.13, could anyone 
tell me what the next function executes and how to check this kind of 
problem, thanks.

Wei
