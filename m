Return-Path: <laurent.pinchart@technotrade.biz>
Received: from outmx008.isp.belgacom.be (outmx008.isp.belgacom.be
	[195.238.5.235])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AA9DEDDE20
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Feb 2007 23:47:29 +1100 (EST)
Received: from outmx008.isp.belgacom.be (localhost [127.0.0.1])
	by outmx008.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l1EClF8M030316
	for <linuxppc-embedded@ozlabs.org>; Wed, 14 Feb 2007 13:47:16 +0100
	(envelope-from <laurent.pinchart@technotrade.biz>)
Received: from mail.technotrade.biz (49.198-78-194.adsl-fix.skynet.be
	[194.78.198.49])
	by outmx008.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l1ECl72J030234
	for <linuxppc-embedded@ozlabs.org>; Wed, 14 Feb 2007 13:47:07 +0100
	(envelope-from <laurent.pinchart@technotrade.biz>)
Received: from mail.technotrade.biz (localhost [127.0.0.1])
	by mail.technotrade.biz (Postfix) with ESMTP id 9AB9F1B6B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Feb 2007 13:47:07 +0100 (CET)
Received: from pclaurent.technotrade.biz (pclaurent.technotrade.biz
	[192.168.1.47])
	by mail.technotrade.biz (Postfix) with ESMTP id 8480174F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Feb 2007 13:47:07 +0100 (CET)
From: Laurent Pinchart <laurent.pinchart@technotrade.biz>
To: linuxppc-embedded@ozlabs.org
Subject: heartbeat replacement in arch/powerpc ?
Date: Wed, 14 Feb 2007 13:47:06 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200702141347.06885.laurent.pinchart@technotrade.biz>
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

is there any feature in arch/powerpc similar to the heartbeat callback in 
arch/ppc ? I need to reset a watchdog timer every 500ms in the early startup 
code, before the watchdog timer driver takes over.

Best regards,

Laurent Pinchart
