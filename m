Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E2AABDDEA0
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 22:13:19 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1INSbl-0005q8-0D
	for linuxppc-dev@ozlabs.org; Tue, 21 Aug 2007 05:13:17 -0700
Message-ID: <12253417.post@talk.nabble.com>
Date: Tue, 21 Aug 2007 05:13:16 -0700 (PDT)
From: sivaji <rameshmrm@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Skipping the host bridge in arch/powerpc
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hai,
        I am using the kernel 2.6.21. In the file
(arch/ppc/syslib/pci_auto.c) we have the function pciauto_bus_scan(). In
this function it will skip the host birdge. But in the arch/powepc directory
we don't have that types of file and the function pciauto_bus_scan() also
removed.
I want to know where the function was moved in arch/powerpc directory ?
How the host bridge was skip in the arch/powerpc directory. 
-- 
View this message in context: http://www.nabble.com/Skipping-the-host-bridge-in-arch-powerpc-tf4304798.html#a12253417
Sent from the linuxppc-dev mailing list archive at Nabble.com.
