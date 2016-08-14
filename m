Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sC1DR335pzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 00:27:35 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7EENqwk105809
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Aug 2016 10:27:33 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24th4dn7px-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Aug 2016 10:27:32 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 14 Aug 2016 08:27:32 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] powerpc/8xx: implementation of huge pages
In-Reply-To: <cover.1471020646.git.christophe.leroy@c-s.fr>
References: <cover.1471020646.git.christophe.leroy@c-s.fr>
Date: Sun, 14 Aug 2016 19:57:24 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <8737m7a0j7.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> This set provides implementation of huge pages on the 8xx
>
> Christophe Leroy (6):
>   powerpc: port 64 bits pgtable_cache to 32 bits
>   powerpc: fix usage of _PAGE_RO in hugepage
>   powerpc/8xx: use r3 to scratch CR in ITLBmiss
>   powerpc/8xx: Move additional DTLBMiss handlers out of exception area
>   powerpc/8xx: make user addr DTLB miss the short path
>   powerpc/8xx: implementation of huge pages

Patch 2,3,4,5 are not really related to hugepage implementation right ?
May be that can be sent as a separate series ?

-aneesh
