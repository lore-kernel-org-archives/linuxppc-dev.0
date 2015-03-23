Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0138.outbound.protection.outlook.com [207.46.100.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 186461A2B62
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 10:23:24 +1100 (AEDT)
Message-ID: <1427152990.22867.18.camel@freescale.com>
Subject: Re: [v7 2/2] powerpc/mpc85xx: Add FSL QorIQ DPAA QMan support to
 device tree(s)
From: Scott Wood <scottwood@freescale.com>
To: Emil Medve <Emilian.Medve@Freescale.com>
Date: Mon, 23 Mar 2015 18:23:10 -0500
In-Reply-To: <1425050175-9316-2-git-send-email-Emilian.Medve@Freescale.com>
References: <1425050175-9316-1-git-send-email-Emilian.Medve@Freescale.com>
 <1425050175-9316-2-git-send-email-Emilian.Medve@Freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Poonam Aggrwal <poonam.aggrwal@Freescale.com>,
 Geoff Thorpe <Geoff.Thorpe@Freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Chunhe Lan <Chunhe.Lan@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-02-27 at 09:16 -0600, Emil Medve wrote:
> From: Kumar Gala <galak@kernel.crashing.org>
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> Signed-off-by: Geoff Thorpe <Geoff.Thorpe@freescale.com>
> Signed-off-by: Hai-Ying Wang <Haiying.Wang@freescale.com>
> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> [Emil Medve: Sync with the upstream binding]
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
> ---
> 
> v7:	Remove 'Change-Id'
> 
> v6:	Rebase

ERROR: code indent should use tabs where possible
#1159: FILE: arch/powerpc/boot/dts/kmcoge4.dts:37:
+                qman_fqd: qman-fqd {$

ERROR: code indent should use tabs where possible
#1160: FILE: arch/powerpc/boot/dts/kmcoge4.dts:38:
+                        size = <0 0x400000>;$

WARNING: please, no spaces at the start of a line
#1160: FILE: arch/powerpc/boot/dts/kmcoge4.dts:38:
+                        size = <0 0x400000>;$

ERROR: code indent should use tabs where possible
#1161: FILE: arch/powerpc/boot/dts/kmcoge4.dts:39:
+                        alignment = <0 0x400000>;$

WARNING: please, no spaces at the start of a line
#1161: FILE: arch/powerpc/boot/dts/kmcoge4.dts:39:
+                        alignment = <0 0x400000>;$

ERROR: code indent should use tabs where possible
#1162: FILE: arch/powerpc/boot/dts/kmcoge4.dts:40:
+                };$

WARNING: please, no spaces at the start of a line
#1162: FILE: arch/powerpc/boot/dts/kmcoge4.dts:40:
+                };$

ERROR: code indent should use tabs where possible
#1163: FILE: arch/powerpc/boot/dts/kmcoge4.dts:41:
+                qman_pfdr: qman-pfdr {$

ERROR: code indent should use tabs where possible
#1164: FILE: arch/powerpc/boot/dts/kmcoge4.dts:42:
+                        size = <0 0x2000000>;$

WARNING: please, no spaces at the start of a line
#1164: FILE: arch/powerpc/boot/dts/kmcoge4.dts:42:
+                        size = <0 0x2000000>;$

ERROR: code indent should use tabs where possible
#1165: FILE: arch/powerpc/boot/dts/kmcoge4.dts:43:
+                        alignment = <0 0x2000000>;$

WARNING: please, no spaces at the start of a line
#1165: FILE: arch/powerpc/boot/dts/kmcoge4.dts:43:
+                        alignment = <0 0x2000000>;$

ERROR: code indent should use tabs where possible
#1166: FILE: arch/powerpc/boot/dts/kmcoge4.dts:44:
+                };$

WARNING: please, no spaces at the start of a line
#1166: FILE: arch/powerpc/boot/dts/kmcoge4.dts:44:
+                };$

ERROR: code indent should use tabs where possible
#1189: FILE: arch/powerpc/boot/dts/oca4080.dts:61:
+                qman_fqd: qman-fqd {$

ERROR: code indent should use tabs where possible
#1190: FILE: arch/powerpc/boot/dts/oca4080.dts:62:
+                        size = <0 0x400000>;$

WARNING: please, no spaces at the start of a line
#1190: FILE: arch/powerpc/boot/dts/oca4080.dts:62:
+                        size = <0 0x400000>;$

ERROR: code indent should use tabs where possible
#1191: FILE: arch/powerpc/boot/dts/oca4080.dts:63:
+                        alignment = <0 0x400000>;$

WARNING: please, no spaces at the start of a line
#1191: FILE: arch/powerpc/boot/dts/oca4080.dts:63:
+                        alignment = <0 0x400000>;$

ERROR: code indent should use tabs where possible
#1192: FILE: arch/powerpc/boot/dts/oca4080.dts:64:
+                };$

WARNING: please, no spaces at the start of a line
#1192: FILE: arch/powerpc/boot/dts/oca4080.dts:64:
+                };$

ERROR: code indent should use tabs where possible
#1193: FILE: arch/powerpc/boot/dts/oca4080.dts:65:
+                qman_pfdr: qman-pfdr {$

ERROR: code indent should use tabs where possible
#1194: FILE: arch/powerpc/boot/dts/oca4080.dts:66:
+                        size = <0 0x2000000>;$

WARNING: please, no spaces at the start of a line
#1194: FILE: arch/powerpc/boot/dts/oca4080.dts:66:
+                        size = <0 0x2000000>;$

ERROR: code indent should use tabs where possible
#1195: FILE: arch/powerpc/boot/dts/oca4080.dts:67:
+                        alignment = <0 0x2000000>;$

WARNING: please, no spaces at the start of a line
#1195: FILE: arch/powerpc/boot/dts/oca4080.dts:67:
+                        alignment = <0 0x2000000>;$

ERROR: code indent should use tabs where possible
#1196: FILE: arch/powerpc/boot/dts/oca4080.dts:68:
+                };$

WARNING: please, no spaces at the start of a line
#1196: FILE: arch/powerpc/boot/dts/oca4080.dts:68:
+                };$

ERROR: code indent should use tabs where possible
#1542: FILE: arch/powerpc/boot/dts/t4240rdb.dts:81:
+                qman_fqd: qman-fqd {$

ERROR: code indent should use tabs where possible
#1543: FILE: arch/powerpc/boot/dts/t4240rdb.dts:82:
+                        size = <0 0x400000>;$

WARNING: please, no spaces at the start of a line
#1543: FILE: arch/powerpc/boot/dts/t4240rdb.dts:82:
+                        size = <0 0x400000>;$

ERROR: code indent should use tabs where possible
#1544: FILE: arch/powerpc/boot/dts/t4240rdb.dts:83:
+                        alignment = <0 0x400000>;$

WARNING: please, no spaces at the start of a line
#1544: FILE: arch/powerpc/boot/dts/t4240rdb.dts:83:
+                        alignment = <0 0x400000>;$

ERROR: code indent should use tabs where possible
#1545: FILE: arch/powerpc/boot/dts/t4240rdb.dts:84:
+                };$

WARNING: please, no spaces at the start of a line
#1545: FILE: arch/powerpc/boot/dts/t4240rdb.dts:84:
+                };$

ERROR: code indent should use tabs where possible
#1546: FILE: arch/powerpc/boot/dts/t4240rdb.dts:85:
+                qman_pfdr: qman-pfdr {$

ERROR: code indent should use tabs where possible
#1547: FILE: arch/powerpc/boot/dts/t4240rdb.dts:86:
+                        size = <0 0x2000000>;$

WARNING: please, no spaces at the start of a line
#1547: FILE: arch/powerpc/boot/dts/t4240rdb.dts:86:
+                        size = <0 0x2000000>;$

ERROR: code indent should use tabs where possible
#1548: FILE: arch/powerpc/boot/dts/t4240rdb.dts:87:
+                        alignment = <0 0x2000000>;$

WARNING: please, no spaces at the start of a line
#1548: FILE: arch/powerpc/boot/dts/t4240rdb.dts:87:
+                        alignment = <0 0x2000000>;$

ERROR: code indent should use tabs where possible
#1549: FILE: arch/powerpc/boot/dts/t4240rdb.dts:88:
+                };$

WARNING: please, no spaces at the start of a line
#1549: FILE: arch/powerpc/boot/dts/t4240rdb.dts:88:
+                };$

total: 24 errors, 18 warnings, 1340 lines checked

NOTE: whitespace errors detected, you may wish to use scripts/cleanpatch or
      scripts/cleanfile

v7-2-2-powerpc-mpc85xx-Add-FSL-QorIQ-DPAA-QMan-support-to-device-tree-s.patch has style problems, please review.

If any of these errors are false positives, please report
them to the maintainer, see CHECKPATCH in MAINTAINERS.

-Scott
