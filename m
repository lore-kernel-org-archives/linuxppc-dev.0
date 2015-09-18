Return-Path: <hongtao.jia@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0105.outbound.protection.outlook.com [207.46.100.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA30C1A006C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 14:20:57 +1000 (AEST)
From: Jia Hongtao <hongtao.jia@freescale.com>
To: <scottwood@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <devicetree@vger.kernel.org>,
 <robh+dt@kernel.org>, <hongtao.jia@freescale.com>
Subject: [PATCH] PowerPC: Move Freescale device tree files into fsl folder
Date: Fri, 18 Sep 2015 12:00:24 +0800
Message-ID: <1442548824-45849-1-git-send-email-hongtao.jia@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It makes no sense that some Freescale device tree files are in fsl
directory while some others not. This patch move Freescale device tree
files into fsl folder. To do that the following two steps are made:
- Move Freescale device tree files into fsl folder.
- Update the include path in these files from "fsl/*.dtsi" to "*.dtsi".

Please add "fsl/" prefix when you make dtb using Makefile.

Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
---
 arch/powerpc/boot/dts/{ => fsl}/b4420qds.dts               | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/b4860qds.dts               | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/b4qds.dtsi                 | 2 +-
 arch/powerpc/boot/dts/{ => fsl}/bsc9131rdb.dts             | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/bsc9131rdb.dtsi            | 0
 arch/powerpc/boot/dts/{ => fsl}/bsc9132qds.dts             | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/bsc9132qds.dtsi            | 0
 arch/powerpc/boot/dts/{ => fsl}/c293pcie.dts               | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/ge_imp3a.dts               | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/kmcoge4.dts                | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/mpc8536ds.dts              | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/mpc8536ds.dtsi             | 0
 arch/powerpc/boot/dts/{ => fsl}/mpc8536ds_36b.dts          | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/mpc8540ads.dts             | 2 +-
 arch/powerpc/boot/dts/{ => fsl}/mpc8541cds.dts             | 2 +-
 arch/powerpc/boot/dts/{ => fsl}/mpc8544ds.dts              | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/mpc8544ds.dtsi             | 0
 arch/powerpc/boot/dts/{ => fsl}/mpc8548cds.dtsi            | 0
 arch/powerpc/boot/dts/{ => fsl}/mpc8548cds_32b.dts         | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/mpc8548cds_36b.dts         | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/mpc8555cds.dts             | 2 +-
 arch/powerpc/boot/dts/{ => fsl}/mpc8560ads.dts             | 2 +-
 arch/powerpc/boot/dts/{ => fsl}/mpc8568mds.dts             | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/mpc8569mds.dts             | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/mpc8572ds.dts              | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/mpc8572ds.dtsi             | 0
 arch/powerpc/boot/dts/{ => fsl}/mpc8572ds_36b.dts          | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/mpc8572ds_camp_core0.dts   | 0
 arch/powerpc/boot/dts/{ => fsl}/mpc8572ds_camp_core1.dts   | 0
 arch/powerpc/boot/dts/{ => fsl}/mvme2500.dts               | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/oca4080.dts                | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/p1010rdb-pa.dts            | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/p1010rdb-pa.dtsi           | 0
 arch/powerpc/boot/dts/{ => fsl}/p1010rdb-pa_36b.dts        | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/p1010rdb-pb.dts            | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/p1010rdb-pb_36b.dts        | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/p1010rdb.dtsi              | 0
 arch/powerpc/boot/dts/{ => fsl}/p1010rdb_32b.dtsi          | 0
 arch/powerpc/boot/dts/{ => fsl}/p1010rdb_36b.dtsi          | 0
 arch/powerpc/boot/dts/{ => fsl}/p1020mbg-pc.dtsi           | 0
 arch/powerpc/boot/dts/{ => fsl}/p1020mbg-pc_32b.dts        | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/p1020mbg-pc_36b.dts        | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/p1020rdb-pc.dtsi           | 0
 arch/powerpc/boot/dts/{ => fsl}/p1020rdb-pc_32b.dts        | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/p1020rdb-pc_36b.dts        | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/p1020rdb-pc_camp_core0.dts | 0
 arch/powerpc/boot/dts/{ => fsl}/p1020rdb-pc_camp_core1.dts | 0
 arch/powerpc/boot/dts/{ => fsl}/p1020rdb-pd.dts            | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/p1020rdb.dts               | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/p1020rdb.dtsi              | 0
 arch/powerpc/boot/dts/{ => fsl}/p1020rdb_36b.dts           | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/p1020utm-pc.dtsi           | 0
 arch/powerpc/boot/dts/{ => fsl}/p1020utm-pc_32b.dts        | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/p1020utm-pc_36b.dts        | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/p1021mds.dts               | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/p1021rdb-pc.dtsi           | 0
 arch/powerpc/boot/dts/{ => fsl}/p1021rdb-pc_32b.dts        | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/p1021rdb-pc_36b.dts        | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/p1022ds.dtsi               | 0
 arch/powerpc/boot/dts/{ => fsl}/p1022ds_32b.dts            | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/p1022ds_36b.dts            | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/p1022rdk.dts               | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/p1023rdb.dts               | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/p1024rdb.dtsi              | 0
 arch/powerpc/boot/dts/{ => fsl}/p1024rdb_32b.dts           | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/p1024rdb_36b.dts           | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/p1025rdb.dtsi              | 0
 arch/powerpc/boot/dts/{ => fsl}/p1025rdb_32b.dts           | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/p1025rdb_36b.dts           | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/p1025twr.dts               | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/p1025twr.dtsi              | 0
 arch/powerpc/boot/dts/{ => fsl}/p2020ds.dts                | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/p2020ds.dtsi               | 0
 arch/powerpc/boot/dts/{ => fsl}/p2020rdb-pc.dtsi           | 0
 arch/powerpc/boot/dts/{ => fsl}/p2020rdb-pc_32b.dts        | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/p2020rdb-pc_36b.dts        | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/p2020rdb.dts               | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/p2041rdb.dts               | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/p3041ds.dts                | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/p4080ds.dts                | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/p5020ds.dts                | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/p5040ds.dts                | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/ppa8548.dts                | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/t1023rdb.dts               | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/t1024qds.dts               | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/t1024rdb.dts               | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/t1040d4rdb.dts             | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/t1040qds.dts               | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/t1040rdb.dts               | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/t1042d4rdb.dts             | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/t1042qds.dts               | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/t1042rdb.dts               | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/t1042rdb_pi.dts            | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/t104xd4rdb.dtsi            | 0
 arch/powerpc/boot/dts/{ => fsl}/t104xqds.dtsi              | 0
 arch/powerpc/boot/dts/{ => fsl}/t104xrdb.dtsi              | 0
 arch/powerpc/boot/dts/{ => fsl}/t2080qds.dts               | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/t2080rdb.dts               | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/t2081qds.dts               | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/t208xqds.dtsi              | 0
 arch/powerpc/boot/dts/{ => fsl}/t208xrdb.dtsi              | 0
 arch/powerpc/boot/dts/{ => fsl}/t4240qds.dts               | 4 ++--
 arch/powerpc/boot/dts/{ => fsl}/t4240rdb.dts               | 4 ++--
 103 files changed, 141 insertions(+), 141 deletions(-)
 rename arch/powerpc/boot/dts/{ => fsl}/b4420qds.dts (96%)
 rename arch/powerpc/boot/dts/{ => fsl}/b4860qds.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/b4qds.dtsi (99%)
 rename arch/powerpc/boot/dts/{ => fsl}/bsc9131rdb.dts (91%)
 rename arch/powerpc/boot/dts/{ => fsl}/bsc9131rdb.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/bsc9132qds.dts (91%)
 rename arch/powerpc/boot/dts/{ => fsl}/bsc9132qds.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/c293pcie.dts (98%)
 rename arch/powerpc/boot/dts/{ => fsl}/ge_imp3a.dts (98%)
 rename arch/powerpc/boot/dts/{ => fsl}/kmcoge4.dts (98%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8536ds.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8536ds.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8536ds_36b.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8540ads.dts (99%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8541cds.dts (99%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8544ds.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8544ds.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8548cds.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8548cds_32b.dts (96%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8548cds_36b.dts (96%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8555cds.dts (99%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8560ads.dts (99%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8568mds.dts (99%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8569mds.dts (99%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8572ds.dts (96%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8572ds.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8572ds_36b.dts (96%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8572ds_camp_core0.dts (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8572ds_camp_core1.dts (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/mvme2500.dts (98%)
 rename arch/powerpc/boot/dts/{ => fsl}/oca4080.dts (98%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1010rdb-pa.dts (88%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1010rdb-pa.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1010rdb-pa_36b.dts (96%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1010rdb-pb.dts (89%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1010rdb-pb_36b.dts (96%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1010rdb.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1010rdb_32b.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1010rdb_36b.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1020mbg-pc.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1020mbg-pc_32b.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1020mbg-pc_36b.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1020rdb-pc.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1020rdb-pc_32b.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1020rdb-pc_36b.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1020rdb-pc_camp_core0.dts (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1020rdb-pc_camp_core1.dts (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1020rdb-pd.dts (99%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1020rdb.dts (95%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1020rdb.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1020rdb_36b.dts (95%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1020utm-pc.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1020utm-pc_32b.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1020utm-pc_36b.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1021mds.dts (99%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1021rdb-pc.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1021rdb-pc_32b.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1021rdb-pc_36b.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1022ds.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1022ds_32b.dts (98%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1022ds_36b.dts (98%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1022rdk.dts (98%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1023rdb.dts (99%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1024rdb.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1024rdb_32b.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1024rdb_36b.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1025rdb.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1025rdb_32b.dts (98%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1025rdb_36b.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1025twr.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1025twr.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/p2020ds.dts (96%)
 rename arch/powerpc/boot/dts/{ => fsl}/p2020ds.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/p2020rdb-pc.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/p2020rdb-pc_32b.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/p2020rdb-pc_36b.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/p2020rdb.dts (98%)
 rename arch/powerpc/boot/dts/{ => fsl}/p2041rdb.dts (98%)
 rename arch/powerpc/boot/dts/{ => fsl}/p3041ds.dts (99%)
 rename arch/powerpc/boot/dts/{ => fsl}/p4080ds.dts (98%)
 rename arch/powerpc/boot/dts/{ => fsl}/p5020ds.dts (99%)
 rename arch/powerpc/boot/dts/{ => fsl}/p5040ds.dts (98%)
 rename arch/powerpc/boot/dts/{ => fsl}/ppa8548.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/t1023rdb.dts (98%)
 rename arch/powerpc/boot/dts/{ => fsl}/t1024qds.dts (98%)
 rename arch/powerpc/boot/dts/{ => fsl}/t1024rdb.dts (98%)
 rename arch/powerpc/boot/dts/{ => fsl}/t1040d4rdb.dts (96%)
 rename arch/powerpc/boot/dts/{ => fsl}/t1040qds.dts (96%)
 rename arch/powerpc/boot/dts/{ => fsl}/t1040rdb.dts (96%)
 rename arch/powerpc/boot/dts/{ => fsl}/t1042d4rdb.dts (96%)
 rename arch/powerpc/boot/dts/{ => fsl}/t1042qds.dts (96%)
 rename arch/powerpc/boot/dts/{ => fsl}/t1042rdb.dts (96%)
 rename arch/powerpc/boot/dts/{ => fsl}/t1042rdb_pi.dts (96%)
 rename arch/powerpc/boot/dts/{ => fsl}/t104xd4rdb.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/t104xqds.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/t104xrdb.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/t2080qds.dts (96%)
 rename arch/powerpc/boot/dts/{ => fsl}/t2080rdb.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/t2081qds.dts (96%)
 rename arch/powerpc/boot/dts/{ => fsl}/t208xqds.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/t208xrdb.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/t4240qds.dts (99%)
 rename arch/powerpc/boot/dts/{ => fsl}/t4240rdb.dts (98%)

diff --git a/arch/powerpc/boot/dts/b4420qds.dts b/arch/powerpc/boot/dts/fsl/b4420qds.dts
similarity index 96%
rename from arch/powerpc/boot/dts/b4420qds.dts
rename to arch/powerpc/boot/dts/fsl/b4420qds.dts
index 508dbdf..cd9203c 100644
--- a/arch/powerpc/boot/dts/b4420qds.dts
+++ b/arch/powerpc/boot/dts/fsl/b4420qds.dts
@@ -32,7 +32,7 @@
  * this software, even if advised of the possibility of such damage.
  */
 
-/include/ "fsl/b4420si-pre.dtsi"
+/include/ "b4420si-pre.dtsi"
 /include/ "b4qds.dtsi"
 
 / {
@@ -47,4 +47,4 @@
 
 };
 
-/include/ "fsl/b4420si-post.dtsi"
+/include/ "b4420si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/b4860qds.dts b/arch/powerpc/boot/dts/fsl/b4860qds.dts
similarity index 97%
rename from arch/powerpc/boot/dts/b4860qds.dts
rename to arch/powerpc/boot/dts/fsl/b4860qds.dts
index 6bb3707..ba8c9be 100644
--- a/arch/powerpc/boot/dts/b4860qds.dts
+++ b/arch/powerpc/boot/dts/fsl/b4860qds.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/b4860si-pre.dtsi"
+/include/ "b4860si-pre.dtsi"
 /include/ "b4qds.dtsi"
 
 / {
@@ -58,4 +58,4 @@
 
 };
 
-/include/ "fsl/b4860si-post.dtsi"
+/include/ "b4860si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/b4qds.dtsi b/arch/powerpc/boot/dts/fsl/b4qds.dtsi
similarity index 99%
rename from arch/powerpc/boot/dts/b4qds.dtsi
rename to arch/powerpc/boot/dts/fsl/b4qds.dtsi
index 559d006..6455774 100644
--- a/arch/powerpc/boot/dts/b4qds.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4qds.dtsi
@@ -229,4 +229,4 @@
 
 };
 
-/include/ "fsl/b4si-post.dtsi"
+/include/ "b4si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/bsc9131rdb.dts b/arch/powerpc/boot/dts/fsl/bsc9131rdb.dts
similarity index 91%
rename from arch/powerpc/boot/dts/bsc9131rdb.dts
rename to arch/powerpc/boot/dts/fsl/bsc9131rdb.dts
index e13d2d4..26366e6 100644
--- a/arch/powerpc/boot/dts/bsc9131rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/bsc9131rdb.dts
@@ -9,7 +9,7 @@
  * option) any later version.
  */
 
-/include/ "fsl/bsc9131si-pre.dtsi"
+/include/ "bsc9131si-pre.dtsi"
 
 / {
 	model = "fsl,bsc9131rdb";
@@ -31,4 +31,4 @@
 };
 
 /include/ "bsc9131rdb.dtsi"
-/include/ "fsl/bsc9131si-post.dtsi"
+/include/ "bsc9131si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/bsc9131rdb.dtsi b/arch/powerpc/boot/dts/fsl/bsc9131rdb.dtsi
similarity index 100%
rename from arch/powerpc/boot/dts/bsc9131rdb.dtsi
rename to arch/powerpc/boot/dts/fsl/bsc9131rdb.dtsi
diff --git a/arch/powerpc/boot/dts/bsc9132qds.dts b/arch/powerpc/boot/dts/fsl/bsc9132qds.dts
similarity index 91%
rename from arch/powerpc/boot/dts/bsc9132qds.dts
rename to arch/powerpc/boot/dts/fsl/bsc9132qds.dts
index 6cab106..70882ad 100644
--- a/arch/powerpc/boot/dts/bsc9132qds.dts
+++ b/arch/powerpc/boot/dts/fsl/bsc9132qds.dts
@@ -9,7 +9,7 @@
  * option) any later version.
  */
 
-/include/ "fsl/bsc9132si-pre.dtsi"
+/include/ "bsc9132si-pre.dtsi"
 
 / {
 	model = "fsl,bsc9132qds";
@@ -32,4 +32,4 @@
 };
 
 /include/ "bsc9132qds.dtsi"
-/include/ "fsl/bsc9132si-post.dtsi"
+/include/ "bsc9132si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/bsc9132qds.dtsi b/arch/powerpc/boot/dts/fsl/bsc9132qds.dtsi
similarity index 100%
rename from arch/powerpc/boot/dts/bsc9132qds.dtsi
rename to arch/powerpc/boot/dts/fsl/bsc9132qds.dtsi
diff --git a/arch/powerpc/boot/dts/c293pcie.dts b/arch/powerpc/boot/dts/fsl/c293pcie.dts
similarity index 98%
rename from arch/powerpc/boot/dts/c293pcie.dts
rename to arch/powerpc/boot/dts/fsl/c293pcie.dts
index 6681cc2..53ab4db 100644
--- a/arch/powerpc/boot/dts/c293pcie.dts
+++ b/arch/powerpc/boot/dts/fsl/c293pcie.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/c293si-pre.dtsi"
+/include/ "c293si-pre.dtsi"
 
 / {
 	model = "fsl,C293PCIE";
@@ -221,4 +221,4 @@
 		phy-connection-type = "rgmii-id";
 	};
 };
-/include/ "fsl/c293si-post.dtsi"
+/include/ "c293si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/ge_imp3a.dts b/arch/powerpc/boot/dts/fsl/ge_imp3a.dts
similarity index 98%
rename from arch/powerpc/boot/dts/ge_imp3a.dts
rename to arch/powerpc/boot/dts/fsl/ge_imp3a.dts
index fefae41..a2bb47f 100644
--- a/arch/powerpc/boot/dts/ge_imp3a.dts
+++ b/arch/powerpc/boot/dts/fsl/ge_imp3a.dts
@@ -12,7 +12,7 @@
  * Copyright 2009 Freescale Semiconductor Inc.
  */
 
-/include/ "fsl/p2020si-pre.dtsi"
+/include/ "p2020si-pre.dtsi"
 
 / {
 	model = "GE_IMP3A";
@@ -252,4 +252,4 @@
 	};
 };
 
-/include/ "fsl/p2020si-post.dtsi"
+/include/ "p2020si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/kmcoge4.dts b/arch/powerpc/boot/dts/fsl/kmcoge4.dts
similarity index 98%
rename from arch/powerpc/boot/dts/kmcoge4.dts
rename to arch/powerpc/boot/dts/fsl/kmcoge4.dts
index 48dab6a..6858ec9 100644
--- a/arch/powerpc/boot/dts/kmcoge4.dts
+++ b/arch/powerpc/boot/dts/fsl/kmcoge4.dts
@@ -12,7 +12,7 @@
  * option) any later version.
  */
 
-/include/ "fsl/p2041si-pre.dtsi"
+/include/ "p2041si-pre.dtsi"
 
 / {
 	model = "keymile,kmcoge4";
@@ -176,4 +176,4 @@
 	};
 };
 
-/include/ "fsl/p2041si-post.dtsi"
+/include/ "p2041si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/mpc8536ds.dts b/arch/powerpc/boot/dts/fsl/mpc8536ds.dts
similarity index 97%
rename from arch/powerpc/boot/dts/mpc8536ds.dts
rename to arch/powerpc/boot/dts/fsl/mpc8536ds.dts
index 1973622..96cdce8 100644
--- a/arch/powerpc/boot/dts/mpc8536ds.dts
+++ b/arch/powerpc/boot/dts/fsl/mpc8536ds.dts
@@ -9,7 +9,7 @@
  * option) any later version.
  */
 
-/include/ "fsl/mpc8536si-pre.dtsi"
+/include/ "mpc8536si-pre.dtsi"
 
 / {
 	model = "fsl,mpc8536ds";
@@ -105,5 +105,5 @@
 	};
 };
 
-/include/ "fsl/mpc8536si-post.dtsi"
+/include/ "mpc8536si-post.dtsi"
 /include/ "mpc8536ds.dtsi"
diff --git a/arch/powerpc/boot/dts/mpc8536ds.dtsi b/arch/powerpc/boot/dts/fsl/mpc8536ds.dtsi
similarity index 100%
rename from arch/powerpc/boot/dts/mpc8536ds.dtsi
rename to arch/powerpc/boot/dts/fsl/mpc8536ds.dtsi
diff --git a/arch/powerpc/boot/dts/mpc8536ds_36b.dts b/arch/powerpc/boot/dts/fsl/mpc8536ds_36b.dts
similarity index 97%
rename from arch/powerpc/boot/dts/mpc8536ds_36b.dts
rename to arch/powerpc/boot/dts/fsl/mpc8536ds_36b.dts
index 6c723ee..38d326c 100644
--- a/arch/powerpc/boot/dts/mpc8536ds_36b.dts
+++ b/arch/powerpc/boot/dts/fsl/mpc8536ds_36b.dts
@@ -9,7 +9,7 @@
  * option) any later version.
  */
 
-/include/ "fsl/mpc8536si-pre.dtsi"
+/include/ "mpc8536si-pre.dtsi"
 
 / {
 	model = "fsl,mpc8536ds";
@@ -105,5 +105,5 @@
 	};
 };
 
-/include/ "fsl/mpc8536si-post.dtsi"
+/include/ "mpc8536si-post.dtsi"
 /include/ "mpc8536ds.dtsi"
diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts b/arch/powerpc/boot/dts/fsl/mpc8540ads.dts
similarity index 99%
rename from arch/powerpc/boot/dts/mpc8540ads.dts
rename to arch/powerpc/boot/dts/fsl/mpc8540ads.dts
index 7ce274c..e6d0b16 100644
--- a/arch/powerpc/boot/dts/mpc8540ads.dts
+++ b/arch/powerpc/boot/dts/fsl/mpc8540ads.dts
@@ -11,7 +11,7 @@
 
 /dts-v1/;
 
-/include/ "fsl/e500v2_power_isa.dtsi"
+/include/ "e500v2_power_isa.dtsi"
 
 / {
 	model = "MPC8540ADS";
diff --git a/arch/powerpc/boot/dts/mpc8541cds.dts b/arch/powerpc/boot/dts/fsl/mpc8541cds.dts
similarity index 99%
rename from arch/powerpc/boot/dts/mpc8541cds.dts
rename to arch/powerpc/boot/dts/fsl/mpc8541cds.dts
index 4d35a3e..9fa2c73 100644
--- a/arch/powerpc/boot/dts/mpc8541cds.dts
+++ b/arch/powerpc/boot/dts/fsl/mpc8541cds.dts
@@ -11,7 +11,7 @@
 
 /dts-v1/;
 
-/include/ "fsl/e500v2_power_isa.dtsi"
+/include/ "e500v2_power_isa.dtsi"
 
 / {
 	model = "MPC8541CDS";
diff --git a/arch/powerpc/boot/dts/mpc8544ds.dts b/arch/powerpc/boot/dts/fsl/mpc8544ds.dts
similarity index 97%
rename from arch/powerpc/boot/dts/mpc8544ds.dts
rename to arch/powerpc/boot/dts/fsl/mpc8544ds.dts
index ed38874..5a6e468 100644
--- a/arch/powerpc/boot/dts/mpc8544ds.dts
+++ b/arch/powerpc/boot/dts/fsl/mpc8544ds.dts
@@ -9,7 +9,7 @@
  * option) any later version.
  */
 
-/include/ "fsl/mpc8544si-pre.dtsi"
+/include/ "mpc8544si-pre.dtsi"
 
 / {
 	model = "MPC8544DS";
@@ -103,5 +103,5 @@
  * for interrupt-map & interrupt-map-mask
  */
 
-/include/ "fsl/mpc8544si-post.dtsi"
+/include/ "mpc8544si-post.dtsi"
 /include/ "mpc8544ds.dtsi"
diff --git a/arch/powerpc/boot/dts/mpc8544ds.dtsi b/arch/powerpc/boot/dts/fsl/mpc8544ds.dtsi
similarity index 100%
rename from arch/powerpc/boot/dts/mpc8544ds.dtsi
rename to arch/powerpc/boot/dts/fsl/mpc8544ds.dtsi
diff --git a/arch/powerpc/boot/dts/mpc8548cds.dtsi b/arch/powerpc/boot/dts/fsl/mpc8548cds.dtsi
similarity index 100%
rename from arch/powerpc/boot/dts/mpc8548cds.dtsi
rename to arch/powerpc/boot/dts/fsl/mpc8548cds.dtsi
diff --git a/arch/powerpc/boot/dts/mpc8548cds_32b.dts b/arch/powerpc/boot/dts/fsl/mpc8548cds_32b.dts
similarity index 96%
rename from arch/powerpc/boot/dts/mpc8548cds_32b.dts
rename to arch/powerpc/boot/dts/fsl/mpc8548cds_32b.dts
index 6fd6316..e4620bb 100644
--- a/arch/powerpc/boot/dts/mpc8548cds_32b.dts
+++ b/arch/powerpc/boot/dts/fsl/mpc8548cds_32b.dts
@@ -9,7 +9,7 @@
  * option) any later version.
  */
 
-/include/ "fsl/mpc8548si-pre.dtsi"
+/include/ "mpc8548si-pre.dtsi"
 
 / {
 	model = "MPC8548CDS";
@@ -82,5 +82,5 @@
  * for interrupt-map & interrupt-map-mask.
  */
 
-/include/ "fsl/mpc8548si-post.dtsi"
+/include/ "mpc8548si-post.dtsi"
 /include/ "mpc8548cds.dtsi"
diff --git a/arch/powerpc/boot/dts/mpc8548cds_36b.dts b/arch/powerpc/boot/dts/fsl/mpc8548cds_36b.dts
similarity index 96%
rename from arch/powerpc/boot/dts/mpc8548cds_36b.dts
rename to arch/powerpc/boot/dts/fsl/mpc8548cds_36b.dts
index 10e551b..bca7c09 100644
--- a/arch/powerpc/boot/dts/mpc8548cds_36b.dts
+++ b/arch/powerpc/boot/dts/fsl/mpc8548cds_36b.dts
@@ -9,7 +9,7 @@
  * option) any later version.
  */
 
-/include/ "fsl/mpc8548si-pre.dtsi"
+/include/ "mpc8548si-pre.dtsi"
 
 / {
 	model = "MPC8548CDS";
@@ -82,5 +82,5 @@
  * for interrupt-map & interrupt-map-mask.
  */
 
-/include/ "fsl/mpc8548si-post.dtsi"
+/include/ "mpc8548si-post.dtsi"
 /include/ "mpc8548cds.dtsi"
diff --git a/arch/powerpc/boot/dts/mpc8555cds.dts b/arch/powerpc/boot/dts/fsl/mpc8555cds.dts
similarity index 99%
rename from arch/powerpc/boot/dts/mpc8555cds.dts
rename to arch/powerpc/boot/dts/fsl/mpc8555cds.dts
index f115f21..272f08c 100644
--- a/arch/powerpc/boot/dts/mpc8555cds.dts
+++ b/arch/powerpc/boot/dts/fsl/mpc8555cds.dts
@@ -11,7 +11,7 @@
 
 /dts-v1/;
 
-/include/ "fsl/e500v2_power_isa.dtsi"
+/include/ "e500v2_power_isa.dtsi"
 
 / {
 	model = "MPC8555CDS";
diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/boot/dts/fsl/mpc8560ads.dts
similarity index 99%
rename from arch/powerpc/boot/dts/mpc8560ads.dts
rename to arch/powerpc/boot/dts/fsl/mpc8560ads.dts
index 0d70921..7a822b0 100644
--- a/arch/powerpc/boot/dts/mpc8560ads.dts
+++ b/arch/powerpc/boot/dts/fsl/mpc8560ads.dts
@@ -11,7 +11,7 @@
 
 /dts-v1/;
 
-/include/ "fsl/e500v2_power_isa.dtsi"
+/include/ "e500v2_power_isa.dtsi"
 
 / {
 	model = "MPC8560ADS";
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/fsl/mpc8568mds.dts
similarity index 99%
rename from arch/powerpc/boot/dts/mpc8568mds.dts
rename to arch/powerpc/boot/dts/fsl/mpc8568mds.dts
index bead2b6..01706a3 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/fsl/mpc8568mds.dts
@@ -9,7 +9,7 @@
  * option) any later version.
  */
 
-/include/ "fsl/mpc8568si-pre.dtsi"
+/include/ "mpc8568si-pre.dtsi"
 
 / {
 	model = "MPC8568EMDS";
@@ -311,4 +311,4 @@
 	};
 };
 
-/include/ "fsl/mpc8568si-post.dtsi"
+/include/ "mpc8568si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/mpc8569mds.dts b/arch/powerpc/boot/dts/fsl/mpc8569mds.dts
similarity index 99%
rename from arch/powerpc/boot/dts/mpc8569mds.dts
rename to arch/powerpc/boot/dts/fsl/mpc8569mds.dts
index d0dcdaf..a95ff7d 100644
--- a/arch/powerpc/boot/dts/mpc8569mds.dts
+++ b/arch/powerpc/boot/dts/fsl/mpc8569mds.dts
@@ -9,7 +9,7 @@
  * option) any later version.
  */
 
-/include/ "fsl/mpc8569si-pre.dtsi"
+/include/ "mpc8569si-pre.dtsi"
 
 / {
 	model = "MPC8569EMDS";
@@ -444,4 +444,4 @@
 	};
 };
 
-/include/ "fsl/mpc8569si-post.dtsi"
+/include/ "mpc8569si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/mpc8572ds.dts b/arch/powerpc/boot/dts/fsl/mpc8572ds.dts
similarity index 96%
rename from arch/powerpc/boot/dts/mpc8572ds.dts
rename to arch/powerpc/boot/dts/fsl/mpc8572ds.dts
index 0c9f295..8ee5b24 100644
--- a/arch/powerpc/boot/dts/mpc8572ds.dts
+++ b/arch/powerpc/boot/dts/fsl/mpc8572ds.dts
@@ -9,7 +9,7 @@
  * option) any later version.
  */
 
-/include/ "fsl/mpc8572si-pre.dtsi"
+/include/ "mpc8572si-pre.dtsi"
 
 / {
 	model = "fsl,MPC8572DS";
@@ -86,5 +86,5 @@
  * for interrupt-map & interrupt-map-mask
  */
 
-/include/ "fsl/mpc8572si-post.dtsi"
+/include/ "mpc8572si-post.dtsi"
 /include/ "mpc8572ds.dtsi"
diff --git a/arch/powerpc/boot/dts/mpc8572ds.dtsi b/arch/powerpc/boot/dts/fsl/mpc8572ds.dtsi
similarity index 100%
rename from arch/powerpc/boot/dts/mpc8572ds.dtsi
rename to arch/powerpc/boot/dts/fsl/mpc8572ds.dtsi
diff --git a/arch/powerpc/boot/dts/mpc8572ds_36b.dts b/arch/powerpc/boot/dts/fsl/mpc8572ds_36b.dts
similarity index 96%
rename from arch/powerpc/boot/dts/mpc8572ds_36b.dts
rename to arch/powerpc/boot/dts/fsl/mpc8572ds_36b.dts
index 6c3d0b3..5c48b46 100644
--- a/arch/powerpc/boot/dts/mpc8572ds_36b.dts
+++ b/arch/powerpc/boot/dts/fsl/mpc8572ds_36b.dts
@@ -9,7 +9,7 @@
  * option) any later version.
  */
 
-/include/ "fsl/mpc8572si-pre.dtsi"
+/include/ "mpc8572si-pre.dtsi"
 
 / {
 	model = "fsl,MPC8572DS";
@@ -86,5 +86,5 @@
  * for interrupt-map & interrupt-map-mask
  */
 
-/include/ "fsl/mpc8572si-post.dtsi"
+/include/ "mpc8572si-post.dtsi"
 /include/ "mpc8572ds.dtsi"
diff --git a/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts b/arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core0.dts
similarity index 100%
rename from arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts
rename to arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core0.dts
diff --git a/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts b/arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core1.dts
similarity index 100%
rename from arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts
rename to arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core1.dts
diff --git a/arch/powerpc/boot/dts/mvme2500.dts b/arch/powerpc/boot/dts/fsl/mvme2500.dts
similarity index 98%
rename from arch/powerpc/boot/dts/mvme2500.dts
rename to arch/powerpc/boot/dts/fsl/mvme2500.dts
index 67714cf..c7bc1a0 100644
--- a/arch/powerpc/boot/dts/mvme2500.dts
+++ b/arch/powerpc/boot/dts/fsl/mvme2500.dts
@@ -12,7 +12,7 @@
  * Copyright 2009 Freescale Semiconductor Inc.
  */
 
-/include/ "fsl/p2020si-pre.dtsi"
+/include/ "p2020si-pre.dtsi"
 
 / {
 	model = "MVME2500";
@@ -258,7 +258,7 @@
 	};
 };
 
-/include/ "fsl/p2020si-post.dtsi"
+/include/ "p2020si-post.dtsi"
 
 / {
 	soc@ffe00000 {
diff --git a/arch/powerpc/boot/dts/oca4080.dts b/arch/powerpc/boot/dts/fsl/oca4080.dts
similarity index 98%
rename from arch/powerpc/boot/dts/oca4080.dts
rename to arch/powerpc/boot/dts/fsl/oca4080.dts
index 42796c5..17bc6f3 100644
--- a/arch/powerpc/boot/dts/oca4080.dts
+++ b/arch/powerpc/boot/dts/fsl/oca4080.dts
@@ -36,7 +36,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/p4080si-pre.dtsi"
+/include/ "p4080si-pre.dtsi"
 
 / {
 	model = "fsl,OCA4080";
@@ -142,4 +142,4 @@
 	};
 };
 
-/include/ "fsl/p4080si-post.dtsi"
+/include/ "p4080si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1010rdb-pa.dts b/arch/powerpc/boot/dts/fsl/p1010rdb-pa.dts
similarity index 88%
rename from arch/powerpc/boot/dts/p1010rdb-pa.dts
rename to arch/powerpc/boot/dts/fsl/p1010rdb-pa.dts
index 767d4c0..e4ab53c 100644
--- a/arch/powerpc/boot/dts/p1010rdb-pa.dts
+++ b/arch/powerpc/boot/dts/fsl/p1010rdb-pa.dts
@@ -9,7 +9,7 @@
  * option) any later version.
  */
 
-/include/ "fsl/p1010si-pre.dtsi"
+/include/ "p1010si-pre.dtsi"
 
 / {
 	model = "fsl,P1010RDB";
@@ -20,4 +20,4 @@
 
 /include/ "p1010rdb.dtsi"
 /include/ "p1010rdb-pa.dtsi"
-/include/ "fsl/p1010si-post.dtsi"
+/include/ "p1010si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1010rdb-pa.dtsi b/arch/powerpc/boot/dts/fsl/p1010rdb-pa.dtsi
similarity index 100%
rename from arch/powerpc/boot/dts/p1010rdb-pa.dtsi
rename to arch/powerpc/boot/dts/fsl/p1010rdb-pa.dtsi
diff --git a/arch/powerpc/boot/dts/p1010rdb-pa_36b.dts b/arch/powerpc/boot/dts/fsl/p1010rdb-pa_36b.dts
similarity index 96%
rename from arch/powerpc/boot/dts/p1010rdb-pa_36b.dts
rename to arch/powerpc/boot/dts/fsl/p1010rdb-pa_36b.dts
index 3033371..03bd76c 100644
--- a/arch/powerpc/boot/dts/p1010rdb-pa_36b.dts
+++ b/arch/powerpc/boot/dts/fsl/p1010rdb-pa_36b.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/p1010si-pre.dtsi"
+/include/ "p1010si-pre.dtsi"
 
 / {
 	model = "fsl,P1010RDB";
@@ -43,4 +43,4 @@
 
 /include/ "p1010rdb.dtsi"
 /include/ "p1010rdb-pa.dtsi"
-/include/ "fsl/p1010si-post.dtsi"
+/include/ "p1010si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1010rdb-pb.dts b/arch/powerpc/boot/dts/fsl/p1010rdb-pb.dts
similarity index 89%
rename from arch/powerpc/boot/dts/p1010rdb-pb.dts
rename to arch/powerpc/boot/dts/fsl/p1010rdb-pb.dts
index 6eeb7d3..37681fd 100644
--- a/arch/powerpc/boot/dts/p1010rdb-pb.dts
+++ b/arch/powerpc/boot/dts/fsl/p1010rdb-pb.dts
@@ -9,7 +9,7 @@
  * option) any later version.
  */
 
-/include/ "fsl/p1010si-pre.dtsi"
+/include/ "p1010si-pre.dtsi"
 
 / {
 	model = "fsl,P1010RDB-PB";
@@ -32,4 +32,4 @@
 	interrupts = <1 1 0 0>;
 };
 
-/include/ "fsl/p1010si-post.dtsi"
+/include/ "p1010si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1010rdb-pb_36b.dts b/arch/powerpc/boot/dts/fsl/p1010rdb-pb_36b.dts
similarity index 96%
rename from arch/powerpc/boot/dts/p1010rdb-pb_36b.dts
rename to arch/powerpc/boot/dts/fsl/p1010rdb-pb_36b.dts
index 7ab3c90..4cf255f 100644
--- a/arch/powerpc/boot/dts/p1010rdb-pb_36b.dts
+++ b/arch/powerpc/boot/dts/fsl/p1010rdb-pb_36b.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/p1010si-pre.dtsi"
+/include/ "p1010si-pre.dtsi"
 
 / {
 	model = "fsl,P1010RDB-PB";
@@ -55,4 +55,4 @@
 	interrupts = <1 1 0 0>;
 };
 
-/include/ "fsl/p1010si-post.dtsi"
+/include/ "p1010si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1010rdb.dtsi b/arch/powerpc/boot/dts/fsl/p1010rdb.dtsi
similarity index 100%
rename from arch/powerpc/boot/dts/p1010rdb.dtsi
rename to arch/powerpc/boot/dts/fsl/p1010rdb.dtsi
diff --git a/arch/powerpc/boot/dts/p1010rdb_32b.dtsi b/arch/powerpc/boot/dts/fsl/p1010rdb_32b.dtsi
similarity index 100%
rename from arch/powerpc/boot/dts/p1010rdb_32b.dtsi
rename to arch/powerpc/boot/dts/fsl/p1010rdb_32b.dtsi
diff --git a/arch/powerpc/boot/dts/p1010rdb_36b.dtsi b/arch/powerpc/boot/dts/fsl/p1010rdb_36b.dtsi
similarity index 100%
rename from arch/powerpc/boot/dts/p1010rdb_36b.dtsi
rename to arch/powerpc/boot/dts/fsl/p1010rdb_36b.dtsi
diff --git a/arch/powerpc/boot/dts/p1020mbg-pc.dtsi b/arch/powerpc/boot/dts/fsl/p1020mbg-pc.dtsi
similarity index 100%
rename from arch/powerpc/boot/dts/p1020mbg-pc.dtsi
rename to arch/powerpc/boot/dts/fsl/p1020mbg-pc.dtsi
diff --git a/arch/powerpc/boot/dts/p1020mbg-pc_32b.dts b/arch/powerpc/boot/dts/fsl/p1020mbg-pc_32b.dts
similarity index 97%
rename from arch/powerpc/boot/dts/p1020mbg-pc_32b.dts
rename to arch/powerpc/boot/dts/fsl/p1020mbg-pc_32b.dts
index ab8f076..b29d1fc 100644
--- a/arch/powerpc/boot/dts/p1020mbg-pc_32b.dts
+++ b/arch/powerpc/boot/dts/fsl/p1020mbg-pc_32b.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/p1020si-pre.dtsi"
+/include/ "p1020si-pre.dtsi"
 / {
 	model = "fsl,P1020MBG-PC";
 	compatible = "fsl,P1020MBG-PC";
@@ -86,4 +86,4 @@
 };
 
 /include/ "p1020mbg-pc.dtsi"
-/include/ "fsl/p1020si-post.dtsi"
+/include/ "p1020si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1020mbg-pc_36b.dts b/arch/powerpc/boot/dts/fsl/p1020mbg-pc_36b.dts
similarity index 97%
rename from arch/powerpc/boot/dts/p1020mbg-pc_36b.dts
rename to arch/powerpc/boot/dts/fsl/p1020mbg-pc_36b.dts
index 9e9f401..678d0ee 100644
--- a/arch/powerpc/boot/dts/p1020mbg-pc_36b.dts
+++ b/arch/powerpc/boot/dts/fsl/p1020mbg-pc_36b.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/p1020si-pre.dtsi"
+/include/ "p1020si-pre.dtsi"
 / {
 	model = "fsl,P1020MBG-PC";
 	compatible = "fsl,P1020MBG-PC";
@@ -86,4 +86,4 @@
 };
 
 /include/ "p1020mbg-pc.dtsi"
-/include/ "fsl/p1020si-post.dtsi"
+/include/ "p1020si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1020rdb-pc.dtsi b/arch/powerpc/boot/dts/fsl/p1020rdb-pc.dtsi
similarity index 100%
rename from arch/powerpc/boot/dts/p1020rdb-pc.dtsi
rename to arch/powerpc/boot/dts/fsl/p1020rdb-pc.dtsi
diff --git a/arch/powerpc/boot/dts/p1020rdb-pc_32b.dts b/arch/powerpc/boot/dts/fsl/p1020rdb-pc_32b.dts
similarity index 97%
rename from arch/powerpc/boot/dts/p1020rdb-pc_32b.dts
rename to arch/powerpc/boot/dts/fsl/p1020rdb-pc_32b.dts
index 4de69b7..8175bf6 100644
--- a/arch/powerpc/boot/dts/p1020rdb-pc_32b.dts
+++ b/arch/powerpc/boot/dts/fsl/p1020rdb-pc_32b.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/p1020si-pre.dtsi"
+/include/ "p1020si-pre.dtsi"
 / {
 	model = "fsl,P1020RDB-PC";
 	compatible = "fsl,P1020RDB-PC";
@@ -87,4 +87,4 @@
 };
 
 /include/ "p1020rdb-pc.dtsi"
-/include/ "fsl/p1020si-post.dtsi"
+/include/ "p1020si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1020rdb-pc_36b.dts b/arch/powerpc/boot/dts/fsl/p1020rdb-pc_36b.dts
similarity index 97%
rename from arch/powerpc/boot/dts/p1020rdb-pc_36b.dts
rename to arch/powerpc/boot/dts/fsl/p1020rdb-pc_36b.dts
index 5237da7..01c3057 100644
--- a/arch/powerpc/boot/dts/p1020rdb-pc_36b.dts
+++ b/arch/powerpc/boot/dts/fsl/p1020rdb-pc_36b.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/p1020si-pre.dtsi"
+/include/ "p1020si-pre.dtsi"
 / {
 	model = "fsl,P1020RDB-PC";
 	compatible = "fsl,P1020RDB-PC";
@@ -87,4 +87,4 @@
 };
 
 /include/ "p1020rdb-pc.dtsi"
-/include/ "fsl/p1020si-post.dtsi"
+/include/ "p1020si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1020rdb-pc_camp_core0.dts b/arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core0.dts
similarity index 100%
rename from arch/powerpc/boot/dts/p1020rdb-pc_camp_core0.dts
rename to arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core0.dts
diff --git a/arch/powerpc/boot/dts/p1020rdb-pc_camp_core1.dts b/arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core1.dts
similarity index 100%
rename from arch/powerpc/boot/dts/p1020rdb-pc_camp_core1.dts
rename to arch/powerpc/boot/dts/fsl/p1020rdb-pc_camp_core1.dts
diff --git a/arch/powerpc/boot/dts/p1020rdb-pd.dts b/arch/powerpc/boot/dts/fsl/p1020rdb-pd.dts
similarity index 99%
rename from arch/powerpc/boot/dts/p1020rdb-pd.dts
rename to arch/powerpc/boot/dts/fsl/p1020rdb-pd.dts
index 987017e..63aca79 100644
--- a/arch/powerpc/boot/dts/p1020rdb-pd.dts
+++ b/arch/powerpc/boot/dts/fsl/p1020rdb-pd.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/p1020si-pre.dtsi"
+/include/ "p1020si-pre.dtsi"
 / {
 	model = "fsl,P1020RDB-PD";
 	compatible = "fsl,P1020RDB-PD";
@@ -277,4 +277,4 @@
 	};
 };
 
-/include/ "fsl/p1020si-post.dtsi"
+/include/ "p1020si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1020rdb.dts b/arch/powerpc/boot/dts/fsl/p1020rdb.dts
similarity index 95%
rename from arch/powerpc/boot/dts/p1020rdb.dts
rename to arch/powerpc/boot/dts/fsl/p1020rdb.dts
index 518bf99..8136225 100644
--- a/arch/powerpc/boot/dts/p1020rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/p1020rdb.dts
@@ -9,7 +9,7 @@
  * option) any later version.
  */
 
-/include/ "fsl/p1020si-pre.dtsi"
+/include/ "p1020si-pre.dtsi"
 / {
 	model = "fsl,P1020RDB";
 	compatible = "fsl,P1020RDB";
@@ -63,4 +63,4 @@
 };
 
 /include/ "p1020rdb.dtsi"
-/include/ "fsl/p1020si-post.dtsi"
+/include/ "p1020si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1020rdb.dtsi b/arch/powerpc/boot/dts/fsl/p1020rdb.dtsi
similarity index 100%
rename from arch/powerpc/boot/dts/p1020rdb.dtsi
rename to arch/powerpc/boot/dts/fsl/p1020rdb.dtsi
diff --git a/arch/powerpc/boot/dts/p1020rdb_36b.dts b/arch/powerpc/boot/dts/fsl/p1020rdb_36b.dts
similarity index 95%
rename from arch/powerpc/boot/dts/p1020rdb_36b.dts
rename to arch/powerpc/boot/dts/fsl/p1020rdb_36b.dts
index bdbdb60..74471e3 100644
--- a/arch/powerpc/boot/dts/p1020rdb_36b.dts
+++ b/arch/powerpc/boot/dts/fsl/p1020rdb_36b.dts
@@ -9,7 +9,7 @@
  * option) any later version.
  */
 
-/include/ "fsl/p1020si-pre.dtsi"
+/include/ "p1020si-pre.dtsi"
 / {
 	model = "fsl,P1020RDB";
 	compatible = "fsl,P1020RDB";
@@ -63,4 +63,4 @@
 };
 
 /include/ "p1020rdb.dtsi"
-/include/ "fsl/p1020si-post.dtsi"
+/include/ "p1020si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1020utm-pc.dtsi b/arch/powerpc/boot/dts/fsl/p1020utm-pc.dtsi
similarity index 100%
rename from arch/powerpc/boot/dts/p1020utm-pc.dtsi
rename to arch/powerpc/boot/dts/fsl/p1020utm-pc.dtsi
diff --git a/arch/powerpc/boot/dts/p1020utm-pc_32b.dts b/arch/powerpc/boot/dts/fsl/p1020utm-pc_32b.dts
similarity index 97%
rename from arch/powerpc/boot/dts/p1020utm-pc_32b.dts
rename to arch/powerpc/boot/dts/fsl/p1020utm-pc_32b.dts
index 4bfdd89..bc03ef6 100644
--- a/arch/powerpc/boot/dts/p1020utm-pc_32b.dts
+++ b/arch/powerpc/boot/dts/fsl/p1020utm-pc_32b.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/p1020si-pre.dtsi"
+/include/ "p1020si-pre.dtsi"
 / {
 	model = "fsl,P1020UTM-PC";
 	compatible = "fsl,P1020UTM-PC";
@@ -86,4 +86,4 @@
 };
 
 /include/ "p1020utm-pc.dtsi"
-/include/ "fsl/p1020si-post.dtsi"
+/include/ "p1020si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1020utm-pc_36b.dts b/arch/powerpc/boot/dts/fsl/p1020utm-pc_36b.dts
similarity index 97%
rename from arch/powerpc/boot/dts/p1020utm-pc_36b.dts
rename to arch/powerpc/boot/dts/fsl/p1020utm-pc_36b.dts
index abec535..32766f6 100644
--- a/arch/powerpc/boot/dts/p1020utm-pc_36b.dts
+++ b/arch/powerpc/boot/dts/fsl/p1020utm-pc_36b.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/p1020si-pre.dtsi"
+/include/ "p1020si-pre.dtsi"
 / {
 	model = "fsl,P1020UTM-PC";
 	compatible = "fsl,P1020UTM-PC";
@@ -86,4 +86,4 @@
 };
 
 /include/ "p1020utm-pc.dtsi"
-/include/ "fsl/p1020si-post.dtsi"
+/include/ "p1020si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1021mds.dts b/arch/powerpc/boot/dts/fsl/p1021mds.dts
similarity index 99%
rename from arch/powerpc/boot/dts/p1021mds.dts
rename to arch/powerpc/boot/dts/fsl/p1021mds.dts
index 7655904..27fdfd7 100644
--- a/arch/powerpc/boot/dts/p1021mds.dts
+++ b/arch/powerpc/boot/dts/fsl/p1021mds.dts
@@ -9,7 +9,7 @@
  * option) any later version.
  */
 
-/include/ "fsl/p1021si-pre.dtsi"
+/include/ "p1021si-pre.dtsi"
 / {
 	model = "fsl,P1021";
 	compatible = "fsl,P1021MDS";
@@ -320,4 +320,4 @@
 	};
 };
 
-/include/ "fsl/p1021si-post.dtsi"
+/include/ "p1021si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1021rdb-pc.dtsi b/arch/powerpc/boot/dts/fsl/p1021rdb-pc.dtsi
similarity index 100%
rename from arch/powerpc/boot/dts/p1021rdb-pc.dtsi
rename to arch/powerpc/boot/dts/fsl/p1021rdb-pc.dtsi
diff --git a/arch/powerpc/boot/dts/p1021rdb-pc_32b.dts b/arch/powerpc/boot/dts/fsl/p1021rdb-pc_32b.dts
similarity index 97%
rename from arch/powerpc/boot/dts/p1021rdb-pc_32b.dts
rename to arch/powerpc/boot/dts/fsl/p1021rdb-pc_32b.dts
index 7cefa12..d2b4710 100644
--- a/arch/powerpc/boot/dts/p1021rdb-pc_32b.dts
+++ b/arch/powerpc/boot/dts/fsl/p1021rdb-pc_32b.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/p1021si-pre.dtsi"
+/include/ "p1021si-pre.dtsi"
 / {
 	model = "fsl,P1021RDB";
 	compatible = "fsl,P1021RDB-PC";
@@ -93,4 +93,4 @@
 };
 
 /include/ "p1021rdb-pc.dtsi"
-/include/ "fsl/p1021si-post.dtsi"
+/include/ "p1021si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1021rdb-pc_36b.dts b/arch/powerpc/boot/dts/fsl/p1021rdb-pc_36b.dts
similarity index 97%
rename from arch/powerpc/boot/dts/p1021rdb-pc_36b.dts
rename to arch/powerpc/boot/dts/fsl/p1021rdb-pc_36b.dts
index 53d0c88..e298c29 100644
--- a/arch/powerpc/boot/dts/p1021rdb-pc_36b.dts
+++ b/arch/powerpc/boot/dts/fsl/p1021rdb-pc_36b.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/p1021si-pre.dtsi"
+/include/ "p1021si-pre.dtsi"
 / {
 	model = "fsl,P1021RDB";
 	compatible = "fsl,P1021RDB-PC";
@@ -93,4 +93,4 @@
 };
 
 /include/ "p1021rdb-pc.dtsi"
-/include/ "fsl/p1021si-post.dtsi"
+/include/ "p1021si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1022ds.dtsi b/arch/powerpc/boot/dts/fsl/p1022ds.dtsi
similarity index 100%
rename from arch/powerpc/boot/dts/p1022ds.dtsi
rename to arch/powerpc/boot/dts/fsl/p1022ds.dtsi
diff --git a/arch/powerpc/boot/dts/p1022ds_32b.dts b/arch/powerpc/boot/dts/fsl/p1022ds_32b.dts
similarity index 98%
rename from arch/powerpc/boot/dts/p1022ds_32b.dts
rename to arch/powerpc/boot/dts/fsl/p1022ds_32b.dts
index d96cae0..5a7eace 100644
--- a/arch/powerpc/boot/dts/p1022ds_32b.dts
+++ b/arch/powerpc/boot/dts/fsl/p1022ds_32b.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/p1022si-pre.dtsi"
+/include/ "p1022si-pre.dtsi"
 / {
 	model = "fsl,P1022DS";
 	compatible = "fsl,P1022DS";
@@ -99,5 +99,5 @@
 	};
 };
 
-/include/ "fsl/p1022si-post.dtsi"
+/include/ "p1022si-post.dtsi"
 /include/ "p1022ds.dtsi"
diff --git a/arch/powerpc/boot/dts/p1022ds_36b.dts b/arch/powerpc/boot/dts/fsl/p1022ds_36b.dts
similarity index 98%
rename from arch/powerpc/boot/dts/p1022ds_36b.dts
rename to arch/powerpc/boot/dts/fsl/p1022ds_36b.dts
index f7aacce..88063cd 100644
--- a/arch/powerpc/boot/dts/p1022ds_36b.dts
+++ b/arch/powerpc/boot/dts/fsl/p1022ds_36b.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/p1022si-pre.dtsi"
+/include/ "p1022si-pre.dtsi"
 / {
 	model = "fsl,P1022DS";
 	compatible = "fsl,P1022DS";
@@ -99,5 +99,5 @@
 	};
 };
 
-/include/ "fsl/p1022si-post.dtsi"
+/include/ "p1022si-post.dtsi"
 /include/ "p1022ds.dtsi"
diff --git a/arch/powerpc/boot/dts/p1022rdk.dts b/arch/powerpc/boot/dts/fsl/p1022rdk.dts
similarity index 98%
rename from arch/powerpc/boot/dts/p1022rdk.dts
rename to arch/powerpc/boot/dts/fsl/p1022rdk.dts
index 51d82de..04c1633 100644
--- a/arch/powerpc/boot/dts/p1022rdk.dts
+++ b/arch/powerpc/boot/dts/fsl/p1022rdk.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/p1022si-pre.dtsi"
+/include/ "p1022si-pre.dtsi"
 / {
 	model = "fsl,P1022RDK";
 	compatible = "fsl,P1022RDK";
@@ -185,4 +185,4 @@
 	};
 };
 
-/include/ "fsl/p1022si-post.dtsi"
+/include/ "p1022si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1023rdb.dts b/arch/powerpc/boot/dts/fsl/p1023rdb.dts
similarity index 99%
rename from arch/powerpc/boot/dts/p1023rdb.dts
rename to arch/powerpc/boot/dts/fsl/p1023rdb.dts
index 05a00a4..9716ca6 100644
--- a/arch/powerpc/boot/dts/p1023rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/p1023rdb.dts
@@ -34,7 +34,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/p1023si-pre.dtsi"
+/include/ "p1023si-pre.dtsi"
 
 / {
 	model = "fsl,P1023";
@@ -257,4 +257,4 @@
 	};
 };
 
-/include/ "fsl/p1023si-post.dtsi"
+/include/ "p1023si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1024rdb.dtsi b/arch/powerpc/boot/dts/fsl/p1024rdb.dtsi
similarity index 100%
rename from arch/powerpc/boot/dts/p1024rdb.dtsi
rename to arch/powerpc/boot/dts/fsl/p1024rdb.dtsi
diff --git a/arch/powerpc/boot/dts/p1024rdb_32b.dts b/arch/powerpc/boot/dts/fsl/p1024rdb_32b.dts
similarity index 97%
rename from arch/powerpc/boot/dts/p1024rdb_32b.dts
rename to arch/powerpc/boot/dts/fsl/p1024rdb_32b.dts
index 90e803e..8b09b9d 100644
--- a/arch/powerpc/boot/dts/p1024rdb_32b.dts
+++ b/arch/powerpc/boot/dts/fsl/p1024rdb_32b.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/p1020si-pre.dtsi"
+/include/ "p1020si-pre.dtsi"
 / {
 	model = "fsl,P1024RDB";
 	compatible = "fsl,P1024RDB";
@@ -84,4 +84,4 @@
 };
 
 /include/ "p1024rdb.dtsi"
-/include/ "fsl/p1020si-post.dtsi"
+/include/ "p1020si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1024rdb_36b.dts b/arch/powerpc/boot/dts/fsl/p1024rdb_36b.dts
similarity index 97%
rename from arch/powerpc/boot/dts/p1024rdb_36b.dts
rename to arch/powerpc/boot/dts/fsl/p1024rdb_36b.dts
index 3656825..e7093ae 100644
--- a/arch/powerpc/boot/dts/p1024rdb_36b.dts
+++ b/arch/powerpc/boot/dts/fsl/p1024rdb_36b.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/p1020si-pre.dtsi"
+/include/ "p1020si-pre.dtsi"
 / {
 	model = "fsl,P1024RDB";
 	compatible = "fsl,P1024RDB";
@@ -84,4 +84,4 @@
 };
 
 /include/ "p1024rdb.dtsi"
-/include/ "fsl/p1020si-post.dtsi"
+/include/ "p1020si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1025rdb.dtsi b/arch/powerpc/boot/dts/fsl/p1025rdb.dtsi
similarity index 100%
rename from arch/powerpc/boot/dts/p1025rdb.dtsi
rename to arch/powerpc/boot/dts/fsl/p1025rdb.dtsi
diff --git a/arch/powerpc/boot/dts/p1025rdb_32b.dts b/arch/powerpc/boot/dts/fsl/p1025rdb_32b.dts
similarity index 98%
rename from arch/powerpc/boot/dts/p1025rdb_32b.dts
rename to arch/powerpc/boot/dts/fsl/p1025rdb_32b.dts
index a2ed628..b15acba 100644
--- a/arch/powerpc/boot/dts/p1025rdb_32b.dts
+++ b/arch/powerpc/boot/dts/fsl/p1025rdb_32b.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/p1021si-pre.dtsi"
+/include/ "p1021si-pre.dtsi"
 / {
 	model = "fsl,P1025RDB";
 	compatible = "fsl,P1025RDB";
@@ -130,4 +130,4 @@
 };
 
 /include/ "p1025rdb.dtsi"
-/include/ "fsl/p1021si-post.dtsi"
+/include/ "p1021si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1025rdb_36b.dts b/arch/powerpc/boot/dts/fsl/p1025rdb_36b.dts
similarity index 97%
rename from arch/powerpc/boot/dts/p1025rdb_36b.dts
rename to arch/powerpc/boot/dts/fsl/p1025rdb_36b.dts
index 06deb6f..b0ded5e 100644
--- a/arch/powerpc/boot/dts/p1025rdb_36b.dts
+++ b/arch/powerpc/boot/dts/fsl/p1025rdb_36b.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/p1021si-pre.dtsi"
+/include/ "p1021si-pre.dtsi"
 / {
 	model = "fsl,P1025RDB";
 	compatible = "fsl,P1025RDB";
@@ -90,4 +90,4 @@
 };
 
 /include/ "p1025rdb.dtsi"
-/include/ "fsl/p1021si-post.dtsi"
+/include/ "p1021si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1025twr.dts b/arch/powerpc/boot/dts/fsl/p1025twr.dts
similarity index 97%
rename from arch/powerpc/boot/dts/p1025twr.dts
rename to arch/powerpc/boot/dts/fsl/p1025twr.dts
index 9036a49..9b8863b 100644
--- a/arch/powerpc/boot/dts/p1025twr.dts
+++ b/arch/powerpc/boot/dts/fsl/p1025twr.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/p1021si-pre.dtsi"
+/include/ "p1021si-pre.dtsi"
 / {
 	model = "fsl,P1025";
 	compatible = "fsl,TWR-P1025";
@@ -92,4 +92,4 @@
 };
 
 /include/ "p1025twr.dtsi"
-/include/ "fsl/p1021si-post.dtsi"
+/include/ "p1021si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1025twr.dtsi b/arch/powerpc/boot/dts/fsl/p1025twr.dtsi
similarity index 100%
rename from arch/powerpc/boot/dts/p1025twr.dtsi
rename to arch/powerpc/boot/dts/fsl/p1025twr.dtsi
diff --git a/arch/powerpc/boot/dts/p2020ds.dts b/arch/powerpc/boot/dts/fsl/p2020ds.dts
similarity index 96%
rename from arch/powerpc/boot/dts/p2020ds.dts
rename to arch/powerpc/boot/dts/fsl/p2020ds.dts
index 237310c..5ba06f7 100644
--- a/arch/powerpc/boot/dts/p2020ds.dts
+++ b/arch/powerpc/boot/dts/fsl/p2020ds.dts
@@ -9,7 +9,7 @@
  * option) any later version.
  */
 
-/include/ "fsl/p2020si-pre.dtsi"
+/include/ "p2020si-pre.dtsi"
 
 / {
 	model = "fsl,P2020DS";
@@ -85,5 +85,5 @@
  * for interrupt-map & interrupt-map-mask
  */
 
-/include/ "fsl/p2020si-post.dtsi"
+/include/ "p2020si-post.dtsi"
 /include/ "p2020ds.dtsi"
diff --git a/arch/powerpc/boot/dts/p2020ds.dtsi b/arch/powerpc/boot/dts/fsl/p2020ds.dtsi
similarity index 100%
rename from arch/powerpc/boot/dts/p2020ds.dtsi
rename to arch/powerpc/boot/dts/fsl/p2020ds.dtsi
diff --git a/arch/powerpc/boot/dts/p2020rdb-pc.dtsi b/arch/powerpc/boot/dts/fsl/p2020rdb-pc.dtsi
similarity index 100%
rename from arch/powerpc/boot/dts/p2020rdb-pc.dtsi
rename to arch/powerpc/boot/dts/fsl/p2020rdb-pc.dtsi
diff --git a/arch/powerpc/boot/dts/p2020rdb-pc_32b.dts b/arch/powerpc/boot/dts/fsl/p2020rdb-pc_32b.dts
similarity index 97%
rename from arch/powerpc/boot/dts/p2020rdb-pc_32b.dts
rename to arch/powerpc/boot/dts/fsl/p2020rdb-pc_32b.dts
index 57573bd..d3295c2 100644
--- a/arch/powerpc/boot/dts/p2020rdb-pc_32b.dts
+++ b/arch/powerpc/boot/dts/fsl/p2020rdb-pc_32b.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/p2020si-pre.dtsi"
+/include/ "p2020si-pre.dtsi"
 
 / {
 	model = "fsl,P2020RDB";
@@ -93,4 +93,4 @@
 };
 
 /include/ "p2020rdb-pc.dtsi"
-/include/ "fsl/p2020si-post.dtsi"
+/include/ "p2020si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p2020rdb-pc_36b.dts b/arch/powerpc/boot/dts/fsl/p2020rdb-pc_36b.dts
similarity index 97%
rename from arch/powerpc/boot/dts/p2020rdb-pc_36b.dts
rename to arch/powerpc/boot/dts/fsl/p2020rdb-pc_36b.dts
index 470247e..9307a8f4 100644
--- a/arch/powerpc/boot/dts/p2020rdb-pc_36b.dts
+++ b/arch/powerpc/boot/dts/fsl/p2020rdb-pc_36b.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/p2020si-pre.dtsi"
+/include/ "p2020si-pre.dtsi"
 
 / {
 	model = "fsl,P2020RDB";
@@ -93,4 +93,4 @@
 };
 
 /include/ "p2020rdb-pc.dtsi"
-/include/ "fsl/p2020si-post.dtsi"
+/include/ "p2020si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p2020rdb.dts b/arch/powerpc/boot/dts/fsl/p2020rdb.dts
similarity index 98%
rename from arch/powerpc/boot/dts/p2020rdb.dts
rename to arch/powerpc/boot/dts/fsl/p2020rdb.dts
index 4d52bce..70cf090 100644
--- a/arch/powerpc/boot/dts/p2020rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/p2020rdb.dts
@@ -9,7 +9,7 @@
  * option) any later version.
  */
 
-/include/ "fsl/p2020si-pre.dtsi"
+/include/ "p2020si-pre.dtsi"
 
 / {
 	model = "fsl,P2020RDB";
@@ -288,4 +288,4 @@
 	};
 };
 
-/include/ "fsl/p2020si-post.dtsi"
+/include/ "p2020si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p2041rdb.dts b/arch/powerpc/boot/dts/fsl/p2041rdb.dts
similarity index 98%
rename from arch/powerpc/boot/dts/p2041rdb.dts
rename to arch/powerpc/boot/dts/fsl/p2041rdb.dts
index d2bb0765..e9bd894 100644
--- a/arch/powerpc/boot/dts/p2041rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/p2041rdb.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/p2041si-pre.dtsi"
+/include/ "p2041si-pre.dtsi"
 
 / {
 	model = "fsl,P2041RDB";
@@ -247,4 +247,4 @@
 	};
 };
 
-/include/ "fsl/p2041si-post.dtsi"
+/include/ "p2041si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p3041ds.dts b/arch/powerpc/boot/dts/fsl/p3041ds.dts
similarity index 99%
rename from arch/powerpc/boot/dts/p3041ds.dts
rename to arch/powerpc/boot/dts/fsl/p3041ds.dts
index eca6c69..f2b1d40 100644
--- a/arch/powerpc/boot/dts/p3041ds.dts
+++ b/arch/powerpc/boot/dts/fsl/p3041ds.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/p3041si-pre.dtsi"
+/include/ "p3041si-pre.dtsi"
 
 / {
 	model = "fsl,P3041DS";
@@ -281,4 +281,4 @@
 	};
 };
 
-/include/ "fsl/p3041si-post.dtsi"
+/include/ "p3041si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p4080ds.dts b/arch/powerpc/boot/dts/fsl/p4080ds.dts
similarity index 98%
rename from arch/powerpc/boot/dts/p4080ds.dts
rename to arch/powerpc/boot/dts/fsl/p4080ds.dts
index 4f80c9d..28a55c5 100644
--- a/arch/powerpc/boot/dts/p4080ds.dts
+++ b/arch/powerpc/boot/dts/fsl/p4080ds.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/p4080si-pre.dtsi"
+/include/ "p4080si-pre.dtsi"
 
 / {
 	model = "fsl,P4080DS";
@@ -215,4 +215,4 @@
 
 };
 
-/include/ "fsl/p4080si-post.dtsi"
+/include/ "p4080si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p5020ds.dts b/arch/powerpc/boot/dts/fsl/p5020ds.dts
similarity index 99%
rename from arch/powerpc/boot/dts/p5020ds.dts
rename to arch/powerpc/boot/dts/fsl/p5020ds.dts
index d0309a8..920dc77 100644
--- a/arch/powerpc/boot/dts/p5020ds.dts
+++ b/arch/powerpc/boot/dts/fsl/p5020ds.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/p5020si-pre.dtsi"
+/include/ "p5020si-pre.dtsi"
 
 / {
 	model = "fsl,P5020DS";
@@ -281,4 +281,4 @@
 	};
 };
 
-/include/ "fsl/p5020si-post.dtsi"
+/include/ "p5020si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p5040ds.dts b/arch/powerpc/boot/dts/fsl/p5040ds.dts
similarity index 98%
rename from arch/powerpc/boot/dts/p5040ds.dts
rename to arch/powerpc/boot/dts/fsl/p5040ds.dts
index 0516823..e169cc2 100644
--- a/arch/powerpc/boot/dts/p5040ds.dts
+++ b/arch/powerpc/boot/dts/fsl/p5040ds.dts
@@ -32,7 +32,7 @@
  * software, even if advised of the possibility of such damage.
  */
 
-/include/ "fsl/p5040si-pre.dtsi"
+/include/ "p5040si-pre.dtsi"
 
 / {
 	model = "fsl,P5040DS";
@@ -251,4 +251,4 @@
 	};
 };
 
-/include/ "fsl/p5040si-post.dtsi"
+/include/ "p5040si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/ppa8548.dts b/arch/powerpc/boot/dts/fsl/ppa8548.dts
similarity index 97%
rename from arch/powerpc/boot/dts/ppa8548.dts
rename to arch/powerpc/boot/dts/fsl/ppa8548.dts
index 27b0699..8f9ffbe 100644
--- a/arch/powerpc/boot/dts/ppa8548.dts
+++ b/arch/powerpc/boot/dts/fsl/ppa8548.dts
@@ -12,7 +12,7 @@
  * option) any later version.
  */
 
-/include/ "fsl/mpc8548si-pre.dtsi"
+/include/ "mpc8548si-pre.dtsi"
 
 / {
 	model = "ppa8548";
@@ -161,4 +161,4 @@
 	};
 };
 
-/include/ "fsl/mpc8548si-post.dtsi"
+/include/ "mpc8548si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/t1023rdb.dts b/arch/powerpc/boot/dts/fsl/t1023rdb.dts
similarity index 98%
rename from arch/powerpc/boot/dts/t1023rdb.dts
rename to arch/powerpc/boot/dts/fsl/t1023rdb.dts
index d3fa829..2b2fff4 100644
--- a/arch/powerpc/boot/dts/t1023rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t1023rdb.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/t102xsi-pre.dtsi"
+/include/ "t102xsi-pre.dtsi"
 
 / {
 	model = "fsl,T1023RDB";
@@ -159,4 +159,4 @@
 	};
 };
 
-/include/ "fsl/t1023si-post.dtsi"
+/include/ "t1023si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/t1024qds.dts b/arch/powerpc/boot/dts/fsl/t1024qds.dts
similarity index 98%
rename from arch/powerpc/boot/dts/t1024qds.dts
rename to arch/powerpc/boot/dts/fsl/t1024qds.dts
index f31fabb..43cd5b5 100644
--- a/arch/powerpc/boot/dts/t1024qds.dts
+++ b/arch/powerpc/boot/dts/fsl/t1024qds.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/t102xsi-pre.dtsi"
+/include/ "t102xsi-pre.dtsi"
 
 / {
 	model = "fsl,T1024QDS";
@@ -248,4 +248,4 @@
 	};
 };
 
-/include/ "fsl/t1024si-post.dtsi"
+/include/ "t1024si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/t1024rdb.dts b/arch/powerpc/boot/dts/fsl/t1024rdb.dts
similarity index 98%
rename from arch/powerpc/boot/dts/t1024rdb.dts
rename to arch/powerpc/boot/dts/fsl/t1024rdb.dts
index bf05e32..429d8c7 100644
--- a/arch/powerpc/boot/dts/t1024rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t1024rdb.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/t102xsi-pre.dtsi"
+/include/ "t102xsi-pre.dtsi"
 
 / {
 	model = "fsl,T1024RDB";
@@ -188,4 +188,4 @@
 	};
 };
 
-/include/ "fsl/t1024si-post.dtsi"
+/include/ "t1024si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/t1040d4rdb.dts b/arch/powerpc/boot/dts/fsl/t1040d4rdb.dts
similarity index 96%
rename from arch/powerpc/boot/dts/t1040d4rdb.dts
rename to arch/powerpc/boot/dts/fsl/t1040d4rdb.dts
index 2d1315a..681746e 100644
--- a/arch/powerpc/boot/dts/t1040d4rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t1040d4rdb.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/t104xsi-pre.dtsi"
+/include/ "t104xsi-pre.dtsi"
 /include/ "t104xd4rdb.dtsi"
 
 / {
@@ -43,4 +43,4 @@
 	interrupt-parent = <&mpic>;
 };
 
-/include/ "fsl/t1040si-post.dtsi"
+/include/ "t1040si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/t1040qds.dts b/arch/powerpc/boot/dts/fsl/t1040qds.dts
similarity index 96%
rename from arch/powerpc/boot/dts/t1040qds.dts
rename to arch/powerpc/boot/dts/fsl/t1040qds.dts
index 973c29c..4d29865 100644
--- a/arch/powerpc/boot/dts/t1040qds.dts
+++ b/arch/powerpc/boot/dts/fsl/t1040qds.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/t104xsi-pre.dtsi"
+/include/ "t104xsi-pre.dtsi"
 /include/ "t104xqds.dtsi"
 
 / {
@@ -43,4 +43,4 @@
 	interrupt-parent = <&mpic>;
 };
 
-/include/ "fsl/t1040si-post.dtsi"
+/include/ "t1040si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/t1040rdb.dts b/arch/powerpc/boot/dts/fsl/t1040rdb.dts
similarity index 96%
rename from arch/powerpc/boot/dts/t1040rdb.dts
rename to arch/powerpc/boot/dts/fsl/t1040rdb.dts
index 79a0bed..8f9e65b 100644
--- a/arch/powerpc/boot/dts/t1040rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t1040rdb.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/t104xsi-pre.dtsi"
+/include/ "t104xsi-pre.dtsi"
 /include/ "t104xrdb.dtsi"
 
 / {
@@ -45,4 +45,4 @@
 	};
 };
 
-/include/ "fsl/t1040si-post.dtsi"
+/include/ "t1040si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/t1042d4rdb.dts b/arch/powerpc/boot/dts/fsl/t1042d4rdb.dts
similarity index 96%
rename from arch/powerpc/boot/dts/t1042d4rdb.dts
rename to arch/powerpc/boot/dts/fsl/t1042d4rdb.dts
index 846f8c8..b245b31 100644
--- a/arch/powerpc/boot/dts/t1042d4rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t1042d4rdb.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/t104xsi-pre.dtsi"
+/include/ "t104xsi-pre.dtsi"
 /include/ "t104xd4rdb.dtsi"
 
 / {
@@ -50,4 +50,4 @@
 	};
 };
 
-/include/ "fsl/t1040si-post.dtsi"
+/include/ "t1040si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/t1042qds.dts b/arch/powerpc/boot/dts/fsl/t1042qds.dts
similarity index 96%
rename from arch/powerpc/boot/dts/t1042qds.dts
rename to arch/powerpc/boot/dts/fsl/t1042qds.dts
index 45bd037..4ab9bbe 100644
--- a/arch/powerpc/boot/dts/t1042qds.dts
+++ b/arch/powerpc/boot/dts/fsl/t1042qds.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/t104xsi-pre.dtsi"
+/include/ "t104xsi-pre.dtsi"
 /include/ "t104xqds.dtsi"
 
 / {
@@ -43,4 +43,4 @@
 	interrupt-parent = <&mpic>;
 };
 
-/include/ "fsl/t1042si-post.dtsi"
+/include/ "t1042si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/t1042rdb.dts b/arch/powerpc/boot/dts/fsl/t1042rdb.dts
similarity index 96%
rename from arch/powerpc/boot/dts/t1042rdb.dts
rename to arch/powerpc/boot/dts/fsl/t1042rdb.dts
index 738c237..67af56b 100644
--- a/arch/powerpc/boot/dts/t1042rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t1042rdb.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/t104xsi-pre.dtsi"
+/include/ "t104xsi-pre.dtsi"
 /include/ "t104xrdb.dtsi"
 
 / {
@@ -45,4 +45,4 @@
 	};
 };
 
-/include/ "fsl/t1042si-post.dtsi"
+/include/ "t1042si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/t1042rdb_pi.dts b/arch/powerpc/boot/dts/fsl/t1042rdb_pi.dts
similarity index 96%
rename from arch/powerpc/boot/dts/t1042rdb_pi.dts
rename to arch/powerpc/boot/dts/fsl/t1042rdb_pi.dts
index 634f751..2f67677 100644
--- a/arch/powerpc/boot/dts/t1042rdb_pi.dts
+++ b/arch/powerpc/boot/dts/fsl/t1042rdb_pi.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/t104xsi-pre.dtsi"
+/include/ "t104xsi-pre.dtsi"
 /include/ "t104xrdb.dtsi"
 
 / {
@@ -54,4 +54,4 @@
 	};
 };
 
-/include/ "fsl/t1042si-post.dtsi"
+/include/ "t1042si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/t104xd4rdb.dtsi b/arch/powerpc/boot/dts/fsl/t104xd4rdb.dtsi
similarity index 100%
rename from arch/powerpc/boot/dts/t104xd4rdb.dtsi
rename to arch/powerpc/boot/dts/fsl/t104xd4rdb.dtsi
diff --git a/arch/powerpc/boot/dts/t104xqds.dtsi b/arch/powerpc/boot/dts/fsl/t104xqds.dtsi
similarity index 100%
rename from arch/powerpc/boot/dts/t104xqds.dtsi
rename to arch/powerpc/boot/dts/fsl/t104xqds.dtsi
diff --git a/arch/powerpc/boot/dts/t104xrdb.dtsi b/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi
similarity index 100%
rename from arch/powerpc/boot/dts/t104xrdb.dtsi
rename to arch/powerpc/boot/dts/fsl/t104xrdb.dtsi
diff --git a/arch/powerpc/boot/dts/t2080qds.dts b/arch/powerpc/boot/dts/fsl/t2080qds.dts
similarity index 96%
rename from arch/powerpc/boot/dts/t2080qds.dts
rename to arch/powerpc/boot/dts/fsl/t2080qds.dts
index aa1d6d8..9c8e10f 100644
--- a/arch/powerpc/boot/dts/t2080qds.dts
+++ b/arch/powerpc/boot/dts/fsl/t2080qds.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/t208xsi-pre.dtsi"
+/include/ "t208xsi-pre.dtsi"
 /include/ "t208xqds.dtsi"
 
 / {
@@ -54,4 +54,4 @@
 	};
 };
 
-/include/ "fsl/t2080si-post.dtsi"
+/include/ "t2080si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/t2080rdb.dts b/arch/powerpc/boot/dts/fsl/t2080rdb.dts
similarity index 97%
rename from arch/powerpc/boot/dts/t2080rdb.dts
rename to arch/powerpc/boot/dts/fsl/t2080rdb.dts
index e889104..33205bf 100644
--- a/arch/powerpc/boot/dts/t2080rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t2080rdb.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/t208xsi-pre.dtsi"
+/include/ "t208xsi-pre.dtsi"
 /include/ "t208xrdb.dtsi"
 
 / {
@@ -54,4 +54,4 @@
 	};
 };
 
-/include/ "fsl/t2080si-post.dtsi"
+/include/ "t2080si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/t2081qds.dts b/arch/powerpc/boot/dts/fsl/t2081qds.dts
similarity index 96%
rename from arch/powerpc/boot/dts/t2081qds.dts
rename to arch/powerpc/boot/dts/fsl/t2081qds.dts
index 8ec80a7..b812135 100644
--- a/arch/powerpc/boot/dts/t2081qds.dts
+++ b/arch/powerpc/boot/dts/fsl/t2081qds.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/t208xsi-pre.dtsi"
+/include/ "t208xsi-pre.dtsi"
 /include/ "t208xqds.dtsi"
 
 / {
@@ -43,4 +43,4 @@
 	interrupt-parent = <&mpic>;
 };
 
-/include/ "fsl/t2081si-post.dtsi"
+/include/ "t2081si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/t208xqds.dtsi b/arch/powerpc/boot/dts/fsl/t208xqds.dtsi
similarity index 100%
rename from arch/powerpc/boot/dts/t208xqds.dtsi
rename to arch/powerpc/boot/dts/fsl/t208xqds.dtsi
diff --git a/arch/powerpc/boot/dts/t208xrdb.dtsi b/arch/powerpc/boot/dts/fsl/t208xrdb.dtsi
similarity index 100%
rename from arch/powerpc/boot/dts/t208xrdb.dtsi
rename to arch/powerpc/boot/dts/fsl/t208xrdb.dtsi
diff --git a/arch/powerpc/boot/dts/t4240qds.dts b/arch/powerpc/boot/dts/fsl/t4240qds.dts
similarity index 99%
rename from arch/powerpc/boot/dts/t4240qds.dts
rename to arch/powerpc/boot/dts/fsl/t4240qds.dts
index 93722da..c067a65 100644
--- a/arch/powerpc/boot/dts/t4240qds.dts
+++ b/arch/powerpc/boot/dts/fsl/t4240qds.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/t4240si-pre.dtsi"
+/include/ "t4240si-pre.dtsi"
 
 / {
 	model = "fsl,T4240QDS";
@@ -307,4 +307,4 @@
 	};
 };
 
-/include/ "fsl/t4240si-post.dtsi"
+/include/ "t4240si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/t4240rdb.dts b/arch/powerpc/boot/dts/fsl/t4240rdb.dts
similarity index 98%
rename from arch/powerpc/boot/dts/t4240rdb.dts
rename to arch/powerpc/boot/dts/fsl/t4240rdb.dts
index 993eb4b..6e820a8 100644
--- a/arch/powerpc/boot/dts/t4240rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t4240rdb.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "fsl/t4240si-pre.dtsi"
+/include/ "t4240si-pre.dtsi"
 
 / {
 	model = "fsl,T4240RDB";
@@ -210,4 +210,4 @@
 	};
 };
 
-/include/ "fsl/t4240si-post.dtsi"
+/include/ "t4240si-post.dtsi"
-- 
2.1.0.27.g96db324
