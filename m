Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 30E1BDE054
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Mar 2008 07:44:20 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JXMwj-0002Mo-2f
	for linuxppc-embedded@ozlabs.org; Thu, 06 Mar 2008 12:44:09 -0800
Message-ID: <15883376.post@talk.nabble.com>
Date: Thu, 6 Mar 2008 12:44:09 -0800 (PST)
From: khollan <khollan@daktronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Xilinx Temac link detect
In-Reply-To: <15616042.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <15616042.post@talk.nabble.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



I figure I could write a C program to talk to the ioctl in the TEMAC driver
and read the PHY register.  Does anyone have example code for talking to
network ioctl's?

Thanks

Kevin
-- 
View this message in context: http://www.nabble.com/Xilinx-Temac-link-detect-tp15616042p15883376.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
