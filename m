Return-Path: <rick.mcbain@logicsense.com>
Received: from mail78.megamailservers.com (mail78.megamailservers.com
	[216.251.36.78])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 861EC2BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Nov 2004 10:58:02 +1100 (EST)
Received: from RicksPresario900 (d154-20-197-204.bchsia.telus.net
	[154.20.197.204])
	by mail78.megamailservers.com (8.12.10/8.12.9) with ESMTP id
	iA3NHSxU009811
	for <linuxppc-embedded@ozlabs.org>; Wed, 3 Nov 2004 18:17:37 -0500
From: "Rick McBain" <rick.mcbain@logicsense.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Wed, 3 Nov 2004 15:17:27 -0800
Message-ID: <002b01c4c1fb$49adde60$6802a8c0@RicksPresario900>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Linux port for the AMCC (was IBM) 440EP
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Does anybody have a working distribution for the 440EP? We were planning
to use a Timesys port, but we've now been told it doesn't exist (after
months of promises it did.).  Our other option is to pay US$25K to
MontaVista, but that seems a tad pricey, and our previous experience
with them is that they delivered us an ARM port which fundamentally
didn't work.

Best regards,
Rick McBain
LogicSense Networks
www.logicsense.com

BTW. We are currently in the process of debugging our Uboot/PPCboot port
to the 440EP which supports NAND flash...
