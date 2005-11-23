Return-Path: <adrian@humboldt.co.uk>
Received: from mail.humboldt.co.uk (mail.humboldt.co.uk [80.68.93.146])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8473D68820
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Nov 2005 03:34:06 +1100 (EST)
Received: from box.varisys.co.uk ([81.187.198.46] helo=[192.168.3.253])
	by mail.humboldt.co.uk with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.50) id 1Eex0h-0006y7-K2
	for linuxppc-embedded@ozlabs.org; Wed, 23 Nov 2005 15:58:15 +0000
From: Adrian Cox <adrian@humboldt.co.uk>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Wed, 23 Nov 2005 15:58:14 +0000
Message-Id: <1132761494.2776.14.camel@localhost>
Mime-Version: 1.0
Subject: Tsi108
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I've just received the evaluation board for the Tsi108 bridge:

http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=MCEVALHPC2-7448&nodeId=0162468rH3bTdGb9MM

The kernel supplied is 2.6.11.1, and it looks like it needs the
following to bring it up to date:

1) Using platform_device for on-chip resources.
2) Coding standards cleanup.
3) Fix the ethernet driver
3a) Fix bugs in stopping and starting interface
3b) remove virt_to_phys
3c) ethtool support?

Has anybody started on this before I begin?

-- 
Adrian Cox <adrian@humboldt.co.uk>
