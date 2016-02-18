Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 20CA11A00A5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 13:55:02 +1100 (AEDT)
Received: by mail-pa0-x232.google.com with SMTP id fy10so22112397pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 18:55:02 -0800 (PST)
Message-ID: <1455764093.3089.13.camel@gmail.com>
Subject: Re: [PATCH V6 04/35] powerpc/mm: make a separate copy for book3s
 (part 2)
From: Balbir Singh <bsingharora@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, Scott Wood
 <scottwood@freescale.com>, Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Thu, 18 Feb 2016 13:54:53 +1100
In-Reply-To: <1448941020-15168-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1448941020-15168-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1448941020-15168-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
> Keep it seperate to make rebasing easier
> 
> Acked-by: Scott Wood <scottwood@freescale.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/32/pgtable.h | 6 +++---
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 6 +++---
>  arch/powerpc/include/asm/pgtable-ppc32.h     | 2 --
>  arch/powerpc/include/asm/pgtable-ppc64.h     | 4 ----
>  4 files changed, 6 insertions(+), 12 deletions(-)
> 

One side effect is that someone could by mistake include
asm/book3s/32/pgtable.h and asm/pgtable-ppc32.h and get
duplicate definitions and have the compiler complain


Ditto for the 64 bit headers

Balbir
