Return-Path: <srs0=+vpc=3o=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzVZM3ZcdzDqJh
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 03:48:59 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vzVZM21gXz8wPV
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 03:48:59 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vzVZL5pBTz9s8S
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Apr 2017 03:48:58 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v36HmWsj027367
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Apr 2017 13:48:49 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29ntd700d9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 06 Apr 2017 13:48:49 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 7 Apr 2017 03:48:46 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v36Hmat347120478
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Apr 2017 03:48:44 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v36HmBFk005812
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Apr 2017 03:48:11 +1000
Subject: [PATCH v8 2/3] powerpc/book3s: EXPORT_SYMBOL
 machine_check_print_event_info
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: gleb@kernel.org, Michael Ellerman <mpe@ellerman.id.au>, agraf@suse.de,
 KVM-PPC <kvm-ppc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Paul Mackerras <paulus@samba.org>, pbonzini@redhat.com
Cc: KVM <kvm@vger.kernel.org>, david@gibson.dropbear.id.au
Date: Thu, 06 Apr 2017 23:17:51 +0530
In-Reply-To: <149150078227.9475.13869552319691573937.stgit@jupiter.in.ibm.com>
References: <149150078227.9475.13869552319691573937.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <149150087155.9475.11789033992324470445.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

It will be used in arch/powerpc/kvm/book3s_hv.c KVM module.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/mce.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index a1475e6..e567ff1 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -393,6 +393,7 @@ void machine_check_print_event_info(struct machine_check_event *evt)
 		break;
 	}
 }
+EXPORT_SYMBOL(machine_check_print_event_info);
 
 uint64_t get_mce_fault_addr(struct machine_check_event *evt)
 {
