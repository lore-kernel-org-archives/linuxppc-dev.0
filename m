Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1C6AFDDFA3
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Feb 2008 04:36:18 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JSFLD-0001xz-Io
	for linuxppc-embedded@ozlabs.org; Thu, 21 Feb 2008 09:36:15 -0800
Message-ID: <15616042.post@talk.nabble.com>
Date: Thu, 21 Feb 2008 09:36:15 -0800 (PST)
From: khollan <khollan@daktronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: Xilinx Temac link detect
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


Hi 

Is there a good way to detect if the ethernet link is active at boot time,
so I can decided to setup the dchp and other network required stuff in an
init script.  When I try to setup this stuff and the cable is disconnected
it hangs.

Thanks

Kevin
-- 
View this message in context: http://www.nabble.com/Xilinx-Temac-link-detect-tp15616042p15616042.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
