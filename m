Return-Path: <Jiada_Wang@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5D1011A0483
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 16:55:15 +1100 (AEDT)
From: Jiada Wang <jiada_wang@mentor.com>
To: <timur@tabi.org>, <festevam@gmail.com>, <lars@metafoo.de>,
 <arnd@arndb.de>, <broonie@kernel.org>, <mpa@pengutronix.de>
Subject: [PATCH v2 0/2] fsl_ssi misc fix
Date: Tue, 2 Dec 2014 14:55:05 +0900
Message-ID: <1417499707-3125-1-git-send-email-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org,
 lgirdwood@gmail.com, nicoleotsuka@gmail.com, Li.Xiubo@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Changes in v2:
	- fix error path in probe
	- replace irq_of_parse_and_map with platform_get_irq

Changes in v1:
	- free IRQ before irq_dispose_mapping

Jiada Wang (2):
  ASoC: fsl_ssi: fix error path in probe
  ASoC: fsl_ssi: use platform_get_irq instead of irq_of_parse_and_map

 sound/soc/fsl/fsl_ssi.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

-- 
1.9.3
