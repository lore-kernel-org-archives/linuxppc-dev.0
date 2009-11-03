Return-Path: <jignesh.patel@onrampwireless.com>
Received: from relay.ihostexchange.net (relay.ihostexchange.net [66.46.182.55])
	by ozlabs.org (Postfix) with ESMTP id 066E3B7BE9
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  3 Nov 2009 14:11:53 +1100 (EST)
From: Jignesh Patel <jignesh.patel@onrampwireless.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 2 Nov 2009 22:04:58 -0500
Subject: enabling USB Host controller on ppc405ex based board
Message-ID: <D7C6597E47CDAD4BA48EE3D2B03B385102E7C3CE9D@VMBX113.ihostexchange.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Mukunda Saddi <mukunda.saddi@onrampwireless.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

We have Kilauea based board using ppc405ex. & it has usb-otg tranciever chi=
p on it.

I am trying to enable USB Host Controller Driver in linux kernel (version D=
ENX 2.6.27-stable).  For this to be enabled, I also have to enable PCI in k=
ernel config.
But when I load the kernel uImage with both USB Host Controller & PCI optio=
ns selected in kernel config, the board doesn't boot up properly. Boot proc=
ess halts after loading device tree.

When I load the kernel without PCI options selected, kernel boots up proper=
ly.  But removing PCI config option also removes USB Host Controller option=
s in kernel.

My questions are:
1. Why is PCI config required for USB Host Controller options to be enabled=
 in kernel config?
2. What needs to be done to boot our board with PCI & USB enabled kernel?

Best regards,

-Jignesh=
