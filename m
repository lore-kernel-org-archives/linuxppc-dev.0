Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 8DA21DDEA3
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 07:20:18 +1000 (EST)
Date: Tue, 2 Oct 2007 16:24:21 -0500
From: Olof Johansson <olof@lixom.net>
To: jgarzik@pobox.com
Subject: [PATCH] [0/11] pasemi_mac: Patches for 2.6.24
Message-ID: <20071002212421.GA2282@lixom.net>
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

This series of patches go on top of the previous fixes that were sent
out and picked up.

It's a series of mostly feature-related changes, but also a couple
of bugfixes:

[1/11] pasemi_mac: basic error checking
[2/11] pasemi_mac: fix bug in receive buffer dma mapping
[3/11] pasemi_mac: rework ring management
[4/11] pasemi_mac: implement sg support
[5/11] pasemi_mac: workaround for erratum 5971
[6/11] pasemi_mac: add local skb alignment
[7/11] pasemi_mac: further performance tweaks
[8/11] pasemi_mac: update todo list
[9/11] pasemi_mac: clear out old errors on interface open
[10/11] pasemi_mac: use buffer index pointer in clean_rx()
[11/11] pasemi_mac: enable iommu support


Thanks,

-Olof
