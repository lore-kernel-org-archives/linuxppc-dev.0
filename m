Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 5AD2FDDEDA
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Feb 2008 12:06:11 +1100 (EST)
Received: from edison2.selinc.com (edison2.selinc.com [12.110.71.57])
	by tesla.selinc.com (8.12.11.20060308/8.12.11) with ESMTP id
	m1G168JY003256
	for <linuxppc-embedded@ozlabs.org>; Fri, 15 Feb 2008 17:06:08 -0800
To: linuxppc-embedded@ozlabs.org
Subject: Frustrated question with insmod
MIME-Version: 1.0
Message-ID: <OF994170A6.977C29F1-ON882573F1.0005A6C7-882573F1.00060311@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Fri, 15 Feb 2008 17:06:07 -0800
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sorry if this is the wrong place to post this question.  I'm developing a 
NAND flash driver and I need to do some detailed dubugging using GDB with 
a BDI2K.  According to the Denx web site, to find out the address that the 
module is loading at you load it using the -m parameter to insmod (i.e., 
"insmod -m mymodule").  However, every version of insmod I've tried 
doesn't recognize ANY options much less -m.  Can anyone please point me in 
the right direction, or give me another way of knowing what the load 
address of my module is?

Thanks.

Bruce
