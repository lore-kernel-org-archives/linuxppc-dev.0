Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJGcs4BN7zDrJs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 01:49:32 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6RFnLPk093230
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 11:49:28 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2byjwe0njf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 11:49:20 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 27 Jul 2017 09:48:48 -0600
Subject: Re: [RFC PATCH 1/3] powerpc/mm: update pmdp_invalidate to return old
 pmd value
To: Michal Hocko <mhocko@kernel.org>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 "Kirill A . Shutemov" <kirill@shutemov.name>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
References: <20170727083756.32217-1-aneesh.kumar@linux.vnet.ibm.com>
 <20170727125449.GB27766@dhcp22.suse.cz>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 27 Jul 2017 21:18:35 +0530
MIME-Version: 1.0
In-Reply-To: <20170727125449.GB27766@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <a30c566c-20ab-d3ad-1f5f-47524a97c2a3@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 07/27/2017 06:24 PM, Michal Hocko wrote:
> EMISSING_CHANGELOG
> 
> besides that no user actually uses the return value. Please fold this
> into the patch which uses the new functionality.


The patch series was suppose to help Kirill to make progress with the 
his series at


https://lkml.kernel.org/r/20170615145224.66200-1-kirill.shutemov@linux.intel.com

It is essentially implementing the pmdp_invalidate update for ppc64. His 
series does it for x86-64.

-aneesh
