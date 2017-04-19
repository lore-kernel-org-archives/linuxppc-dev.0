Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w76m45pZczDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 13:23:48 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3J3Nd9T143365
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 23:23:39 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29wqq11dms-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 23:23:38 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 19 Apr 2017 13:23:36 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3J3NQgJ1114404
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 13:23:34 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3J3N10v026797
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 13:23:01 +1000
Date: Wed, 19 Apr 2017 13:22:37 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH] powerpc/powernv: Block PCI config access on BCM5719
 during EEH recovery
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1492569583-908-1-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1492569583-908-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <20170419032236.GA7560@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 19, 2017 at 12:39:43PM +1000, Gavin Shan wrote:
>Similar to what is done in commit b6541db13952 ("powerpc/eeh: Block
>PCI config access upon frozen PE"), we need block PCI config access
>for BCM5719 when recovering frozen error on them. Otherwise, an
>unexpected recursive fenced PHB error is observed.
>
>   0001:06:00.0 Ethernet controller: Broadcom Corporation \
>                NetXtreme BCM5718 Gigabit Ethernet PCIe (rev 10)
>   0001:06:00.1 Ethernet controller: Broadcom Corporation \
>                NetXtreme BCM5718 Gigabit Ethernet PCIe (rev 10)
>

It says BCM5719 in the subject, but it should be BCM5718. I'll
send an updated one for that.

Thanks,
Gavin
