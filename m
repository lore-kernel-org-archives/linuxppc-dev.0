Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRvjH0QGyzDqtV
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 12:04:50 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7923rlM094465
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Aug 2017 22:04:48 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c7ng81gp9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Aug 2017 22:04:47 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 9 Aug 2017 12:04:45 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7924h9R32178290
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Aug 2017 12:04:43 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7924YLO026025
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Aug 2017 12:04:34 +1000
Subject: Re: [PATCH] powerpc/include/asm: Remove unused 64bit cacheflush
 function
To: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20170720062716.8D819136040@b03ledav002.gho.boulder.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 9 Aug 2017 12:04:42 +1000
MIME-Version: 1.0
In-Reply-To: <20170720062716.8D819136040@b03ledav002.gho.boulder.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <da87042d-1573-f910-5d21-d64f7c0630bf@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 20/07/17 16:25, Matt Brown wrote:
> The flush_dcache_phys_range function is no longer used in the kernel.
> This patch removes and cleans up the function.
> 
> Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>

That does indeed look unused.

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
