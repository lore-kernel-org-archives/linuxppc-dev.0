Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x22e.google.com (mail-pf0-x22e.google.com
 [IPv6:2607:f8b0:400e:c00::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qr5Qq0sTrzDqbD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 14:30:43 +1000 (AEST)
Received: by mail-pf0-x22e.google.com with SMTP id 184so25793321pff.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 21:30:43 -0700 (PDT)
Subject: Re: [PATCH V2 28/68] powerpc/mm: Add radix callbacks to pte accessors
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-29-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <5718576C.6010605@gmail.com>
Date: Thu, 21 Apr 2016 14:30:36 +1000
MIME-Version: 1.0
In-Reply-To: <1460182444-2468-29-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
> For those pte accessors, that operate on a different set of pte bits
> between hash/radix, we add a generic variant that does a conditional
> to hash linux or radix variant.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---

Looks good!

Balbir
