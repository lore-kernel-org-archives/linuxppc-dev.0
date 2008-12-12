Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id ECBEFDDFEB
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 13 Dec 2008 03:13:30 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LBAdq-0000g6-Ub
	for linuxppc-embedded@ozlabs.org; Fri, 12 Dec 2008 08:13:26 -0800
Message-ID: <20978466.post@talk.nabble.com>
Date: Fri, 12 Dec 2008 08:13:26 -0800 (PST)
From: "sarah.ddff" <sarah.ddff@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: two linux 2.6 kernels on two ppc405 (xupv2p) ?
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


Hi all,
I want to implement a multiprocessor system managed by a linux kernel on the
xupv2p.
I knwo that there is no cache coherency between the two ppc405 cores.
Consequently,
SMP linux can not be used.
So the only solution is to install two linux kernels, each on a ppc
processor,
and to make them communicate with shared memory.
My questions are:
does someone succeed in doing this?
Is it possible to do this ?

thanks
-- 
View this message in context: http://www.nabble.com/two-linux-2.6-kernels-on-two-ppc405-%28xupv2p%29---tp20978466p20978466.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
