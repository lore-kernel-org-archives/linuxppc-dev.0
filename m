Return-Path: <grant.likely@secretlab.ca>
Date: Thu, 19 Jul 2007 12:37:34 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 3/4] mpc8349emitx: Add chosen node for default stdout path
In-reply-to: <20070719183415.7458.42622.stgit@trillian>
To: linuxppc-dev@ozlabs.com
Message-id: <20070719183734.7458.83695.stgit@trillian>
Content-type: text/plain; charset=utf-8; format=fixed
References: <20070719183415.7458.42622.stgit@trillian>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

To boot from a cuImage requires the device tree to have a
linux,stdout-path property in the chosen node.  This patch adds it
to the .dts files.

Signed-of-by: Grant Likely <grant.likely@secretlab.ca>
CC: Scott Wood <scottwood@freescale.com>
CC: Kumar Gala <galak@kernel.crashing.org>
---

 arch/powerpc/boot/dts/mpc8349emitx.dts   |    4 ++++
 arch/powerpc/boot/dts/mpc8349emitxgp.dts |    5 +++++
 arch/powerpc/boot/dts/mpc834x_mds.dts    |    4 ++++
 3 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 7c13b38..7651589 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -250,4 +250,8 @@
 			device_type = "ipic";
 		};
 	};
+
+	chosen {
+		linux,stdout-path = "/soc8349@e0000000/serial@4500";
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8349emitxgp.dts b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
index 3c42902..c80fc94 100644
--- a/arch/powerpc/boot/dts/mpc8349emitxgp.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
@@ -181,4 +181,9 @@
 			device_type = "ipic";
 		};
 	};
+
+	chosen {
+		linux,stdout-path = "/soc8349@e0000000/serial@4500";
+	};
 };
+
diff --git a/arch/powerpc/boot/dts/mpc834x_mds.dts b/arch/powerpc/boot/dts/mpc834x_mds.dts
index 13779cd..671dde5 100644
--- a/arch/powerpc/boot/dts/mpc834x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
@@ -338,4 +338,8 @@
 			device_type = "ipic";
 		};
 	};
+
+	chosen {
+		linux,stdout-path = "/soc8349@e0000000/serial@4500";
+	};
 };
