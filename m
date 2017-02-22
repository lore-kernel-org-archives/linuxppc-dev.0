Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x233.google.com (mail-pg0-x233.google.com
 [IPv6:2607:f8b0:400e:c05::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSdHX5Q8TzDqGl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 11:18:00 +1100 (AEDT)
Received: by mail-pg0-x233.google.com with SMTP id z128so5986351pgb.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 16:18:00 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 22 Feb 2017 11:17:52 +1100
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V3 06/10] powerpc/mm: Remove redundant TASK_SIZE_USER64
 checks
Message-ID: <20170222001752.GC10842@balbir.ozlabs.ibm.com>
References: <1487498837-12017-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1487498837-12017-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487498837-12017-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 19, 2017 at 03:37:13PM +0530, Aneesh Kumar K.V wrote:
> The check against VSID range is implied when we check task size against
> hash and radix pgtable range[1], because we make sure page table range cannot
> exceed vsid range.
> 
> [1] BUILD_BUG_ON(TASK_SIZE_USER64 > H_PGTABLE_RANGE);
> BUILD_BUG_ON(TASK_SIZE_USER64 > RADIX_PGTABLE_RANGE);
> 
> The check for smaller task size is also removed here, because the follow up
> patch will support a tasksize smaller than pgtable range.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---

Acked-by: Balbir Singh <bsingharora@gmail.com>
