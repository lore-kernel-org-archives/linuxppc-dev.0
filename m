Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id AFB4367C00
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Dec 2006 02:56:14 +1100 (EST)
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id C1B3B99635
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Dec 2006 16:56:12 +0100 (CET)
Received: from [172.16.0.100] (p5497EE5C.dip.t-dialin.net [84.151.238.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id A26EC93670
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Dec 2006 16:56:12 +0100 (CET)
Message-ID: <4576E8CC.6050508@grandegger.com>
Date: Wed, 06 Dec 2006 16:59:08 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: How to use the device tree for lite5200
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

Hello,

I want to boot PowerPC Linux 2.6.19 on my Icecube board but I didn't 
succeed yet to get lite5200.dts compiled and an appropriate image created:

   $ dtc -b0 lite5200.dts
   DTC: dts->dts  on file "lite5200.dts"
   ERROR: Missing /chosen node
   Input tree has errors

What is the procedure to make and boot an uImage for the U-Boot 
bootloader. I read about the third argument for bootm but did not 
understand how to use it.

TIA.

Wolfgang.
