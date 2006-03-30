Return-Path: <jean-francois.hasson@hispano-suiza-sa.com>
Received: from snecma2.snecma.fr (snecma2.snecma.fr [195.220.252.67])
	by ozlabs.org (Postfix) with ESMTP id EB79167A3F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Mar 2006 17:47:42 +1100 (EST)
From: <jean-francois.hasson@hispano-suiza-sa.com>
Received: from localhost (unknown [127.0.0.1])
	by H465140T.snecma.fr (Symantec Mail Security) with ESMTP id 2DF1611
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Mar 2006 08:34:12 +0200 (CEST)
Received: from mail.snecma.fr (unknown [195.220.252.125])
	by H465140T.snecma.fr (Bienvenue au service SMTP) with ESMTP id E447AF8
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Mar 2006 08:34:11 +0200 (CEST)
Received: from h319300a.win-master.hsa.snecma ([128.30.41.23]) by
	mail.snecma.fr (AIX4.3/8.9.3/8.8.8) with ESMTP id IAA26862 for
	<linuxppc-embedded@ozlabs.org>; Thu, 30 Mar 2006 08:24:42 +0200
Subject: linux 2.4 on ml403
To: linuxppc-embedded@ozlabs.org
Message-ID: <OF281713A1.B46F6CC0-ONC1257141.0023B19E-C1257141.00241646@win-master.hsa.snecma>
Date: Thu, 30 Mar 2006 08:34:06 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I have been trying to run a linux 2.4 devel from the montavista site on an
ml403 following among other things some advice from BYU website. I managed
to have Linux start on the ml403 after downaloading it with XMD but then I
have an error message :

Xilinx Virtex-II Pro port (C) 2002 MontaVista Software, Inc.
(source@mvista.com)
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,9600 root=/dev/xsysace/disc0/part3 rw
Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFE000
Calibrating delay loop... 99.73 BogoMIPS
Oops: kernel access of bad area, sig: 11
NIP: 00000000 XER: 0000005E LR: 00000000 SP: C0182E50 REGS: c0182da0 TRAP:
0400
   Not tainted
MSR: 00001030 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0181020[0] 'swapper' Last syscall: 0
last math 00000000 last altivec 00000000
GPR00: 00000000 C0182E50 C0181020 C0181020 00000000 00000001 C0181120
00000048
GPR08: 00000048 00000000 00000000 00000017 24000022 0000CC60 00000000
00000000
GPR16: 00000000 00000000 00000000 00000000 00001032 00182ED0 00000000
C0000000
GPR24: C019DDB0 00000001 C01A0000 C01A0000 044AA234 00000001 00000000
C0181020
Call backtrace:
00000000 C001C27C C0005F30 C00047C0 C0196064 C01943B8 C019154C
C0002328
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
 <0>Rebooting in 180 seconds..

Does anyone have an idea as to what is wrong ? How could I investigate it ?
I have turned on the xmon option while building the kernel and it indicates
I have a kernel stack overflow. If it could help.

Best regards,

JF H



#
  This e-mail and any attached documents may contain confidential or proprietary information. If you are not the intended recipient, please advise the sender immediately and delete this e-mail and all attached documents from your computer system. Any unauthorised disclosure, distribution or copying hereof is prohibited. 

  Ce courriel et les documents qui y sont attaches peuvent contenir des informations confidentielles. Au cas ou vous ne seriez pas le destinataire de ce courriel, vous etes prie d'en informer l'expediteur immediatement et de le detruire  ainsi que tous les documents attaches de votre systeme informatique. Toute divulgation, distribution ou copie du present courriel et des documents attaches sans autorisation prealable de son emetteur est interdite. 
#
