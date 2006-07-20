Return-Path: <AZeffertt@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C73A267B84
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jul 2006 20:39:58 +1000 (EST)
Message-ID: <44BF5D6D.1070400@cambridgebroadband.com>
Date: Thu, 20 Jul 2006 11:39:41 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org, linux-atm-general@lists.sourceforge.net
Subject: mpc8360sar
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi lists,

I'm writing to announce a new project http://mpc8360sar.sourceforge.net .
This is an ATM driver for the QUICC Engine (QE) of the PowerQUICC II Pro
range of processors.  It is based on Tony Li's fsl-atm driver and my
mpc8260sar driver.  I've basically used Tony's driver for the most low level
stuff and ported a lot of extra functionality from my PQII driver.

You will need the Linux BSP from Freescale to build this driver.

I have only tested this driver on mpc832xe-mds, but it should also work on
the mpc8360e-pb board.

If you use mpc8360sar, please let me know how you get on.  In particular
let me know if you work out how to stop the QE occaisionally corrupting the
TCT when using external channels.

Regards,

Alex
