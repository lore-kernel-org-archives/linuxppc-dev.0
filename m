Return-Path: <alebas@televes.com>
Received: from tvesnat.televes.com (unknown [212.163.42.137])
	by ozlabs.org (Postfix) with ESMTP id C091F2BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Sep 2004 00:25:10 +1000 (EST)
Message-ID: <1096380738.415971420df80@webmail.televes.com:443>
Date: Tue, 28 Sep 2004 16:12:18 +0200
From: alebas@televes.com
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: Full duplex, MDIO and both Ethernet in MPC8272ADS
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi to all,

As long as I have seen (tested and surfed in the code), current
linuxppc_2.4.26_devel support for MPC8272ADS board is limited to one PHY,
without MII management support and the interface is always configured as Half
Duplex. Unfourtunately, this is little useful for me, as long as i am trying to
set up a bridge between both interfaces.

I have been also testing the Linux Reference Design, from Arabella SW, which, as
long as I have seen, has support for both PHYs, MII management and Full Duplex.

So, is there any plan to merge any of Arabella's changes into the ppc tree? Or
is there anyone currently working on that ethernet stuff for current 2.4.26
tree? Is  it planned to provide a patch soon?

Best regards,

Alex.
