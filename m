Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A218EDDE36
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Sep 2007 07:48:46 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IXOSP-0001Kb-Ri
	for linuxppc-embedded@ozlabs.org; Mon, 17 Sep 2007 14:48:41 -0700
Message-ID: <12745876.post@talk.nabble.com>
Date: Mon, 17 Sep 2007 14:48:41 -0700 (PDT)
From: Junqiang Hu <jqhu936@yahoo.com>
To: linuxppc-embedded@ozlabs.org
Subject: Ethernet adapter not found in Xilinx ppc, with linux 2.6.22
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



After several days of struggling I'm now able to boot the linux 2.6.22 and
run the busybox-1.7.1 root system.  Yet I could not find the Ethernet
adapter using Xilinx GMAC core.  Pretty sure that I've chosen the 10/100
Ethernet drivers.  Should I use the Xilinx driver xemac, or other drivers,
or any other way to apply a patch?

Thanks~
.J
-- 
View this message in context: http://www.nabble.com/Ethernet-adapter-not-found-in-Xilinx-ppc%2C-with-linux-2.6.22-tf4470255.html#a12745876
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
