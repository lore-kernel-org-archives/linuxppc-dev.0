Return-Path: <srs0=rc+b=5z=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsSV02YfWzDqhk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 22:54:32 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wsSV024MPz8t4R
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 22:54:32 +1000 (AEST)
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wsSTz5TDjz9s78
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2017 22:54:31 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id d5so22809341pfe.1
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2017 05:54:31 -0700 (PDT)
Date: Tue, 20 Jun 2017 22:54:18 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/3] powerpc/64s: Use BRANCH_TO_COMMON() for
 slb_miss_realmode
Message-ID: <20170620225418.73d862b8@roar.ozlabs.ibm.com>
In-Reply-To: <1497962097-9402-1-git-send-email-mpe@ellerman.id.au>
References: <1497962097-9402-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 20 Jun 2017 22:34:55 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> All the callers of slb_miss_realmode currently open code the #ifndef
> CONFIG_RELOCATABLE check and the branch via CTR in the RELOCATABLE case.
> We have a macro to do this, BRANCH_TO_COMMON(), so use it.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

These 3 all look good to me.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
