Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1A776DDFBF
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Feb 2008 06:41:53 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JMq9W-0004N6-MH
	for linuxppc-embedded@ozlabs.org; Wed, 06 Feb 2008 11:41:50 -0800
Message-ID: <15312437.post@talk.nabble.com>
Date: Wed, 6 Feb 2008 11:41:50 -0800 (PST)
From: khollan <khollan@daktronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: System Clock runaway on Xilinx platform
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


Hi all,

Thanks for the help so far!
I'm now running linux 2.6.21 on my custom virtex 4 board modeled after the
ml410.  The cpu clock is 300MHz and the PLB bus is 175MHz.

My question is which clock is the linux system clock that keeps track of the
date derived from?  I set my date with rdate -s time.mit.edu at boot and
then compare with the date command and rdate -p time.mit.edu and they are
off by 20 or so seconds even just after a few minutes, this trend continues
and it will be off by a day after a few hours.  I think I just don't have
something defined correctly but I can't figure out which.

Thanks

Kevin
-- 
View this message in context: http://www.nabble.com/System-Clock-runaway-on-Xilinx-platform-tp15312437p15312437.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
