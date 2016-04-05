Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qfRt93kMszDq6T
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Apr 2016 21:47:29 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id hb4so1098599pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Apr 2016 04:47:29 -0700 (PDT)
Subject: Re: [PATCH 09/65] powerpc/mm: Use helper for finding pte bits mapping
 I/O area
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1459067053-10835-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <5703A5CA.4050806@gmail.com>
Date: Tue, 5 Apr 2016 21:47:22 +1000
MIME-Version: 1.0
In-Reply-To: <1459067053-10835-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 27/03/16 19:23, Aneesh Kumar K.V wrote:
> Use helper instead of opencoding with constants. Later patch will
> drop the WIMG bits and use PowerISA 3.0 defines
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/btext.c      | 2 +-
>  arch/powerpc/kernel/isa-bridge.c | 4 ++--
>  arch/powerpc/kernel/pci_64.c     | 2 +-
>  arch/powerpc/mm/pgtable_64.c     | 4 ++--
>  arch/powerpc/platforms/ps3/spu.c | 2 +-
>  drivers/pcmcia/electra_cf.c      | 2 +-
>  6 files changed, 8 insertions(+), 8 deletions(-)
>
>

To be honest the code is harder to read with these changes

Balbir
