Return-Path: <nicoleotsuka@gmail.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0239.outbound.protection.outlook.com [207.46.163.239])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E33491A0185
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Aug 2014 14:17:23 +1000 (EST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: <broonie@kernel.org>
Subject: [PATCH 0/2] ASoC: fsl_asrc: Fix two dereferenced variable before check
Date: Mon, 4 Aug 2014 12:19:47 +0800
Message-ID: <cover.1407125653.git.nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, timur@tabi.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These two patches fixes two warning of dereferenced variable reported by
Dan Carpenter <dan.carpenter@oracle.com>

Nicolin Chen (2):
  ASoC: fsl_sarc_dma: Check pair before using it
  ASoC: fsl_asrc: Don't access members of config before checking it

 sound/soc/fsl/fsl_asrc.c     | 9 ++++++---
 sound/soc/fsl/fsl_asrc_dma.c | 9 +++++++--
 2 files changed, 13 insertions(+), 5 deletions(-)

-- 
1.8.4
