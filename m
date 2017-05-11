Return-Path: <srs0=ltoi=4r=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wNjYg2xS0zDqZX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 16:16:55 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wNjYg2Fpqz8t1b
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 16:16:55 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wNjYf2YLCz9sDG
 for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2017 16:16:54 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4B697Dl088091
 for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2017 02:16:44 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ac9d0mbvt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2017 02:16:44 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 11 May 2017 16:16:41 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4B6GUW9655794
 for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2017 16:16:38 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4B6G5dJ007069
 for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2017 16:16:05 +1000
Subject: [PATCH v9 2/3] powerpc/book3s: EXPORT_SYMBOL
 machine_check_print_event_info
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: gleb@kernel.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Paul Mackerras <paulus@samba.org>, pbonzini@redhat.com
Cc: Michael Ellerman <mpe@ellerman.id.au>, kvm@vger.kernel.org,
 david@gibson.dropbear.id.au
Date: Thu, 11 May 2017 11:45:45 +0530
In-Reply-To: <149448323691.12206.11861424815113458031.stgit@jupiter.in.ibm.com>
References: <149448323691.12206.11861424815113458031.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <149448334581.12206.14093241775576407387.stgit@jupiter.in.ibm.com>
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
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/mce.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index 5f9eada..6f1389a 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -405,6 +405,7 @@ void machine_check_print_event_info(struct machine_check_event *evt,
 		break;
 	}
 }
+EXPORT_SYMBOL(machine_check_print_event_info);
 
 uint64_t get_mce_fault_addr(struct machine_check_event *evt)
 {
