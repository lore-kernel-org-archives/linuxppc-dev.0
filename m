Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x22b.google.com (mail-pf0-x22b.google.com
 [IPv6:2607:f8b0:400e:c00::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C87B41A00A5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 13:52:10 +1100 (AEDT)
Received: by mail-pf0-x22b.google.com with SMTP id c10so23156915pfc.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 18:52:10 -0800 (PST)
Message-ID: <1455763922.3089.10.camel@gmail.com>
Subject: Re: [PATCH V6 01/35] powerpc/mm: move pte headers to book3s directory
From: Balbir Singh <bsingharora@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, Scott Wood
 <scottwood@freescale.com>, Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Thu, 18 Feb 2016 13:52:02 +1100
In-Reply-To: <1448941020-15168-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1448941020-15168-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1448941020-15168-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-12-01 at 09:06 +0530, Aneesh Kumar K.V wrote:
> Acked-by: Scott Wood <scottwood@freescale.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/{pte-hash32.h => book3s/32/hash.h} | 0
>  arch/powerpc/include/asm/{pte-hash64.h => book3s/64/hash.h} | 0
>  arch/powerpc/include/asm/pgtable-ppc32.h                    | 2 +-
>  arch/powerpc/include/asm/pgtable-ppc64.h                    | 2 +-
>  4 files changed, 2 insertions(+), 2 deletions(-)
>  rename arch/powerpc/include/asm/{pte-hash32.h => book3s/32/hash.h} (100%)
>  rename arch/powerpc/include/asm/{pte-hash64.h => book3s/64/hash.h} (100%)

Why not pte-hash.h?

Balbir Singh.
