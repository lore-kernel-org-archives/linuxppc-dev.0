Return-Path: <s.maiti@tcs.com>
Received: from inkolg01.tcs.com (inkolg01.tcs.com [203.197.96.54])
	by ozlabs.org (Postfix) with ESMTP id E7D4D679F8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 May 2006 14:44:30 +1000 (EST)
To: linuxppc-embedded@ozlabs.org
Subject: Help Needed: input overrun(s)
MIME-Version: 1.0
From: s.maiti@tcs.com
Message-ID: <OF00585CA1.4BAD2F12-ON6525716A.0018127A-6525716A.00191467@tcs.com>
Date: Wed, 10 May 2006 10:03:55 +0530
Content-Type: text/plain; charset="us-ascii"
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

I am currently involve in development of Multi-Channel Controller (MCC) 
driver for MPC8260 processor. Whenever we are loading the driver, on the 
console we are receiving a print "ttyS: 1 input overrun(s)" along with 
other prints of the driver and resulting in scrambled output. 
Can anyone suggest why this is happening? Is the driver affecting the uart 
driver? We have seen the memory map thoroughly, there is no issue of 
memory conflict. Any help in this regards, I will be grateful.

Thnaks and regards,
Souvik Maiti
Tata Consultancy Services Limited
Mailto: s.maiti@tcs.com
Website: http://www.tcs.com
=====-----=====-----=====
Notice: The information contained in this e-mail
message and/or attachments to it may contain 
confidential or privileged information. If you are 
not the intended recipient, any dissemination, use, 
review, distribution, printing or copying of the 
information contained in this e-mail message 
and/or attachments to it are strictly prohibited. If 
you have received this communication in error, 
please notify us by reply e-mail or telephone and 
immediately and permanently delete the message 
and any attachments. Thank you
