Return-Path: <glikely@gmail.com>
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.197])
	by ozlabs.org (Postfix) with ESMTP id CED0F679EA
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Mar 2006 10:07:32 +1100 (EST)
Received: by nproxy.gmail.com with SMTP id p48so234839nfa
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 08 Mar 2006 15:07:30 -0800 (PST)
Message-ID: <528646bc0603081507t24c7e2f5u8e2823931200a857@mail.gmail.com>
Date: Wed, 8 Mar 2006 16:07:30 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "linuxppc-embedded list" <linuxppc-embedded@ozlabs.org>,
	"Matt Porter" <mporter@kernel.crashing.org>,
	"Paul Mackerras" <paulus@samba.org>
Subject: [Patch] Fix compile error for ML300/403
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Fix compile error due to changes in ppc_sys.c.  This is needed in the
powerpc.git tree

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

---
commit 75ec8a6ff8410c30f459e5e1c924ce811f8b1e25
tree 87f29c44458d2966bf208f9ea25432b26faa2eb5
parent 126dddf2535520cbeafb7069ce092b80beb8558a
author Grant Likely <grant.likely@secretlab.ca> Wed, 08 Mar 2006 16:03:56 -=
0700
committer <grant@weasley-twins.(none)> Wed, 08 Mar 2006 16:03:56 -0700

 arch/ppc/platforms/4xx/virtex.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/ppc/platforms/4xx/virtex.h b/arch/ppc/platforms/4xx/virte=
x.h
index 2a2a65c..4d893ef 100644
--- a/arch/ppc/platforms/4xx/virtex.h
+++ b/arch/ppc/platforms/4xx/virtex.h
@@ -27,7 +27,7 @@
 /* Device type enumeration for platform bus definitions */
 #ifndef __ASSEMBLY__
 enum ppc_sys_devices {
-       VIRTEX_UART, VIRTEX_FB,
+       VIRTEX_UART, VIRTEX_FB, NUM_PPC_SYS_DEVS,
 };
 #endif


--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 399-0195
