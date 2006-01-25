Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx014.isp.belgacom.be (outmx014.isp.belgacom.be
	[195.238.4.69])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A9B5868AC3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Jan 2006 20:31:26 +1100 (EST)
Received: from outmx014.isp.belgacom.be (localhost [127.0.0.1])
	by outmx014.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id k0P9VJbQ011304
	for <linuxppc-embedded@ozlabs.org>; Wed, 25 Jan 2006 10:31:20 +0100
	(envelope-from <laurent.pinchart@tbox.biz>)
Received: from servernt.technotrade (49.198-78-194.adsl-fix.skynet.be
	[194.78.198.49])
	by outmx014.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id k0P9V4KK011097
	for <linuxppc-embedded@ozlabs.org>; Wed, 25 Jan 2006 10:31:09 +0100
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [FIXED] Trouble with SMC serial port in ppc/boot/simple on
	Embedded Planet 8248 board
Date: Wed, 25 Jan 2006 10:30:54 +0100
References: <200601240926.14408.laurent.pinchart@tbox.biz>
In-Reply-To: <200601240926.14408.laurent.pinchart@tbox.biz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200601251030.54402.laurent.pinchart@tbox.biz>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I've been able to fix the problem. I made a mistake in Linux boot code 
(ppc/boot/simple/embed_config.c) when computing the amount of available RAM, 
which resulted in Linux thinking it could access -16MB = 4080MB of RAM.

Laurent Pinchart
