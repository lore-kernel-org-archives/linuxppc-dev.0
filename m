Return-Path: <andre.schwarz@matrix-vision.de>
Received: from mail1.matrix-vision.com (mail1.matrix-vision.com [78.47.19.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "localhost", Issuer "localhost" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 52B42B6F18
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Jul 2011 00:01:45 +1000 (EST)
Received: from mail1.matrix-vision.com (localhost [127.0.0.1])
	by mail1.matrix-vision.com (Postfix) with ESMTP id 477DB722B1
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jul 2011 15:55:27 +0200 (CEST)
Received: from erinome (g2.matrix-vision.com [80.152.136.245])
	by mail1.matrix-vision.com (Postfix) with ESMTPA id DED8F720FC
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jul 2011 15:55:26 +0200 (CEST)
Received: from erinome (localhost [127.0.0.1])
	by erinome (Postfix) with ESMTP id F403F6F9B
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jul 2011 15:55:25 +0200 (CEST)
Received: from [192.168.65.238] (host65-238.intern.matrix-vision.de
	[192.168.65.238]) by erinome (Postfix) with ESMTPA id D7E906F9B
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jul 2011 15:55:25 +0200 (CEST)
Message-ID: <4E170C4D.50508@matrix-vision.de>
Date: Fri, 08 Jul 2011 15:55:25 +0200
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: LinuxPPC List <linuxppc-dev@ozlabs.org>
Subject: SRAM @ FSL eLBC
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'd like to use a SRAM device (512K*8) connected to a MPC8377 localbus.

What's a decent way to do this (mmap'ed access) running v2.6.34 ?

Is platform RAM (drivers/mtd/maps/plat-ram.c) a good starting point ?


Any hints are welcome.

-- 

Regards,
Andre



MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner, Erhard Meier
