Return-Path: <srs0=/ax1=53=au1.ibm.com=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtZ4j1wktzDr1S
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 18:09:57 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wtZ4j1DBJz8sxh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 18:09:57 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wtZ4h4W6xz9sNv
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2017 18:09:56 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5M88i8u018374
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2017 04:09:53 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b87sgxx3a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2017 04:09:52 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@au1.ibm.com>;
 Thu, 22 Jun 2017 18:09:47 +1000
Subject: Re: 1M hugepage size being registered on Linux
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Michael Ellerman <mpe@ellerman.id.au>, victora
 <victora@linux.vnet.ibm.com>, alistair@popple.id.au, jk@ozlabs.org
Cc: victora@br.ibm.com, mauricfo@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org
Date: Thu, 22 Jun 2017 03:09:31 -0500
In-Reply-To: <87o9tgsmdv.fsf@concordia.ellerman.id.au>
References: <322aa4a1a11ca79008a8c894c12a80d5@linux.vnet.ibm.com>
 <87o9tgsmdv.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1498118971.31581.65.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-06-22 at 13:59 +1000, Michael Ellerman wrote:
> It's unsupported in Linux because it doesn't match the page table
> geometry.
> 
> We merged a patch from Aneesh to filter it out in 4.12-rc1:
> 
>   a525108cf1cc ("powerpc/mm/hugetlb: Filter out hugepage size not supported by page table layout")
> 
> I guess we should probably send that patch to stable et. al.

It's also not supported in HW afaik, why is it there ?

Cheers,
Ben.
