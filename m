Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 6B00FDDF48
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 May 2008 01:54:25 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1K1Nyn-0000Cn-Hd
	for linuxppc-embedded@ozlabs.org; Wed, 28 May 2008 08:54:21 -0700
Message-ID: <17515929.post@talk.nabble.com>
Date: Wed, 28 May 2008 08:54:21 -0700 (PDT)
From: Mirek23 <miroslaw.dach@psi.ch>
To: linuxppc-embedded@ozlabs.org
Subject: Cross toolchain for ppc405 (virtex-4)
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


Hi All,

I am using for some time the crosstool tool-chain (crosstool-0.43) for the
ppc405 of my virtex-4.
It seems to be that the crosstool was not updated for awhile but the glibc
and gcc compiler has changed a bit meanwhile.

The latest working configuration to build the toolchain for ppc405 is
gcc-4.1.0-glibc-2.3.6.dat
Does any body has tried to adapt the crosstools to use for example glibc 2.7
?

Another alternative would be to use another tool than crosstool. Could
somebody recommend something which can refer to newer version of gcc and
glibc .

Best Regards

Miroslaw Dach 

-- 
View this message in context: http://www.nabble.com/Cross-toolchain-for-ppc405-%28virtex-4%29-tp17515929p17515929.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
