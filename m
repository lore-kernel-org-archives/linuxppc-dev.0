Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTyK74sslzDvyl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2016 00:08:43 +1100 (AEDT)
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tTyK66rJCz9t9b
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2016 00:08:42 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id 144so11960459pfv.0
 for <linuxppc-dev@ozlabs.org>; Thu, 01 Dec 2016 05:08:42 -0800 (PST)
To: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH][DOC] ppc/idle: Add documentation for powersave=off
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <9d2bef9b-1df5-fb84-870e-14572ef0ea40@gmail.com>
Date: Fri, 2 Dec 2016 00:08:26 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Update kernel-parameters.txt to add Documentation
for powersave=off.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 Applies of top of linux-next 20161201

 Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0a178fc..be2d6d0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3051,6 +3051,12 @@
 			may be specified.
 			Format: <port>,<port>....
 
+	powersave=off	[PPC] This option disables power saving features.
+			It specifically disables cpuidle and sets the
+			platform machine description specific power_save
+			function to NULL. On Idle the CPU just reduces
+			execution priority.
+
 	ppc_strict_facility_enable
 			[PPC] This option catches any kernel floating point,
 			Altivec, VSX and SPE outside of regions specifically
-- 
2.9.3
