Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sb9vz5wfdzDsGT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 20:08:15 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id q2so795864pfj.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 03:08:15 -0700 (PDT)
Date: Fri, 16 Sep 2016 20:08:06 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 07/13] powerpc: Avoid using EXCEPTION_PROLOG_1 macro in
 MASKABLE_*
Message-ID: <20160916200806.3fc20217@roar.ozlabs.ibm.com>
In-Reply-To: <1473944523-624-8-git-send-email-maddy@linux.vnet.ibm.com>
References: <1473944523-624-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1473944523-624-8-git-send-email-maddy@linux.vnet.ibm.com>
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

On Thu, 15 Sep 2016 18:31:57 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> Currently we use both EXCEPTION_PROLOG_1 and __EXCEPTION_PROLOG_1
> in the MASKABLE_* macros. As a cleanup, this patch makes MASKABLE_*
> to use only __EXCEPTION_PROLOG_1. There is not logic change.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

I assume this was done like this once for some macro expansion issue?
If it doesn't cause any breakage, then fine.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
