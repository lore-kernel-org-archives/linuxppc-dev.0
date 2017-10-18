Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGxKr0w2RzDrJT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 13:47:11 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id 17so2815396pfn.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 19:47:11 -0700 (PDT)
Date: Wed, 18 Oct 2017 13:47:01 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH 03/25] powerpc: track allocation status of all pkeys
Message-ID: <20171018134701.051a4dad@firefly.ozlabs.ibm.com>
In-Reply-To: <1504910713-7094-12-git-send-email-linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-12-git-send-email-linuxram@us.ibm.com>
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

On Fri,  8 Sep 2017 15:44:51 -0700
Ram Pai <linuxram@us.ibm.com> wrote:

> Total 32 keys are available on power7 and above. However
> pkey 0,1 are reserved. So effectively we  have  30 pkeys.
> 
> On 4K kernels, we do not  have  5  bits  in  the  PTE to
> represent  all the keys; we only have 3bits.Two of those
> keys are reserved; pkey 0 and pkey 1. So effectively  we
> have 6 pkeys.
> 
> This patch keeps track of reserved keys, allocated  keys
> and keys that are currently free.
> 
> Also it  adds  skeletal  functions  and macros, that the
> architecture-independent code expects to be available.
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>

I ended up reviewing v7 of the patch. Is this v8?
I think the comments still apply to this revision

Balbir Singh.
