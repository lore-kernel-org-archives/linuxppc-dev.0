Return-Path: <bsingharora@gmail.com>
Received: from mail-vk0-x243.google.com (mail-vk0-x243.google.com
 [IPv6:2607:f8b0:400c:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41BKLq4RnzzF0tX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 21:32:51 +1000 (AEST)
Received: by mail-vk0-x243.google.com with SMTP id 200-v6so1668638vkc.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 04:32:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621083158.30849-2-aneesh.kumar@linux.ibm.com>
References: <20180621083158.30849-1-aneesh.kumar@linux.ibm.com>
 <20180621083158.30849-2-aneesh.kumar@linux.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Thu, 21 Jun 2018 21:32:48 +1000
Message-ID: <CAKTCnz=qh7fLAuor9YNm5LH5ZKETTP9RjKv_SpR4c=wX37VTEA@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc/mm: Increase MAX_PHYSMEM_BITS to 128TB with
 SPARSEMEM_VMEMMAP config
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 21, 2018 at 6:31 PM, Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> We do this only with VMEMMAP config so that our page_to_[nid/section] etc are not
> impacted.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Why 128TB, given that it's sparse_vmemmap_extreme by default, why not
1PB directly (50 bits)?

Balbir Singh
