Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EDDCDDDE25
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Aug 2007 21:21:57 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IN5KU-0008Pl-An
	for linuxppc-embedded@ozlabs.org; Mon, 20 Aug 2007 04:21:54 -0700
Message-ID: <12234154.post@talk.nabble.com>
Date: Mon, 20 Aug 2007 04:21:54 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: problem in configuring PC13 for Ext interrupt
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

I myself is working on PPC 8272, There i am facing a serious problem . The
problem is this :-

I have configured PC13 for an external Interrupt In the Init of the driver.
The configuration is OK, but when ever i press a key from the key board i
use to get an an interrupt from PC13 (The handler is being called )
regardless of whether the interrupt is comming or not.

Please send me ur suggessions for this unpredictible issue.

regard 
Misbah
-- 
View this message in context: http://www.nabble.com/problem-in-configuring-PC13-for-Ext-interrupt-tf4298263.html#a12234154
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
