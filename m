Return-Path: <laurent.pinchart@technotrade.biz>
Received: from outmx022.isp.belgacom.be (outmx022.isp.belgacom.be
	[195.238.4.203])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AD85DDDE23
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Feb 2007 23:08:27 +1100 (EST)
Received: from outmx022.isp.belgacom.be (localhost [127.0.0.1])
	by outmx022.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l1EC8KRF022060
	for <linuxppc-embedded@ozlabs.org>; Wed, 14 Feb 2007 13:08:20 +0100
	(envelope-from <laurent.pinchart@technotrade.biz>)
Received: from mail.technotrade.biz (49.198-78-194.adsl-fix.skynet.be
	[194.78.198.49])
	by outmx022.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l1EC8IxE022041
	for <linuxppc-embedded@ozlabs.org>; Wed, 14 Feb 2007 13:08:18 +0100
	(envelope-from <laurent.pinchart@technotrade.biz>)
Received: from mail.technotrade.biz (localhost [127.0.0.1])
	by mail.technotrade.biz (Postfix) with ESMTP id 9144A1BB6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Feb 2007 13:08:18 +0100 (CET)
Received: from pclaurent.technotrade.biz (pclaurent.technotrade.biz
	[192.168.1.47])
	by mail.technotrade.biz (Postfix) with ESMTP id 81BACD32
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Feb 2007 13:08:18 +0100 (CET)
From: Laurent Pinchart <laurent.pinchart@technotrade.biz>
To: linuxppc-embedded@ozlabs.org
Subject: Moving from arch/ppc to arch/powerpc with an MPC8248 (part 1)
Date: Wed, 14 Feb 2007 13:08:17 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200702141308.17815.laurent.pinchart@technotrade.biz>
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

I'm trying to take the big jump and move my (mostly) stable board support from 
arch/ppc to arch/powerpc. I'm still at a very early stage, but here are 
already a few questions.

arch/ppc defines some 8260 generic handlers in syslib/mpc8260_setup.c for 
operations such as halt, reset, show_cpuinfo, ... The MPC82xx ADS in 
arch/powerpc/platforms/82xx redefines those handles as board-specific 
functions. Should they be made generic to all 82xx boards, or should I copy 
them to my board-specific file ? If the code should be shared by all 82xx 
boards, I'll probably end up copying most of the 
arch/ppc/syslib/mpc8260_setup.c code to 
arch/powerpc/platforms/82xx/mpc82xx.c.

Best regards,

Laurent Pinchart
