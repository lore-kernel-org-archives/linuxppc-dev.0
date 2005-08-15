Return-Path: <rober@opnet.com.tw>
Received: from opnet2.opnet.com.tw (unknown [210.243.240.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E26DA67EB8
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 15 Aug 2005 18:22:44 +1000 (EST)
Received: from [10.0.14.26] (h248-210-243-240.opnet.com.tw [210.243.240.248]
	(may be forged))
	by opnet2.opnet.com.tw (8.13.3/8.13.1) with ESMTP id j7FGIZMU004291
	for <linuxppc-embedded@ozlabs.org>; Mon, 15 Aug 2005 16:18:36 GMT
	(envelope-from rober@opnet.com.tw)
From: =?UTF-8?Q?=E5=BE=90=E5=B0=8F?= =?UTF-8?Q?=E5=A8=81?= <rober@opnet.com.tw>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Mon, 15 Aug 2005 16:22:33 +0800
Message-Id: <1124094153.13556.3.camel@banana>
Mime-Version: 1.0
Subject: how to run iptables-1.2.9  at Kernel 2.4.25
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all:

    I got some problem at compiler iptables 1.2.9 at my 2.4.25 Linux,
anybody know how to solve it?

PS:I used eldk 3.1.1 and 2.4.25 kernel at my custom MPC852T board.

extensions/libipt_ULOG.c: In function `init':
extensions/libipt_ULOG.c:58: error: `NFLOG_DEFAULT_NLGROUP' undeclared
(first use in this function)
extensions/libipt_ULOG.c:58: error: (Each undeclared identifier is
reported only once
extensions/libipt_ULOG.c:58: error: for each function it appears in.)
extensions/libipt_ULOG.c:59: error: `NFLOG_DEFAULT_QTHRESHOLD'
undeclared (first use in this function)
extensions/libipt_ULOG.c: In function `save':
extensions/libipt_ULOG.c:158: error: `NFLOG_DEFAULT_NLGROUP' undeclared
(first use in this function)
extensions/libipt_ULOG.c:165: error: `NFLOG_DEFAULT_QTHRESHOLD'
undeclared (first use in this function)
make: *** [extensions/libipt_ULOG.o] Error 1
