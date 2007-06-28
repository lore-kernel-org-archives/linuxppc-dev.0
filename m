Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9B0E7DDFB3
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jun 2007 22:01:37 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1I3sgo-0006o5-7K
	for linuxppc-embedded@ozlabs.org; Thu, 28 Jun 2007 05:01:34 -0700
Message-ID: <11341785.post@talk.nabble.com>
Date: Thu, 28 Jun 2007 05:01:34 -0700 (PDT)
From: sarpa <vsarpangala@satline.net>
To: linuxppc-embedded@ozlabs.org
Subject: uncompressing zImage
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


I am unable to complete gunzip called from arch/ppc/boot/simple/misc.c. The
gunzip code is in arch/ppc/boot/common/misc-common.c & it is trying to do
"zalloc()". Here i am getting avail_ram greater than end_avail. So its stops
executing further. I have my RAM from 0x00000000 to 0x02000000. In this I
had copied zImage at 0x00800000. Now i am unable to continue from misc.c
file's decompress algorithm. Please provide me some tips or suggestions.

Thanks & Regards,
  Sarpa
-- 
View this message in context: http://www.nabble.com/uncompressing-zImage-tf3994018.html#a11341785
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
