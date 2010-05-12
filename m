Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5BA68B7D43
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 May 2010 12:40:22 +1000 (EST)
Subject: 440SPe/Katmai PCIe problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 12 May 2010 12:40:13 +1000
Message-ID: <1273632013.21352.88.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Pravin Bathija <pbathija@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Stefan !

(Or somebody from AMCC)

I noticed we still have this old problem on PCIe where some cards don't
seem to work. The link trains but they don't respond on config space.
This is the case for example of that Sunix quad USB card. It seems to be
related to the kind of TI PCIe <-> PCI bridge on these though.

Have anybody tracked down the root cause of the problem ? Some say that
it could be that the bridge doesn't cope with the double reset (uboot
then kernel). Would it be possible to tell uboot to avoid touching the
PCIe interface completely so the kernel is the first one to get in ?

Cheers,
Ben.
