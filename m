Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vy9mP6wxszDqSn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 00:08:05 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v34E3xBb105600
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 10:07:57 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29ktf7ae8q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Apr 2017 10:07:57 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 4 Apr 2017 10:07:56 -0400
Subject: Re: [RFC PATCH 1/7] mm/hugetlb/migration: Use set_huge_pte_at instead
 of set_pte_at
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1491314675-15787-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 4 Apr 2017 19:37:50 +0530
MIME-Version: 1.0
In-Reply-To: <1491314675-15787-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <93a2973d-aca7-7559-5b8e-d6e50487be00@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The patch series is not yet send to linux-mm. Once I get feedback on the 
approach used, I will resend this to linux-mm.

Also if there is sufficient interest we could also get nohash hugetlb 
migration to work. But I avoided doing that in this series, because of 
my inability to test the changes.

-aneesh
