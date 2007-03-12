Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 253AEDDF66
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 07:42:10 +1100 (EST)
Date: Mon, 12 Mar 2007 14:42:05 -0600
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 18/19] Add linux, stdout-path to the 83xx, 85xx,
	and 86xx device trees.
Message-ID: <20070312204205.GR28545@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is required for cuImage to work.  This property seems as though it'd
be a lot more appropriate as a phandle than as a path, though...

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/dts/mpc8313erdb.dts    |    4 ++++
 arch/powerpc/boot/dts/mpc832x_mds.dts    |    4 ++++
 arch/powerpc/boot/dts/mpc8349emitx.dts   |    4 ++++
 arch/powerpc/boot/dts/mpc8349emitxgp.dts |    4 ++++
 arch/powerpc/boot/dts/mpc834x_mds.dts    |    4 ++++
 arch/powerpc/boot/dts/mpc836x_mds.dts    |    4 ++++
 arch/powerpc/boot/dts/mpc8540ads.dts     |    4 ++++
 arch/powerpc/boot/dts/mpc8541cds.dts     |    4 ++++
 arch/powerpc/boot/dts/mpc8548cds.dts     |    4 ++++
 arch/powerpc/boot/dts/mpc8555cds.dts     |    4 ++++
 arch/powerpc/boot/dts/mpc8560ads.dts     |    4 ++++
 arch/powerpc/boot/dts/mpc8568mds.dts     |    4 ++++
 arch/powerpc/boot/dts/mpc8641_hpcn.dts   |    4 ++++
 13 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index 6d72190..b89a4af 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -212,4 +212,8 @@
 			device_type = "ipic";
 		};
 	};
+
+	chosen {
+		linux,stdout-path = "/soc8313@e0000000/serial@4500";
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index 06b3106..0220ea4 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -330,4 +330,8 @@
 			interrupt-parent = < &ipic >;
 		};
 	};
+
+	chosen {
+		linux,stdout-path = "/soc8323@e0000000/serial@4500";
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 61b550b..f0764bd 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -239,4 +239,8 @@
 			device_type = "ipic";
 		};
 	};
+
+	chosen {
+		linux,stdout-path = "/soc8349@e0000000/serial@4500";
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8349emitxgp.dts b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
index b2e1a5e..c010ecd 100644
--- a/arch/powerpc/boot/dts/mpc8349emitxgp.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
@@ -181,4 +181,8 @@
 			device_type = "ipic";
 		};
 	};
+
+	chosen {
+		linux,stdout-path = "/soc8349@e0000000/serial@4500";
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc834x_mds.dts b/arch/powerpc/boot/dts/mpc834x_mds.dts
index e4b43c2..ac3afaa 100644
--- a/arch/powerpc/boot/dts/mpc834x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
@@ -327,4 +327,8 @@
 			device_type = "ipic";
 		};
 	};
+
+	chosen {
+		linux,stdout-path = "/soc8349@e0000000/serial@4500";
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index 4fe45c0..38e55de 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -360,4 +360,8 @@
 		};
 
 	};
+
+	chosen {
+		linux,stdout-path = "/soc8360@e0000000/serial@4500";
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts b/arch/powerpc/boot/dts/mpc8540ads.dts
index 3c0917f..e220f70 100644
--- a/arch/powerpc/boot/dts/mpc8540ads.dts
+++ b/arch/powerpc/boot/dts/mpc8540ads.dts
@@ -244,4 +244,8 @@
 			big-endian;
 		};
 	};
+
+	chosen {
+		linux,stdout-path = "/soc8540@e0000000/serial@4500";
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8541cds.dts b/arch/powerpc/boot/dts/mpc8541cds.dts
index 2a1ae76..77cf9a8 100644
--- a/arch/powerpc/boot/dts/mpc8541cds.dts
+++ b/arch/powerpc/boot/dts/mpc8541cds.dts
@@ -231,4 +231,8 @@
                         big-endian;
 		};
 	};
+
+	chosen {
+		linux,stdout-path = "/soc8541@e0000000/serial@4500";
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index 7eb5d81..3263502 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -271,4 +271,8 @@
                         big-endian;
 		};
 	};
+
+	chosen {
+		linux,stdout-path = "/soc8548@e0000000/serial@4500";
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8555cds.dts b/arch/powerpc/boot/dts/mpc8555cds.dts
index 5f9c102..1e3a910 100644
--- a/arch/powerpc/boot/dts/mpc8555cds.dts
+++ b/arch/powerpc/boot/dts/mpc8555cds.dts
@@ -231,4 +231,8 @@
                         big-endian;
 		};
 	};
+
+	chosen {
+		linux,stdout-path = "/soc8555@e0000000/serial@4500";
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/boot/dts/mpc8560ads.dts
index 1050263..911eb1d 100644
--- a/arch/powerpc/boot/dts/mpc8560ads.dts
+++ b/arch/powerpc/boot/dts/mpc8560ads.dts
@@ -285,4 +285,8 @@
 			};
 		};
 	};
+
+	chosen {
+		linux,stdout-path = "/soc8560@e0000000/cpm@e0000000/scc@91a00";
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index bf49d8c..7bf73c8 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -359,4 +359,8 @@
 		};
 
 	};
+
+	chosen {
+		linux,stdout-path = "/soc8568@e0000000/serial@4500";
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index 8a4995a..2617e26 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -312,4 +312,8 @@
 			big-endian;
 		};
 	};
+
+	chosen {
+		linux,stdout-path = "/soc8641@f8000000/serial@4500";
+	};
 };
-- 
1.5.0.3
