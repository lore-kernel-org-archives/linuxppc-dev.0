Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 58A45DDDF9
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Feb 2009 00:21:41 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LV4Ak-0007HV-5H
	for linuxppc-dev@ozlabs.org; Thu, 05 Feb 2009 05:21:38 -0800
Message-ID: <21851244.post@talk.nabble.com>
Date: Thu, 5 Feb 2009 05:21:38 -0800 (PST)
From: Felix Radensky <felix@embedded-sol.com>
To: linuxppc-dev@ozlabs.org
Subject: ndfc driver on Kilauea board
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

I'm trying to enable Linux ndfc driver on Kilauea (ppc405ex) board rev 1.2
running
u-boot v2009.01 and linux-2.6.29-rc3. I've enabled NDFC in kernel config and
updated kilauea.dts as described in
Documentation/powerpc/dts-bindings/4xx/ndfc.txt
NDFC chip select is 1, so it matches the example in ndfc.txt
However driver probe routine is not called by the kernel, and NAND is not
identified. What am I missing ?  The same driver (backported) works for me
on custom 460EX board with u-boot-1.3.4 and linux-2.6.28

Thanks a lot in advance.

Felix.
-- 
View this message in context: http://www.nabble.com/ndfc-driver-on-Kilauea-board-tp21851244p21851244.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
