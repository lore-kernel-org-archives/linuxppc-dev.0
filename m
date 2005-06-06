Return-Path: <mporter@kernel.crashing.org>
Received: from zipcode.az.mvista.com (rav-az.mvista.com [65.200.49.157])
	by ozlabs.org (Postfix) with ESMTP id 8E94A679F5
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Jun 2005 09:52:27 +1000 (EST)
In-Reply-To: mporter@kernel.crashing.org
Date: Mon, 6 Jun 2005 16:52:21 -0700
Message-Id: <1118101941657@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: akpm@osdl.org
From: Matt Porter <mporter@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH][RIO] -mm: Fix macro indenting
Reply-To: Matt Porter <mporter@kernel.crashing.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Fix up indenting that Lindent fubared.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org

commit 87ff3372a005e4cf927b1b62c23e1c2339d46507
tree 16e1d9454a95a4a1e8b9e50dacd218f8e14dfe14
parent 6e9e41d480cf54c69d47df11f5cba696461ebe1a
author Matt Porter <mporter@kernel.crashing.org> Mon, 06 Jun 2005 09:23:49 =
-0700
committer Matt Porter <mporter@kernel.crashing.org> Mon, 06 Jun 2005 09:23:=
49 -0700

 drivers/rio/rio-access.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/rio/rio-access.c b/drivers/rio/rio-access.c
--- a/drivers/rio/rio-access.c
+++ b/drivers/rio/rio-access.c
@@ -77,13 +77,13 @@ int __rio_local_write_config_##size \
 }
=20
 RIO_LOP_READ(8, u8, 1)
-    RIO_LOP_READ(16, u16, 2)
-    RIO_LOP_READ(32, u32, 4)
-    RIO_LOP_WRITE(8, u8, 1)
-    RIO_LOP_WRITE(16, u16, 2)
-    RIO_LOP_WRITE(32, u32, 4)
+RIO_LOP_READ(16, u16, 2)
+RIO_LOP_READ(32, u32, 4)
+RIO_LOP_WRITE(8, u8, 1)
+RIO_LOP_WRITE(16, u16, 2)
+RIO_LOP_WRITE(32, u32, 4)
=20
-    EXPORT_SYMBOL(__rio_local_read_config_8);
+EXPORT_SYMBOL(__rio_local_read_config_8);
 EXPORT_SYMBOL(__rio_local_read_config_16);
 EXPORT_SYMBOL(__rio_local_read_config_32);
 EXPORT_SYMBOL(__rio_local_write_config_8);
@@ -137,13 +137,13 @@ int rio_mport_write_config_##size \
 }
=20
 RIO_OP_READ(8, u8, 1)
-    RIO_OP_READ(16, u16, 2)
-    RIO_OP_READ(32, u32, 4)
-    RIO_OP_WRITE(8, u8, 1)
-    RIO_OP_WRITE(16, u16, 2)
-    RIO_OP_WRITE(32, u32, 4)
+RIO_OP_READ(16, u16, 2)
+RIO_OP_READ(32, u32, 4)
+RIO_OP_WRITE(8, u8, 1)
+RIO_OP_WRITE(16, u16, 2)
+RIO_OP_WRITE(32, u32, 4)
=20
-    EXPORT_SYMBOL(rio_mport_read_config_8);
+EXPORT_SYMBOL(rio_mport_read_config_8);
 EXPORT_SYMBOL(rio_mport_read_config_16);
 EXPORT_SYMBOL(rio_mport_read_config_32);
 EXPORT_SYMBOL(rio_mport_write_config_8);
