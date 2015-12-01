Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EFD191A1B2E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 17:50:55 +1100 (AEDT)
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 1 Dec 2015 12:20:53 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id D1B03E0059
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 12:21:32 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB16oOm246399512
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 12:20:25 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB16oNIQ006118
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 12:20:24 +0530
Message-ID: <565D432F.6020309@linux.vnet.ibm.com>
Date: Tue, 01 Dec 2015 12:20:23 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
CC: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: Fix infinite loop in hash fault with 4K page
 size
References: <1448730573-11907-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1448730573-11907-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/28/2015 10:39 PM, Aneesh Kumar K.V wrote:
> This is the same bug we fixed as part of 09567e7fd44291bfc08accfdd67ad8f467842332
> ("powerpc/mm: Check paca psize is up to date for huge mappings"). Please
> check that for details. The difference here is that faults were
> happening on a 4K page at an address previously mapped by hugetlb.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Reviewed-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
