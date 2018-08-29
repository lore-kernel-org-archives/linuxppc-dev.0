Return-Path: <David.Gounaris@infinera.com>
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by lists.ozlabs.org (Postfix) with ESMTP id 420mKW5bxpzF0gv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 23:13:49 +1000 (AEST)
From: David Gounaris <david.gounaris@infinera.com>
To: qiang.zhao@nxp.com, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 robh+dt@kernel.org
Cc: David Gounaris <david.gounaris@infinera.com>
Subject: [PATCH v2 0/6] Ethernet over hdlc
Date: Wed, 29 Aug 2018 15:13:22 +0200
Message-Id: <20180829131328.27901-1-david.gounaris@infinera.com>
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

Here is what has been changed in v2 after the review comments.

v2-0001: Using UCC_MAX_NUM
v2-0002: Unchanged
v2-0003: Changed commit message
v2-0004: Adding fsl,hmask into the dt instead of changing the default value.
v2-0005: Unchanged
v2-0006: Unchanged

Adding robh+dt@kernel.org for comments regarding dt.

Best Regards
David Gounaris

David Gounaris (6):
  net/wan/fsl_ucc_hdlc: allow ucc index up to 7
  net/wan/fsl_ucc_hdlc: allow PARITY_CRC16_PR0_CCITT parity
  net/wan/fsl_ucc_hdlc: Adding ARPHRD_ETHER
  net/wan/fsl_ucc_hdlc: hmask
  net/wan/fsl_ucc_hdlc: GUMR for non tsa mode
  net/wan/fsl_ucc_hdlc: tx timeout handler

 .../devicetree/bindings/soc/fsl/cpm_qe/network.txt |  6 +++++
 drivers/net/wan/fsl_ucc_hdlc.c                     | 28 +++++++++++++++++++---
 drivers/net/wan/fsl_ucc_hdlc.h                     |  1 +
 3 files changed, 32 insertions(+), 3 deletions(-)

-- 
2.13.6
