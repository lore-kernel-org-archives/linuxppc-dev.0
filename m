Return-Path: <David.Gounaris@infinera.com>
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by lists.ozlabs.org (Postfix) with ESMTP id 423qWK513pzF37M
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Sep 2018 22:47:54 +1000 (AEST)
From: David Gounaris <david.gounaris@infinera.com>
To: qiang.zhao@nxp.com, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 joakim.tjernlund@infinera.com
Cc: David Gounaris <david.gounaris@infinera.com>
Subject: [PATCH v3 0/6] Ethernet over hdlc
Date: Mon,  3 Sep 2018 14:47:24 +0200
Message-Id: <20180903124730.1551-1-david.gounaris@infinera.com>
In-Reply-To: <20180828110921.2542-2-david.gounaris@infinera.com>
References: <20180828110921.2542-2-david.gounaris@infinera.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here is what has been changed in v3 after the review comments from v2.

v3-0001: corrected style problems
v3-0002: corrected style problems
v3-0003: corrected style problems
v3-0004: corrected style problems
v3-0005: corrected style problems
v3-0006: corrected style problems

Sorry for that, I did not know about scripts/checkpatch.pl.

David Gounaris (6):
  net/wan/fsl_ucc_hdlc: allow ucc index up to 7
  net/wan/fsl_ucc_hdlc: allow PARITY_CRC16_PR0_CCITT parity
  net/wan/fsl_ucc_hdlc: Adding ARPHRD_ETHER
  net/wan/fsl_ucc_hdlc: hmask
  net/wan/fsl_ucc_hdlc: GUMR for non tsa mode
  net/wan/fsl_ucc_hdlc: tx timeout handler

 .../devicetree/bindings/soc/fsl/cpm_qe/network.txt |  6 +++++
 drivers/net/wan/fsl_ucc_hdlc.c                     | 26 ++++++++++++++++++++--
 drivers/net/wan/fsl_ucc_hdlc.h                     |  1 +
 3 files changed, 31 insertions(+), 2 deletions(-)

-- 
2.13.6
