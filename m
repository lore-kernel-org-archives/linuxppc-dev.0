Return-Path: <scarayol@assystembrime.com>
Received: from srv_courtaboeuf.brime.fr (unknown [81.255.87.178])
	by ozlabs.org (Postfix) with ESMTP id 2B8CA67A6D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Jun 2005 19:07:32 +1000 (EST)
To: linuxppc-embedded@ozlabs.org
Message-ID: <OFD72AE9CC.023B6AC3-ONC1257029.0030219E@brime.fr>
From: scarayol@assystembrime.com
Date: Thu, 23 Jun 2005 11:09:20 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Subject: Fast Ethernet device driver for MPC885
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all.

I use a custom board with a MPC885 microprocessor. I want to test the
Ethernet chain on my board so i made an external loopback on the Ethernet
port. I want to transmit datas and read the received datas.

Which driver have i to use and which name to open it. I don' see any driver
that seems to be the fec one in /dev/..  I think i have to use the routines
in pqfec.c instead of fec.c. But I don't know how the driver works.
Which kind of driver is it and how access to the routines from user space
in order to do my tests ?

Thank you really for your help.

Sophie CARAYOL
