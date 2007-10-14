Return-Path: <grant.likely@secretlab.ca>
Date: Sat, 13 Oct 2007 22:36:57 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 1/2] mpc52xx-ata: fix compile warning (unused variable)
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-id: <20071014043657.23348.56519.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Trivial unused variable fix

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/ata/pata_mpc52xx.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index 099f4cd..f1c3f4d 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -309,7 +309,6 @@ mpc52xx_ata_init_one(struct device *dev, struct mpc52xx_ata_priv *priv)
 	struct ata_host *host;
 	struct ata_port *ap;
 	struct ata_ioports *aio;
-	int rc;
 
 	host = ata_host_alloc(dev, 1);
 	if (!host)
