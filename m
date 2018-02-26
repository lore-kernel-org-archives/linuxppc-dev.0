Return-Path: <muriloo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqqdd5K7lzF1T4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 05:11:14 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1QIB8We021107
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 13:11:12 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gckpy1y7u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 13:11:11 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <muriloo@linux.vnet.ibm.com>;
 Mon, 26 Feb 2018 11:11:10 -0700
Subject: Re: [PATCH V2 4/4] powerpc/mm/hash64: Increase the VA range
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
References: <20180226140826.11641-1-aneesh.kumar@linux.vnet.ibm.com>
 <20180226140826.11641-5-aneesh.kumar@linux.vnet.ibm.com>
From: Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com>
Date: Mon, 26 Feb 2018 15:11:04 -0300
MIME-Version: 1.0
In-Reply-To: <20180226140826.11641-5-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <5876ab5b-237f-6e05-62e9-59fb2fe4a8f1@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/26/2018 11:08 AM, Aneesh Kumar K.V wrote:
> ---
>  arch/powerpc/include/asm/book3s/64/hash-64k.h | 2 +-
>  arch/powerpc/include/asm/processor.h          | 9 ++++++++-
>  arch/powerpc/mm/init_64.c                     | 6 ------
>  arch/powerpc/mm/pgtable_64.c                  | 5 -----
>  4 files changed, 9 insertions(+), 13 deletions(-)

Hi, Aneesh.

This patch is missing Signed-off-by: line. You're encouraged to run
checkpatch.pl to inspect your patches.

You may also want to add a brief paragraph in the commit message
explaining the "why" of this change.

Cheers
Murilo
