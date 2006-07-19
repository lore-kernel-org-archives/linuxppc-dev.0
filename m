Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx025.isp.belgacom.be (outmx025.isp.belgacom.be
	[195.238.4.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 60F1367B55
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jul 2006 01:20:03 +1000 (EST)
Received: from outmx025.isp.belgacom.be (localhost [127.0.0.1])
	by outmx025.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k6JFJtIP001090
	for <linuxppc-embedded@ozlabs.org>; Wed, 19 Jul 2006 17:19:55 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
Received: from servernt.technotrade (49.198-78-194.adsl-fix.skynet.be
	[194.78.198.49])
	by outmx025.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k6JFJrtY001076
	for <linuxppc-embedded@ozlabs.org>; Wed, 19 Jul 2006 17:19:53 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org
Subject: MPC8260 SCC UART hardware flow control
Date: Wed, 19 Jul 2006 17:18:00 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200607191718.00328.laurent.pinchart@tbox.biz>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi everybody,

I was wondering if anyone had implemented hardware flow control support in the 
cpm_uart driver. If not, I would appreciate pointers regarding how to do so.

Best regards,

Laurent Pinchart
