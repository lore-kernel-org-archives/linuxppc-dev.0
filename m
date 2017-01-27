Return-Path: <valentin.longchamp@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8zv31TKzzDqZl
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jan 2017 00:21:03 +1100 (AEDT)
From: Valentin Longchamp <valentin.longchamp@keymile.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: qiang.zhao@nxp.com, oss@buserror.net,
 Valentin Longchamp <valentin.longchamp@keymile.com>
Subject: [RFC 0/3] soc/fsl: various fixes for QE support
Date: Fri, 27 Jan 2017 14:15:14 +0100
Message-Id: <1485522917-2150-1-git-send-email-valentin.longchamp@keymile.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Testing the QE's UCC for our HDLC bus I noticed a few odd things and I have
fixed these in these 3 patches.

Valentin Longchamp (3):
  soc/fsl/qe: round brg_freq to 1kHz granularity
  soc/fsl/qe: only apply QE_General4 workaround on affected SoCs
  soc/fsl/qe: add EXPORT_SYMBOL for the 2 qe_tdm functions

 drivers/soc/fsl/qe/qe.c     | 21 +++++++++++++++++++--
 drivers/soc/fsl/qe/qe_tdm.c |  2 ++
 2 files changed, 21 insertions(+), 2 deletions(-)

-- 
1.8.3.1
