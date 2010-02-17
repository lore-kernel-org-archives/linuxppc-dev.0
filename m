Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B65FCB7D47
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Feb 2010 23:55:26 +1100 (EST)
Received: from bzq-79-182-17-112.red.bezeqint.net ([79.182.17.112]:50281
	helo=[10.0.0.2]) by vega.surpasshosting.com with esmtpa (Exim 4.69)
	(envelope-from <felix@embedded-sol.com>) id 1NhjR4-0007Tx-LW
	for linuxppc-dev@ozlabs.org; Wed, 17 Feb 2010 07:55:22 -0500
Message-ID: <4B7BE719.9070107@embedded-sol.com>
Date: Wed, 17 Feb 2010 14:54:49 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Starting bare metal application on second core of P2020
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

We'd like to run Linux on core0 of P2020 and some bare metal application 
running without OS
on core1. Is it possible to start this application from Linux ? I've 
seen example of running 2 copies
of Linux in AMP mode, in which case both are started from u-boot. I'd 
like to leave core1 in
reset, start Linux on core0 from u-boot and load bare metal application 
from Linux. If this
possible, where can I learn about the procedure ?

Thanks.

Felix.
