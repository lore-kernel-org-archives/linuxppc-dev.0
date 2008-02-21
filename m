Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 699D0DDDF4
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Feb 2008 16:48:46 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JS4IU-0008O1-Be
	for linuxppc-embedded@ozlabs.org; Wed, 20 Feb 2008 21:48:42 -0800
Message-ID: <15605219.post@talk.nabble.com>
Date: Wed, 20 Feb 2008 21:48:42 -0800 (PST)
From: Silwer star <fariyaf@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: EBC access
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


Hi,

I am working on the PPC 405EX processor with a peripheral attached to the
EBC. I've requested for I/O memory & mapped it using ioremap. The following
are my doubts:

1) How do I ensure that the memory range that I requested is non-cacheable.
I've to work with non-cacheable memory.  I've requested for memory using
request_mem_region( ). 
2) Between any consecutive writes or any consecutive reads, if I introduce a
delay of 500msec, the read/write is completing.  Does this have to do
anything with caching? What could be the  reason for this?

Any help will be appreciated.

Regards,
Silwer Star
-- 
View this message in context: http://www.nabble.com/EBC-access-tp15605219p15605219.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
