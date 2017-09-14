Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xt3kQ2h8LzDqh4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 13:22:38 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id v82so1039405pgb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 20:22:38 -0700 (PDT)
Date: Thu, 14 Sep 2017 13:22:27 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH 7/7] powerpc: capture the PTE format changes in the dump
 pte report
Message-ID: <20170914132227.204ae9ac@firefly.ozlabs.ibm.com>
In-Reply-To: <1504910713-7094-8-git-send-email-linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-8-git-send-email-linuxram@us.ibm.com>
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

On Fri,  8 Sep 2017 15:44:47 -0700
Ram Pai <linuxram@us.ibm.com> wrote:

> The H_PAGE_F_SECOND,H_PAGE_F_GIX are not in the 64K main-PTE.
> capture these changes in the dump pte report.
> 
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---

So we lose slot and secondary information for 64K PTE's with
this change?

Balbir
