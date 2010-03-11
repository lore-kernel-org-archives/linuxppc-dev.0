Return-Path: <grant.likely@secretlab.ca>
Received: from mail-pw0-f42.google.com (mail-pw0-f42.google.com
	[209.85.160.42]) by ozlabs.org (Postfix) with ESMTP id 76D0CB8064
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 05:05:30 +1100 (EST)
Received: by mail-pw0-f42.google.com with SMTP id 10so170185pwi.15
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 10:05:30 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 18/37] drivers/pcmcia: use .dev.of_node instead of .node in
	struct of_device
To: monstr@monstr.eu, gregkh@suse.de, benh@kernel.crashing.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	sfr@canb.auug.org.au, jgarzik@pobox.com, ben-linux@fluff.org,
	dwmw2@infradead.org, jeremy.kerr@canonical.com,
	James.Bottomley@suse.de, broonie@opensource.wolfsonmicro.com,
	microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	linux-ide@vger.kernel.org, netdev@vger.kernel.org,
	linux-i2c@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	linux-scsi@vger.kernel.org, alsa-devel@alsa-project.org
Date: Thu, 11 Mar 2010 11:05:27 -0700
Message-ID: <20100311180527.4824.74325.stgit@angua>
In-Reply-To: <20100311174830.4824.19820.stgit@angua>
References: <20100311174830.4824.19820.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

.node is being removed

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/pcmcia/electra_cf.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pcmcia/electra_cf.c b/drivers/pcmcia/electra_cf.c
index 89cfddc..a4d821f 100644
--- a/drivers/pcmcia/electra_cf.c
+++ b/drivers/pcmcia/electra_cf.c
@@ -184,7 +184,7 @@ static int __devinit electra_cf_probe(struct of_device *ofdev,
 				      const struct of_device_id *match)
 {
 	struct device *device = &ofdev->dev;
-	struct device_node *np = ofdev->node;
+	struct device_node *np = ofdev->dev.of_node;
 	struct electra_cf_socket   *cf;
 	struct resource mem, io;
 	int status;
