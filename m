Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (unknown [217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B000667B2B
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 May 2005 02:02:37 +1000 (EST)
Date: Thu, 5 May 2005 17:02:21 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: linuxppc-embedded@ozlabs.org, "linux-atm-general@lists.sourceforge.net"
	<linux-atm-general@lists.sourceforge.net>
Message-Id: <20050505170221.3736f600.ajz@cambridgebroadband.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Port to port switching on the MPC8260 ATM SAR
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

Aparently the MPC8260 CPM can do port to port switching (PTP).  Has
anybody got this working?

I've looked at atm8260.sourceforge.net and there's a userspace program
mpc8260_user.c which appears to allow creation of PTP connections, but
the support in the device driver appears to be missing.

I would be very gratefull for any help,

Alex Zeffertt
