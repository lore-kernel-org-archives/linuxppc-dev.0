Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0077E67A41
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Apr 2006 00:11:40 +1000 (EST)
Date: Thu, 27 Apr 2006 15:11:21 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: linuxppc-embedded@ozlabs.org, "linux-atm-general@lists.sourceforge.net"
	<linux-atm-general@lists.sourceforge.net>
Subject: QUICC Engine ATM driver
Message-Id: <20060427151121.7cd010dc.ajz@cambridgebroadband.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

Has anybody ported, or started to port, the mpc8260sar ATM driver for
the "PowerQUICC II" to the "PowerQUICC II Pro" (e.g. the MPC8360).  If
so I'd love to hear from you :)

Regards,

Alex


PS: For the record:

  PowerQUICC I contains a CPM1 which needs the mpc860sar driver
  PowerQUICC II & III contain a CPM2 which needs the mpc8260sar driver
  PowerQUICC II Pro contains a "QUICC Engine" ....
