Return-Path: <sithglan@stud.informatik.uni-erlangen.de>
Received: from faui03.informatik.uni-erlangen.de
	(faui03.informatik.uni-erlangen.de [131.188.30.103])
	by ozlabs.org (Postfix) with ESMTP id 584C8DDEBB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Jun 2007 17:50:10 +1000 (EST)
Date: Wed, 20 Jun 2007 09:41:21 +0200
From: Thomas Glanzmann <thomas@glanzmann.de>
To: linuxppc-embedded@ozlabs.org
Subject: AVNET/Memec Virtex4FX12LC Linux Kernel Tree
Message-ID: <20070620074120.GA12184@cip.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,
I would like to be able to boot a self compiled Linux 2.6(.20?!) Kernel on a
Virtex 4 FX 12 LC Board. I have the cross compile suite ready, compiled
a zImage an I am able to load it up. But nothing appears on the serial
device. I have a Montavista Demo based on a 2.4 and a so called Linux
Starter Kit also based on the 2.4 Kernel from Montavista / AVNET both
work. At least the kernel boots and I am able to reproduce the hardware
they used.  However I would like to know if for example a 2.6.20
upstream kernel works out of the box after I parameterized it the right
way or if there is a separate tree to begin with?

        Thomas
