Return-Path: <jack_liu@usish.com>
Received: from ms.usish.com (ms.usish.com [61.152.132.204])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A21402BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Sep 2004 13:38:11 +1000 (EST)
Received: from usish000029-1 (usish000029-1 [192.168.56.62] (may be forged))
	by ms.usish.com (8.12.8/8.12.8) with ESMTP id i8U3blwk014749
	for <linuxppc-embedded@ozlabs.org>; Thu, 30 Sep 2004 11:38:03 +0800
Message-Id: <200409300338.i8U3blwk014749@ms.usish.com>
From: "Jack Liu" <jack_liu@usish.com>
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain;
      charset="GB2312"
Date: Thu, 30 Sep 2004 11:37:43 +0800
Subject: Re:MPC8272 PCI bridge problem?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi,Russell
=09We have a flash on CS2 rather a BCSR. And BR1 set at F8000000. I=
 am not sure this will be my problem, thanks anyway.
=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1
Best regard
Jack liu=09
---------Original message--------------------
=09I suspect one of your base registers (BR1) overlaps the memory=
 range that
the 
pci bridge is configured for.  It's probably BR1 since I believe=
 that's
normally 
0xf4500000 for the BMSR on your board.  You need to change PCI=
 I/O memory
window 
to some other range... 

Regards,

Russell
