Date: Thu, 11 Dec 2003 17:20:11 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: fixup G4 iBook's /proc/cpuinfo
Message-ID: <20031211162011.GD913@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9dgjiU4MmWPVapMU"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--9dgjiU4MmWPVapMU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
this little patch lets the G4 iBook 12" actually look like one in
/proc/cpuinfo. It's against the current 2.4 benh rsync tree. A 2.6
version is also attached.

--- ../benh-rsync-clean/arch/ppc/platforms/pmac_feature.c	2003-10-08 15:16:42.000000000 +0200
+++ arch/ppc/platforms/pmac_feature.c	2003-12-11 16:21:39.000000000 +0100
@@ -2007,6 +2022,10 @@
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
 		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
 	},
+	{	"PowerBook6,3",			"iBook G4 12\"",
+		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
+		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+	},
 	{	"PowerMac7,2",			"PowerMac G5",
 		PMAC_TYPE_POWERMAC_G5,		g5_features,
 		0,

Cheers,
 -- Guido

--9dgjiU4MmWPVapMU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="g4-ibook-detect-model-2.6.diff"

--- arch/ppc/platforms/pmac_feature.c.orig	2003-12-11 17:17:09.000000000 +0100
+++ arch/ppc/platforms/pmac_feature.c	2003-12-11 17:18:15.000000000 +0100
@@ -2119,6 +2119,10 @@
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
 		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
 	},
+	{	"PowerBook6,3",			"iBook G4 12\"",
+		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
+		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+	},
 #else /* CONFIG_POWER4 */
 	{	"PowerMac7,2",			"PowerMac G5",
 		PMAC_TYPE_POWERMAC_G5,		g5_features,

--9dgjiU4MmWPVapMU--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
