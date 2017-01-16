Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v23gC04LXzDqSQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 17:46:46 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0G6hkai030190
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 01:46:43 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0b-001b2d01.pphosted.com with ESMTP id 280enn00cm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 01:46:43 -0500
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 16 Jan 2017 12:16:39 +0530
Received: from d28relay09.in.ibm.com (d28relay09.in.ibm.com [9.184.220.160])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 327D51258026
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 12:18:13 +0530 (IST)
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0G6kaBU28311652
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 12:16:36 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0G6kaA3029246
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 12:16:36 +0530
Subject: Re: [PATCH] powerpc/mm/4k: don't allocate larger pmd page table for 4k
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Nicholas Piggin <npiggin@gmail.com>
References: <20170104024912.8214-1-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Mon, 16 Jan 2017 12:16:26 +0530
MIME-Version: 1.0
In-Reply-To: <20170104024912.8214-1-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <d067dc8d-0673-eb05-6e35-3eda7c1f3848@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/04/2017 08:19 AM, Aneesh Kumar K.V wrote:
> We now support THP with both 64k and 4K page size configuration
> for radix. (hash only support THP with 64K page size). Hence we

Can be a different sentence ^^^^^^^ as well. Small nit.

> will have CONFIG_TRANSPARENT_HUGEPAGE enabled for both PPC_64K
> and PPC_4K config. Since we only need large pmd page table
> with hash configuration (to store the slot information
> in the second half of the table) restrict the large pmd page table
> to THP and 64K configs.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Reviewed-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
