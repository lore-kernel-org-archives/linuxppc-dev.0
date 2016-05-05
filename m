Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0yVf5144zDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2016 00:49:46 +1000 (AEST)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 6 May 2016 00:49:45 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 9188B2BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2016 00:49:42 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u45EnYNO38142104
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 May 2016 00:49:42 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u45En8lx004433
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 May 2016 00:49:09 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, mikey@neuling.org, oohall@gmail.com
Subject: Re: [PATCH 0/2] Enable ZONE_DEVICE on POWER
In-Reply-To: <1462450304-19173-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1462450304-19173-1-git-send-email-khandual@linux.vnet.ibm.com>
Date: Thu, 05 May 2016 20:18:50 +0530
Message-ID: <87r3dgk1bh.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:

> This enables base ZONE_DEVICE support on POWER. This series depends on
> the following patches posted by Oliver.
>
> https://patchwork.ozlabs.org/patch/618867/
> https://patchwork.ozlabs.org/patch/618868/
>
> Anshuman Khandual (2):
>   powerpc/mm: Make vmemmap_populate accommodate ZONE_DEVICE memory
>   powerpc/mm: Enable support for ZONE_DEVICE on PPC_BOOK3S_64 platforms
>
>  arch/powerpc/mm/init_64.c | 4 +++-
>  mm/Kconfig                | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>

What is the use case ? Who will use ZONE_DEVICE on ppc64. This should be
be merged along with the patch series that use this. 

-aneesh
