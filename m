Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4117FDDDEA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jul 2007 05:15:40 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1I8het-0000Z7-OH
	for linuxppc-embedded@ozlabs.org; Wed, 11 Jul 2007 12:15:31 -0700
Message-ID: <11547023.post@talk.nabble.com>
Date: Wed, 11 Jul 2007 12:15:31 -0700 (PDT)
From: khollan <khollan@daktronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: ML410 PCI support
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


I have two questions:
1) Has anyone wrote linux 2.6 PCI drviers for the xilinx development boards. 
I want to get the PCI slots working on my board.
2)How do I set the HwAddr for the TEMAC driver?  Im using Grants latest git
tree.  My board boots and the HwAddr is set to 00:00:00:00:00:00
Thanks for your help
Kevin
-- 
View this message in context: http://www.nabble.com/ML410-PCI-support-tf4064052.html#a11547023
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
