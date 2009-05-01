Return-Path: <fkan@amcc.com>
Received: from sdcmail01.amcc.com (sdcmail01.amcc.com [198.137.200.72])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 4BC72DDE98
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 07:06:50 +1000 (EST)
From: Feng Kan <fkan@amcc.com>
To: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
Subject: [PATCH 0/2] Added support for Designware SATA controller driver
Date: Fri,  1 May 2009 14:06:24 -0700
Message-Id: <1241211984-321-1-git-send-email-fkan@amcc.com>
Cc: sr@denx.de, Feng Kan <fkan@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fixed comment issue. Change goto statements to lower case. Also
fixed the Kconfig problem.

I don't know if I need to add Stefan Roese for the signoff, since he
did the of platform part.
Stefan, if you see this please let me know.

Feng Kan
