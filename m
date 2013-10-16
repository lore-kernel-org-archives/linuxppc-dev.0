Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4F96C2C0381
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 13:07:18 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 15 Oct 2013 22:07:16 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id E68CE38C8042
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Oct 2013 22:07:11 -0400 (EDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b01cxnp22036.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9G27CfJ8913214
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 02:07:12 GMT
Received: from d03av04.boulder.ibm.com (localhost [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9G27BHb022844
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Oct 2013 20:07:12 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: [PATCH 07/10][v6] powerpc/perf: Add Power8 event PM_MRK_GRP_CMPL to
 sysfs.
Date: Tue, 15 Oct 2013 19:06:39 -0700
Message-Id: <1381889202-16826-8-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1381889202-16826-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1381889202-16826-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: Michael Ellerman <michaele@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The perf event PM_MRK_GRP_CMPL is useful in analyzing memory hierarchy
of applications.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
Changelog[v6]:
	- [Michael Ellerman]: Drop redundant PME_ prefix from event name.

 arch/powerpc/perf/power8-events-list.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/perf/power8-events-list.h b/arch/powerpc/perf/power8-events-list.h
index 1368547..b39e117 100644
--- a/arch/powerpc/perf/power8-events-list.h
+++ b/arch/powerpc/perf/power8-events-list.h
@@ -18,3 +18,4 @@ EVENT(PM_CMPLU_STALL,			0x4000a)
 EVENT(PM_INST_CMPL,			0x00002)
 EVENT(PM_BRU_FIN,			0x10068)
 EVENT(PM_BR_MPRED_CMPL,			0x400f6)
+EVENT(PM_MRK_GRP_CMPL,			0x40130)
-- 
1.7.9.5
