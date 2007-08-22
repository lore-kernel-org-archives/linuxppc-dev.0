Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 9628ADDEC7
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 01:07:47 +1000 (EST)
Date: Wed, 22 Aug 2007 09:12:37 -0500
From: Olof Johansson <olof@lixom.net>
To: jgarzik@pobox.com
Subject: [PATCH] [00/10] pasemi_mac patches for 2.6.24
Message-ID: <20070822141237.GA16830@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

pasemi_mac patches for 2.6.24:

01/10: pasemi_mac: Abstract out register access
02/10: pasemi_mac: Stop using the pci config space accessors for register read/writes
03/10: pasemi_mac: Enable L2 caching of packet headers
04/10: pasemi_mac: Fix memcpy amount for short receives
05/10: pasemi_mac: RX performance tweaks
06/10: pasemi_mac: Batch up TX buffer frees
07/10: pasemi_mac: Enable LLTX
08/10: pasemi_mac: Fix TX ring wrap checking
09/10: pasemi_mac: Fix RX checksum flags
10/10: pasemi_mac: Clean TX ring in poll


Thanks,

Olof

--
