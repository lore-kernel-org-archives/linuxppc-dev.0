Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 52DC8DDDD8
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Nov 2008 08:09:53 +1100 (EST)
Received: from bzq-79-178-117-167.red.bezeqint.net ([79.178.117.167]:50497
	helo=felix.lan) by vega.surpasshosting.com with esmtpa (Exim 4.69)
	(envelope-from <felix@embedded-sol.com>) id 1Kx6gJ-0003gv-Hz
	for linuxppc-embedded@ozlabs.org; Mon, 03 Nov 2008 16:09:51 -0500
Message-ID: <490F6882.6050101@embedded-sol.com>
Date: Mon, 03 Nov 2008 23:09:22 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Accessing PCI-E resources on 460EX
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I'm currently struggling with some application
that tries to access PCI-E memory by mmaping
address found in /sys/bus/pci/devices/<device>/resource

mmap() fails with "invalid argument" error, apparently
because on 460EX PCI addresses are 36-bit.

What is the correct way of accessing PCI-E from
userspace on this platform.

Thanks a lot.

Felix Radensky
Embedded Solutions Ltd.
http://www.embedded-sol.com
