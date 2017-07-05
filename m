Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2Swl6842zDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jul 2017 14:45:27 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v654i2H4138574
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jul 2017 00:45:25 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bg78psyep-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Jul 2017 00:45:25 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 5 Jul 2017 14:45:22 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v654jKMo4719002
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jul 2017 14:45:20 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v654jB53001241
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jul 2017 14:45:12 +1000
Subject: Re: [PATCH] powerpc/mm: fix a hardcode on memory boundary checking
To: Rui Teng <rui.teng@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20170112090906.17864-1-rui.teng@linux.vnet.ibm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 jia he <hejianet@linux.vnet.ibm.com>
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Wed, 5 Jul 2017 10:15:11 +0530
MIME-Version: 1.0
In-Reply-To: <20170112090906.17864-1-rui.teng@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <d960be70-c47b-cfb4-45b4-7d35e3e19539@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/12/2017 02:39 PM, Rui Teng wrote:
> The offset of hugepage block will not be 16G, if the expected
> page is more than one. Calculate the totol size instead of the
> hardcode value.
> 
> Signed-off-by: Rui Teng <rui.teng@linux.vnet.ibm.com>

I have a redundant patch, this one is the original.

Tested-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
