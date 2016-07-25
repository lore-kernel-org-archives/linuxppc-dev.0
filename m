Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryV4M5xyDzDqYb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 15:22:11 +1000 (AEST)
Received: by mail-pa0-x22b.google.com with SMTP id fi15so57592140pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jul 2016 22:22:11 -0700 (PDT)
Date: Mon, 25 Jul 2016 15:22:01 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH for-4.8 V2 00/10] Use jump label for cpu/mmu_has_feature
Message-ID: <20160725152201.03788ccb@roar.ozlabs.ibm.com>
In-Reply-To: <1469265163-1491-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1469265163-1491-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

On Sat, 23 Jul 2016 14:42:33 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> Changes from V1:
> * Update "powerpc/mm: Convert early cpu/mmu feature check to use the
> new helpers" based on resend code changes in this area.
> 
> We now do feature fixup early and hence we can reduce the usage of
>  __cpu/__mmu_has_feature.

Is there a particular reason for for-4.8?

I've only just started following this development so it might be
obvious, but if you could add some small justifications for why
a patch or series is done, it would be of great help to me.

Thanks,
Nick
