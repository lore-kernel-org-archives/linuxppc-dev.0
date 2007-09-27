Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 69E9FDDE18
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Sep 2007 18:12:22 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IaoTr-0000R6-FL
	for linuxppc-embedded@ozlabs.org; Thu, 27 Sep 2007 01:12:19 -0700
Message-ID: <12916782.post@talk.nabble.com>
Date: Thu, 27 Sep 2007 01:12:19 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Is it safe to use these Linux function (test_bit(), set_bit(),
	clear_bit()) in character device driver for 2.6.10 ppc kernel.
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_19903_32446584.1190880739470"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_19903_32446584.1190880739470
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Hi all

I am using "test_bit(),set_bit(),clear_bit() etc" API functions provided by
the Linux kernel. I want to know that if anybody is used it and have full
faith in its operation then please let me know. Driver in the while loop is
calling these API's hence i want to make sure that its operation will remain
stable.

I need your comments in this regard 

Thank you 
Misbah
-- 
View this message in context: http://www.nabble.com/Is-it-safe-to-use-these-Linux-function-%28test_bit%28%29%2Cset_bit%28%29%2Cclear_bit%28%29%29-in-character-device-driver-for-2.6.10-ppc-kernel.-tf4527008.html#a12916782
Sent from the linuxppc-embedded mailing list archive at Nabble.com.

------=_Part_19903_32446584.1190880739470
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit


Hi all

I am using "test_bit(),set_bit(),clear_bit() etc" API functions provided by the Linux kernel. I want to know that if anybody is used it and have full faith in its operation then please let me know. Driver in the while loop is calling these API's hence i want to make sure that its operation will remain stable.

I need your comments in this regard 

Thank you 
Misbah
<br><hr align="left" width="300">
View this message in context: <a href="http://www.nabble.com/Is-it-safe-to-use-these-Linux-function-%28test_bit%28%29%2Cset_bit%28%29%2Cclear_bit%28%29%29-in-character-device-driver-for-2.6.10-ppc-kernel.-tf4527008.html#a12916782">Is it safe to use these Linux function (test_bit(),set_bit(),clear_bit()) in character device driver for 2.6.10 ppc kernel.</a><br>
Sent from the <a href="http://www.nabble.com/linuxppc-embedded-f15994.html">linuxppc-embedded mailing list archive</a> at Nabble.com.<br>

------=_Part_19903_32446584.1190880739470--
