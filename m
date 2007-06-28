Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4AA89DDEED
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jun 2007 15:52:31 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1I3mvZ-00068k-TP
	for linuxppc-embedded@ozlabs.org; Wed, 27 Jun 2007 22:52:25 -0700
Message-ID: <11337419.post@talk.nabble.com>
Date: Wed, 27 Jun 2007 22:52:25 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Problem in configuring interrupt in PPC 8272 processor using
	montavista linux 2.6 kernel
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



Hi All

I am facing problem in configuring PPC 8272 processor for interrupt . The
zeroth bit of SIUMCR register when set with 1 will be configured for IRQ3
else will be configured with BBD. Even though i am writing 1 to this bit
while inserting the driver and its actually writing 1 to that location
either , but the IRQ3 is not been configured for that and hence is
configured for BBD (BBD and IRQ3 are multiplexed) the result is that the bus
is toggling . As a consiguence of this my driver is getting infinite
interrupt and it is going to deadlock . 

If you have an experience of such problem ,i wish you could suggest me .
Hoping for a reply , for that i shall rema in thankful to you .

regard 
Misbah
-- 
View this message in context: http://www.nabble.com/Problem-in-configuring-interrupt-in-PPC-8272-processor-using-montavista-linux-2.6-kernel-tf3992552.html#a11337419
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
