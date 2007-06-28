Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1720BDDF83
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Jun 2007 03:53:27 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1I3yBH-0000DR-Km
	for linuxppc-embedded@ozlabs.org; Thu, 28 Jun 2007 10:53:23 -0700
Message-ID: <11347823.post@talk.nabble.com>
Date: Thu, 28 Jun 2007 10:53:23 -0700 (PDT)
From: khollan <khollan@daktronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Porting Linux to Xilinx ML410
In-Reply-To: <20070627211825.GA2003@cip.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <11328063.post@talk.nabble.com>
	<20070627211825.GA2003@cip.informatik.uni-erlangen.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



I fixed my error.  I was using gcc 4.1.0 and read some other threads here
and found that there is a linker error in gcc 4.1.0  So I created a new
toolchain with crosstool with gcc 4.0.2 and my system booted until it tried
to mount the root file system like I had planned.  Now Ill have to create a
rfs and see if it will boot all the way.

Thanks for your replies

Kevin

-- 
View this message in context: http://www.nabble.com/Porting-Linux-to-Xilinx-ML410-tf3989483.html#a11347823
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
