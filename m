Return-Path: <jivkojj@uni-kassel.de>
Received: from hrz-ws39.hrz.uni-kassel.de (smtp.hrz.uni-kassel.de
	[141.51.12.230]) by ozlabs.org (Postfix) with ESMTP id 6CADADDF36
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Aug 2008 19:16:25 +1000 (EST)
Received: from ws-86.rs.eecs.uni-kassel.de (rs-pc1.rs.eecs.uni-kassel.de
	[141.51.112.154])
	by hrz-ws39.hrz.uni-kassel.de (8.14.0/8.14.0) with ESMTP id
	m7599KYo004936
	for <linuxppc-embedded@ozlabs.org>; Tue, 5 Aug 2008 11:09:20 +0200
From: Zhivko Yordanov <jivkojj@uni-kassel.de>
To: linuxppc-embedded@ozlabs.org
Subject: Run Linux Kernel 2.6.26 with u-boot 1.1.2 - problem
Date: Tue, 5 Aug 2008 11:09:20 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200808051109.20398.jivkojj@uni-kassel.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I have a PowerPC embedded board with CPU 7448 and Chipset Marvell 64560.
Till now, on board runs U-boot 1.1.2 and Linux kernel 2.6.12, with patches 
from Marvell.

I ported the Marvell patch to Linux 2.6.26, but I can't start it. Now I'm 
searching for the problem. Is this possible with old u-boot (1.1.2) to start 
new versions of Linux kernel, or I need to port u-boot too?

Best regards,
Zhivko Yordanov
