Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BA9B968180
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Aug 2005 15:00:50 +1000 (EST)
Date: Tue, 30 Aug 2005 22:00:48 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Jeff Garzik <jgarzik@pobox.com>
Message-ID: <20050831050048.GB17017@gate.ebshome.net>
References: <20050831045847.GA17017@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050831045847.GA17017@gate.ebshome.net>
Cc: netdev@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH 1/2] New PowerPC 4xx on-chip ethernet controller driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Remove old PPC4xx EMAC driver

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>
---

 drivers/net/Kconfig                   |   34 -
 drivers/net/ibm_emac/Makefile         |   12 
 drivers/net/ibm_emac/ibm_emac.h       |  267 ----
 drivers/net/ibm_emac/ibm_emac_core.c  | 2011 ---------------------------------
 drivers/net/ibm_emac/ibm_emac_core.h  |  146 --
 drivers/net/ibm_emac/ibm_emac_debug.c |  224 ----
 drivers/net/ibm_emac/ibm_emac_mal.c   |  463 --------
 drivers/net/ibm_emac/ibm_emac_mal.h   |  131 --
 drivers/net/ibm_emac/ibm_emac_phy.c   |  298 -----
 drivers/net/ibm_emac/ibm_emac_phy.h   |  137 --
 drivers/net/ibm_emac/ibm_emac_rgmii.h |   65 -
 drivers/net/ibm_emac/ibm_emac_tah.h   |   48 -
 drivers/net/ibm_emac/ibm_emac_zmii.h  |   93 --
 13 files changed, 0 insertions(+), 3929 deletions(-)


Patch is quite big (110K) and not interesting, it can be found at 
  
  http://kernel.ebshome.net/emac/05-remove_old_ibm_emac.diff
