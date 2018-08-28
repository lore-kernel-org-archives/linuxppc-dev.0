Return-Path: <David.Gounaris@infinera.com>
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by lists.ozlabs.org (Postfix) with ESMTP id 4205ld3jJDzDrRN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 21:15:41 +1000 (AEST)
From: David Gounaris <david.gounaris@infinera.com>
To: qiang.zhao@nxp.com, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: David Gounaris <david.gounaris@infinera.com>
Subject: [PATCH 0/6] Ethernet over hdlc
Date: Tue, 28 Aug 2018 13:09:15 +0200
Message-Id: <20180828110921.2542-1-david.gounaris@infinera.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello!

I have a 83xx platform and I am using non tsa mode in the fsl hdlc driver to enable ethernet over hdlc. These patches are the minimal changes that I needed to do in order to get it to work with our legacy products that used old FSL SDK driver. Please review.

Best Regards,
David Gounaris

David Gounaris (6):
  net/wan/fsl_ucc_hdlc: allow ucc index up to 4
  net/wan/fsl_ucc_hdlc: allow PARITY_CRC16_PR0_CCITT parity
  net/wan/fsl_ucc_hdlc: Adding ARPHRD_ETHER
  net/wan/fsl_ucc_hdlc: default hmask value
  net/wan/fsl_ucc_hdlc: GUMR for non tsa mode
  net/wan/fsl_ucc_hdlc: tx timeout handler

 drivers/net/wan/fsl_ucc_hdlc.c | 23 +++++++++++++++++++++--
 drivers/net/wan/fsl_ucc_hdlc.h |  2 +-
 2 files changed, 22 insertions(+), 3 deletions(-)

-- 
2.13.6
