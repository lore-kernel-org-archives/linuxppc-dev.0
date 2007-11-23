Return-Path: <gsk19@bezeqint.net>
Received: from sa3.bezeqint.net (sa3.bezeqint.net [192.115.104.17])
	by ozlabs.org (Postfix) with ESMTP id 03487DDEC5
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Nov 2007 04:40:25 +1100 (EST)
Received: from localhost (sa3 [127.0.0.1])
	by sa3.bezeqint.net (Bezeq International SMTP out Mail Server) with
	ESMTP id 999D9301B2 for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Nov 2007 18:58:59 +0200 (IST)
Received: from sa3.bezeqint.net ([127.0.0.1])
	by localhost (sa3.bezeqint.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4UQg7QwkQkDX for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Nov 2007 18:58:59 +0200 (IST)
Received: from mas23.bezeqint.net (mas23.bezeqint.net [192.115.104.153])
	by sa3.bezeqint.net (Bezeq International SMTP out Mail Server) with
	ESMTP for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Nov 2007 18:58:59 +0200 (IST)
From: <gsk19@bezeqint.net>
Subject: MontaVista 4.0.1 on Xilinx ML405 board
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20071123185858.DSC68826@mas23.bezeqint.net>
Date: Fri, 23 Nov 2007 18:58:58 +0200 (IST)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

We built a design for ML405 using EDK 9.1.02. EDK also 
creates linux drivers for MontaVista Pro 4.0.1 (2.6.10).
The drivers were copied to a clean copy of Pro 4.0.1 and the 
kernel was built. When we downloaded the kernel to the target 
and ran it, we got exception. We didn't get any messages on 
the hyper terminal. 
We used Tri-Mode Ethernet and UART lite.
MontaVista checked the integration of EDK 8.2 with ML403. 
Can you help ?
