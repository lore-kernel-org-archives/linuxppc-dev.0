Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9BCAF679E6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Feb 2006 00:41:06 +1100 (EST)
Date: Wed, 15 Feb 2006 12:38:37 +0000
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: linuxppc-embedded@ozlabs.org, "linux-atm-general@lists.sourceforge.net"
	<linux-atm-general@lists.sourceforge.net>
Subject: mpc8260sar linux-2.6 and PQ2FADS support
Message-Id: <20060215123837.03480154.ajz@cambridgebroadband.com>
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

This email is just to announce that I've added linux-2.6 and PQ2FADS
support to the ATM driver on http://mpc8260sar.sourceforge.net/ .

This new support was submitted by Fabien Clement, to whom I am very
grateful.

I have not tested linux-2.6 or the PQ2FADS myself, but the code
looks good and is still working on linux-2.4 and the other platforms
supported by the driver(PM828 and MPC8272ADS).

Alex
