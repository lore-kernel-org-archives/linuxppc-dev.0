Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E0C1EDDDA9
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 17:43:23 +1000 (EST)
Message-ID: <49FAA80A.7060107@embedded-sol.com>
Date: Fri, 01 May 2009 10:43:06 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, Sean MacLennan <smaclennan@pikatech.com>
Subject: Multiple NAND chips with 4xx NAND driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I will soon have 460EX board with twin die NAND device having
2 chip selects. A comment in ndfc driver says that several NAND
chips are not supported. What should be modified in the driver to
support such configuration ? I'd like to have a separate mtd device
per chip select, and then concatenate them into a single device, which
can later be partitioned. Do ndfc DTS bindings support that ?

Thanks a lot.

Felix.
