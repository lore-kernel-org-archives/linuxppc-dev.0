Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 71881DDE11
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 05:26:36 +1000 (EST)
Date: Mon, 24 Sep 2007 23:25:19 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/3] usb: ehci ppc device-tree-aware driver
Message-ID: <20070924192519.GA4192@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some PowerPC systems have a built-in EHCI controller.
This is a device tree aware version of the EHCI controller driver.
Currently it's been tested on the PowerPC 440EPx Sequoia board.
Other platforms can be added later.
The code is based on the ehci-ppc-soc driver by Stefan Roese <sr@denx.de>.
