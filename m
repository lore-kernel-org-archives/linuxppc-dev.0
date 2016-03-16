Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQSyv6Mx1zDq6T
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 10:55:03 +1100 (AEDT)
Received: from mail-pf0-x230.google.com (mail-pf0-x230.google.com
 [IPv6:2607:f8b0:400e:c00::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qQSyv2n4Dz9t0t
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Mar 2016 10:55:03 +1100 (AEDT)
Received: by mail-pf0-x230.google.com with SMTP id n5so94301262pfn.2
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2016 16:55:03 -0700 (PDT)
Subject: Re: [PATCH] powerpc/mm: Remove long disabled SLB code
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1458125780-22841-1-git-send-email-mpe@ellerman.id.au>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56E9F251.7070005@gmail.com>
Date: Thu, 17 Mar 2016 10:54:57 +1100
MIME-Version: 1.0
In-Reply-To: <1458125780-22841-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 16/03/16 21:56, Michael Ellerman wrote:
> We have a bunch of SLB related code in the tree which is there to handle
> dynamic VSIDs - but currently it's all disabled at compile time. The
> comments say "Keep that around for when we re-implement dynamic VSIDs".
>
> But that was over 10 years ago (commit 3c726f8dee6f ("[PATCH] ppc64:
> support 64k pages")). The chance that it would still work unchanged is
> minimal, and in the meantime it's confusing to folks browsing/grepping
> the code. If we ever want to re-instate it, it's in the git history.
and older kernels :)
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>
Makes sense, given that none of the code is exercised, it makes sense to remove it or keep it tested and updated. Removal makes more sense

Acked-by: Balbir Singh <bsingharora@gmail.com>
