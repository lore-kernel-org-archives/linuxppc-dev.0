Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 6F1C4DDF54
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  4 Aug 2008 22:31:35 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KPzDn-0003Ef-7W
	for linuxppc-embedded@ozlabs.org; Mon, 04 Aug 2008 05:31:31 -0700
Message-ID: <18810390.post@talk.nabble.com>
Date: Mon, 4 Aug 2008 05:31:31 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: How to Access SDRAM ?
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


I have an external SDRAM How could i access the last 4MB location of SDRAM
through my driver.

I have used ioremap() and it works during the initial testing i suspect that
since it is the real memory and not io memory hence we should not use it .

Can any one brief me on this .

Thank you 

--Misbah <><
-- 
View this message in context: http://www.nabble.com/How-to-Access-SDRAM---tp18810390p18810390.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
