Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 09DDF68191
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Aug 2005 15:01:57 +1000 (EST)
Date: Tue, 30 Aug 2005 22:01:55 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Jeff Garzik <jgarzik@pobox.com>
Message-ID: <20050831050155.GC17017@gate.ebshome.net>
References: <20050831045847.GA17017@gate.ebshome.net>
	<20050831050048.GB17017@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050831050048.GB17017@gate.ebshome.net>
Cc: netdev@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH 2/2] New PowerPC 4xx on-chip ethernet controller driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Add new PPC 4xx NAPI EMAC driver

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>
---

 drivers/net/Kconfig                   |   70 +
 drivers/net/ibm_emac/Makefile         |   11 
 drivers/net/ibm_emac/ibm_emac.h       |  309 +++++
 drivers/net/ibm_emac/ibm_emac_core.c  | 2248 +++++++++++++++++++++++++++++++++
 drivers/net/ibm_emac/ibm_emac_core.h  |  221 +++
 drivers/net/ibm_emac/ibm_emac_debug.c |  213 +++
 drivers/net/ibm_emac/ibm_emac_debug.h |   63 +
 drivers/net/ibm_emac/ibm_emac_mal.c   |  584 +++++++++
 drivers/net/ibm_emac/ibm_emac_mal.h   |  267 ++++
 drivers/net/ibm_emac/ibm_emac_phy.c   |  355 +++++
 drivers/net/ibm_emac/ibm_emac_phy.h   |   80 +
 drivers/net/ibm_emac/ibm_emac_rgmii.c |  202 +++
 drivers/net/ibm_emac/ibm_emac_rgmii.h |   65 +
 drivers/net/ibm_emac/ibm_emac_tah.c   |  111 ++
 drivers/net/ibm_emac/ibm_emac_tah.h   |   88 +
 drivers/net/ibm_emac/ibm_emac_zmii.c  |  256 ++++
 drivers/net/ibm_emac/ibm_emac_zmii.h  |   83 +
 17 files changed, 5226 insertions(+), 0 deletions(-)

Patch is quite big (146K) and can be found at

  http://kernel.ebshome.net/emac/06-add_napi_ibm_emac.diff

I can post it to the mail list for discussion, just let me know.
