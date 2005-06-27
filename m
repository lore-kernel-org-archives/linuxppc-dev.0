Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (unknown [217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 81CFF67A62
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Jun 2005 22:56:38 +1000 (EST)
Date: Mon, 27 Jun 2005 13:56:22 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: "linux-atm-general@lists.sourceforge.net"
	<linux-atm-general@lists.sourceforge.net>, linuxppc-embedded@ozlabs.org
Message-Id: <20050627135622.08060af8.ajz@cambridgebroadband.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Announcing mpc8260sar.sourceforge.net
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

This email is to announce a new project on sourceforge.net

Homepage:	http://mpc8260sar.sourceforge.net

Summary:	an ATM driver for the PowerQUICCII

Notes:		

This driver was based on code taken from http://atm8260.sourceforge.net which is
a port of my orignal PQI driver - http://mpc860sar.sourceforge.net - to the
PQII.

The driver is presented in the form of a patch against Denx's linuxppc_2_4_devel
tree.

Currently the only supported platforms are the PM826/PM828 miriac power modules
with CR826 carrier.  However, I've added a framework which I hope will allow for
support of other platforms in the future.

I chose to create a new project rather than attempt to join the old atm8260
project.  I did this because I felt that the changes I made to the code were
large enough to warrant a new project rather than sending a patch to the old
one.  I also found that the code in atm8260 CVS seemed to have a lot missing and
wouldn't compile.  Anyway, having said this, I found that project enormously
helpful and I hope that I do not offend anybody by starting a new project.

Please see the site for a list of features added.

Alex
