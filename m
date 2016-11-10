Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x22e.google.com (mail-pf0-x22e.google.com
 [IPv6:2607:f8b0:400e:c00::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tFKfS4DwLzDt1n
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 10:54:56 +1100 (AEDT)
Received: by mail-pf0-x22e.google.com with SMTP id i88so703709pfk.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 15:54:56 -0800 (PST)
Subject: Re: [PATCH] powerpc/mm: Move hpte encode routine to platform specific
 files
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <20161110092423.20137-1-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <4be06fb7-dbef-2c99-c6b5-ed56edf51bbd@gmail.com>
Date: Fri, 11 Nov 2016 10:54:49 +1100
MIME-Version: 1.0
In-Reply-To: <20161110092423.20137-1-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 10/11/16 20:24, Aneesh Kumar K.V wrote:
> They differ between powernv and pseries. While we are at it copy
> a version for ps3 too. For now this is same as what we have for pSeries.
> 
> Fixes: 50de596de8be6 ("powerpc/mm/hash: Add support for Power9 Hash")
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>


I have not looked at the patch closely, but do we want all of this
duplication. I was wondering if instead of

cpu_has_feature() we could firmware_has_feature() for now


Balbir
