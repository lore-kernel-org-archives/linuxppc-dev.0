Return-Path: <kylej@aiinet.com>
Received: from aiexchange.ai.aiinet.com (ai181-196.aiinet.com
	[205.245.181.196]) by ozlabs.org (Postfix) with ESMTP id D51C867AAC
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Jan 2005 03:00:17 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Mon, 24 Jan 2005 11:00:35 -0500
Message-ID: <C0170D0AF1277849A4B4518034F855DD0F90CC@aiexchange.ai.aiinet.com>
From: "Jordan, Kyle" <kylej@aiinet.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: MPC8XX with an ISP1362 USB host controller in burst mode
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

We are currently planning to use an ISP1362 USB host controller with a
Freescale (Motorola) MPC8xx.  Our plan is to use the hcd-1161.c driver
for the 2.4 kernel for this device.  I was wondering if anyone out there
has used this combination operating in either bust mode or with burst
mode turned off.  We are running into some hardware design issues and we
did not know if we would suffer a large performance hit by not running
in burst mode with this particular driver.  If anyone has any experience
with this, I would greatly appreciate your advice.

Thanks,
  Kyle Jordan
