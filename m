Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D54FC68106
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Sep 2005 02:46:15 +1000 (EST)
Date: Mon, 5 Sep 2005 09:46:13 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <20050905164613.GC6341@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: add missing sysfs node for
	ocp_func_emac_data.phy_feat_exc
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Add sysfs node for ocp_func_emac_data.phy_feat_exc field.

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>
---

 include/asm-ppc/ibm_ocp.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/asm-ppc/ibm_ocp.h b/include/asm-ppc/ibm_ocp.h
--- a/include/asm-ppc/ibm_ocp.h
+++ b/include/asm-ppc/ibm_ocp.h
@@ -84,6 +84,7 @@ OCP_SYSFS_ADDTL(struct ocp_func_emac_dat
 OCP_SYSFS_ADDTL(struct ocp_func_emac_data, "%d\n", emac, tah_idx)	\
 OCP_SYSFS_ADDTL(struct ocp_func_emac_data, "%d\n", emac, phy_mode)	\
 OCP_SYSFS_ADDTL(struct ocp_func_emac_data, "0x%08x\n", emac, phy_map)	\
+OCP_SYSFS_ADDTL(struct ocp_func_emac_data, "0x%08x\n", emac, phy_feat_exc)\
 									\
 void ocp_show_emac_data(struct device *dev)				\
 {									\
@@ -99,6 +100,7 @@ void ocp_show_emac_data(struct device *d
 	device_create_file(dev, &dev_attr_emac_tah_idx);		\
 	device_create_file(dev, &dev_attr_emac_phy_mode);		\
 	device_create_file(dev, &dev_attr_emac_phy_map);		\
+	device_create_file(dev, &dev_attr_emac_phy_feat_exc);		\
 }
 
 /*
