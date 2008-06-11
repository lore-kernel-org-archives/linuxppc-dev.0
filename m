Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id E25C0DE488
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jun 2008 03:42:16 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1K6UKr-0003Bu-2D
	for linuxppc-embedded@ozlabs.org; Wed, 11 Jun 2008 10:42:13 -0700
Message-ID: <17783286.post@talk.nabble.com>
Date: Wed, 11 Jun 2008 10:42:13 -0700 (PDT)
From: Amarendra_Reddy <amar1567@yahoo.com>
To: linuxppc-embedded@ozlabs.org
Subject: Non PCI HCD Implementation
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi

Could any one give a brief description as how 
Non-PCI based OHCI HCD driver regristration shall take place in kernel
2.6.10
I mean what function calls are involved in sequence to achieve the USB
Device model.

Could you please suggest some ideas as how to proceed to develop a HCD for
ISP1362 with Non PCI based interface (PIO Interface).

Any help is greatly appreciated.

Thanks
Amae
-- 
View this message in context: http://www.nabble.com/Non-PCI-HCD-Implementation-tp17783286p17783286.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
