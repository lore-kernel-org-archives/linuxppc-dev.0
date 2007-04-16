Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 3F127DDEBE
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Apr 2007 15:58:54 +1000 (EST)
Date: Mon, 16 Apr 2007 01:16:54 -0500
To: jgarzik@pobox.com
Subject: [PATCH] [0/4] pasemi_mac: fixes and enhancements
Message-ID: <20070416061654.GB19783@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: olof@lixom.net (Olof Johansson)
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

The four following patches contain a number of fixes and improvements
of the pasemi_mac driver:

1/4: A couple of minor bugfixes.
2/4: Move the IRQ mapping from the PCI layer under our platform, to
     the driver.
3/4: A rather large patch with various NAPI/performance-related fixes
     and enhancements.
4/4: phy support


-Olof
