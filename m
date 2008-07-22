Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F25EEDE2DB
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 21:53:15 +1000 (EST)
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 3/3] ASoC: Staticise keyclick dev_attr in tlv320aic26
Date: Tue, 22 Jul 2008 12:53:09 +0100
Message-Id: <1216727589-19544-3-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <1216727589-19544-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20080722115205.GA12555@sirena.org.uk>
	<1216727589-19544-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1216727589-19544-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Cc: alsa-project.org@rakim.wolfsonmicro.main, linuxppc-dev@ozlabs.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	timur@freescale.com, liam.girdwood@wolfsonmicro.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/tlv320aic26.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index 73b7027..bed8a9e 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -418,7 +418,7 @@ static ssize_t aic26_keyclick_set(struct device *dev,
 	return count;
 }
 
-DEVICE_ATTR(keyclick, 0644, aic26_keyclick_show, aic26_keyclick_set);
+static DEVICE_ATTR(keyclick, 0644, aic26_keyclick_show, aic26_keyclick_set);
 
 /* ---------------------------------------------------------------------
  * SPI device portion of driver: probe and release routines and SPI
-- 
1.5.6.3
