Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrLLX4j6tzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 00:12:52 +1000 (AEST)
Received: by mail-pa0-x22a.google.com with SMTP id r5so26815390pag.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 07:12:52 -0700 (PDT)
Subject: Re: [PATCH V2 35/68] powerpc/mm: Abstraction for switch_mmu_context
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-36-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <5718DFD2.9070500@gmail.com>
Date: Fri, 22 Apr 2016 00:12:34 +1000
MIME-Version: 1.0
In-Reply-To: <1460182444-2468-36-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 09/04/16 16:13, Aneesh Kumar K.V wrote:
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/mmu_context.h | 25 +++++++++++++------------
>  arch/powerpc/kernel/swsusp.c           |  2 +-
>  arch/powerpc/mm/mmu_context_nohash.c   |  3 ++-
>  drivers/cpufreq/pmac32-cpufreq.c       |  2 +-
>  drivers/macintosh/via-pmu.c            |  4 ++--
>  5 files changed, 19 insertions(+), 17 deletions(-)

Why do we need to pass the task? Changelog --?

Balbir
