Return-Path: <martyn.welch@ge.com>
Received: from exprod5og105.obsmtp.com (exprod5og105.obsmtp.com [64.18.0.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8CF51B7C8E
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jan 2010 03:23:13 +1100 (EST)
Message-ID: <4B548A6A.5010708@ge.com>
Date: Mon, 18 Jan 2010 16:20:58 +0000
From: Martyn Welch <martyn.welch@ge.com>
MIME-Version: 1.0
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: GE GPIO and PIC support.
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'm currently adding support for a GE board based on the Freescale
P2020. This board has a cascaded interrupt controller and GPIO which
should be compatible with drivers currently provided for the MPC8641D
based boards that are already in the kernel.

At the moment the drivers (in gef_gpio.c and gef_pic.c) are in the
"arch/powerpc/platforms/86xx" folder. As the p2020 is not 86xx, I guess
I should move these drivers to a more central location. I'm currently
not sure where would be best to move them to, I see
"arch/powerpc/sysdev" and "arch/powerpc/platforms" as potential
locations, where would be the most suitable?

Martyn

-- 
Martyn Welch (Principal Software Engineer)   |   Registered in England and
GE Intelligent Platforms                     |   Wales (3828642) at 100
T +44(0)127322748                            |   Barbirolli Square, Manchester,
E martyn.welch@ge.com                        |   M2 3AB  VAT:GB 927559189
