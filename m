Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 58AABDDE2C
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 06:19:45 +1100 (EST)
Message-Id: <416B8C5D-109C-4C03-807D-7EBB0AA9C366@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: fixed phy support (warning related to FIXED_MII_100_FDX)
Date: Mon, 21 Jan 2008 13:19:41 -0600
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton,

it looks like the "TI AR7 CPMAC Ethernet support" uses FIXED_PHY and  
was selecting FIXED_MII_100_FDX which is gone.

Can you look into this.  I get the following warning now:

scripts/kconfig/conf -s arch/powerpc/Kconfig
drivers/net/Kconfig:1713:warning: 'select' used by config symbol  
'CPMAC' refers to undefined symbol 'FIXED_MII_100_FDX'

- k
