Return-Path: <jangiels@speakeasy.net>
Received: from mail1.speakeasy.net (mail1.speakeasy.net [216.254.0.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A74F02BC0F
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Oct 2004 11:28:29 +1000 (EST)
Received: from dsl017-104-254.spk0.dsl.speakeasy.net (HELO [192.168.0.10])
	(jangiels@[69.17.104.254]) (envelope-sender <jangiels@speakeasy.net>)
	by mail1.speakeasy.net (qmail-ldap-1.03) with SMTP
	for <linuxppc-dev@ozlabs.org>; 21 Oct 2004 01:28:22 -0000
From: Jeff Angielski <jangiels@speakeasy.net>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1098322108.9230.13.camel@nighteyes.localdomain>
Mime-Version: 1.0
Date: Wed, 20 Oct 2004 21:28:28 -0400
Subject: SCC UART configuration - GSMR_H[RFW]
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


While debugging my SCC UART stall/hang I noticed that the GSMR_H[RFW] is
not being initialized when the SCC is configured for UART mode. 
However, in the MPC8260 documentation that I have it specifically says
in Table 20-1 GSMR_H Field Descriptions, "This configuration must be
chosen for character-oriented protocols such as UART."

I checked all of these kernels and none of them set this bit: kernel.org
2.4.27, current 2.4.x DENX, and the kernel.org 2.6.8.1.

Was this done on purpose?  Is the documentation wrong?

FWIW, I noticed that u-boot sets this bit when it initializes the SCC
for UART mode...

Jeff Angielski
