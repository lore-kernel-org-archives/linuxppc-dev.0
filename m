Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CE2DCDE180
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Aug 2008 01:07:08 +1000 (EST)
Message-ID: <48B6B201.2070101@embedded-sol.com>
Date: Thu, 28 Aug 2008 17:11:13 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org, Stefan Roese <sr@denx.de>
Subject: GPIO interrupt on AMCC 460EX
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

I'm writing a Linux driver for CPLD access on custom
460EX based board. CPLD generates interrupt, which
is connected to GPIO pin 45. According to 460EX user
manual, this pin, if configured as alternate function 3,
will generate external interrupt 12, which is mapped into
irq 20 on UIC3.  My question is - how do I get irq number
suitable for passing to request_irq().

Thanks a lot.

Felix Radensky
Embedded Solutions Ltd.
http://www.embedded-sol.com
 
