Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id A9250DDE08
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2007 16:06:33 +1000 (EST)
Date: Wed, 18 Apr 2007 01:24:51 -0500
To: jgarzik@pobox.com
Subject: [PATCH] [0/5] [v2] pasemi_mac: fixes and enhancements
Message-ID: <20070418062451.GA11308@lixom.net>
References: <20070416061654.GB19783@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070416061654.GB19783@lixom.net>
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

The five following patches contain a number of fixes and improvements
of the pasemi_mac driver:

1/5: A couple of minor bugfixes.
2/5: Move the IRQ mapping from the PCI layer under our platform, to
     the driver.
3/5: A rather large patch with various NAPI/performance-related fixes
     and enhancements.
4/5: phy support
5/5: use local-mac-address instead of mac-address if available.

(Changes from last time: Added 5/5, changes to 2/5 to use virq_to_hw()).


-Olof
