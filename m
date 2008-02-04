Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8CCDFDDEBC
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Feb 2008 00:54:59 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JM1mh-0006KW-El
	for linuxppc-embedded@ozlabs.org; Mon, 04 Feb 2008 05:54:55 -0800
Message-ID: <15268468.post@talk.nabble.com>
Date: Mon, 4 Feb 2008 05:54:55 -0800 (PST)
From: IngoM <ingo.maindorfer@ipm.fraunhofer.de>
To: linuxppc-embedded@ozlabs.org
Subject: [Virtex 4 PPC] Which Linux?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

we develop a new laser-ranging-system and our hardware freaks have choosen
the Virtex 4 FX 12 on the "AVNET FX12 Mini-Module". The system had to
deliver the raw data via UDP (12 Mbyte/sec) and on TCP the processed data
(about 6 Mbyte/sec). When you get the processed data via TCP then no data
send by UDP.

I'm confused by the following:

1) Hard-TEMAC vs. Soft-TEMAC.
Avnet provide a demo for the module which using Soft-TEMAC. If I get it
right this core has to be licenced. But when ther is a hard-TEMAC why pay
for it?

2) Linux
I'd like to build my kernel and filesystem myself. But which way to go?
Using OE, buildroot, ELDK...
Can you please provide some starting points for me?

3) Boot-Concept
The Mini-Module had only 4MB Flash. Is this enough for a root-fs?


Best Regards and thanks a lot,

Ingo
-- 
View this message in context: http://www.nabble.com/-Virtex-4-PPC--Which-Linux--tp15268468p15268468.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
