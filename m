Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x236.google.com (mail-pa0-x236.google.com
 [IPv6:2607:f8b0:400e:c03::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AD7CC1A0063
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 16:06:32 +1100 (AEDT)
Received: by mail-pa0-x236.google.com with SMTP id yy13so25464607pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 21:06:32 -0800 (PST)
Received: from cotter.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id i13sm8547470pfi.95.2016.02.24.21.06.27
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLSv1/SSLv3 cipher=OTHER);
 Wed, 24 Feb 2016 21:06:29 -0800 (PST)
Subject: Re: [PATCH V4 02/18] mm: Some arch may want to use HPAGE_PMD related
 values as variables
To: linuxppc-dev@lists.ozlabs.org
References: <1456202900-5454-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1456202900-5454-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56CE8BD1.60100@gmail.com>
Date: Thu, 25 Feb 2016 16:06:25 +1100
MIME-Version: 1.0
In-Reply-To: <1456202900-5454-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 23/02/16 15:48, Aneesh Kumar K.V wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
In the changelog, strip from here <--
> With next generation power processor, we are having a new mmu model
> [1] that require us to maintain a different linux page table format.
>
> Inorder to support both current and future ppc64 systems with a single
> kernel we need to make sure kernel can select between different page
> table format at runtime.

---> till here

>  With the new MMU (radix MMU) added, we will
> have two different pmd hugepage size 16MB for hash model and 2MB for
> Radix model. Hence make HPAGE_PMD related values as a variable.
>
> Actual conversion of HPAGE_PMD to a variable for ppc64 happens in a
> followup patch.
>
> [1] http://ibm.biz/power-isa3 (Needs registration).
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Balbir Singh.
