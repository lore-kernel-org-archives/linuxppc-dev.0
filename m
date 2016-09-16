Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sbB1H2RQXzDsZf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 20:12:51 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id q2so800868pfj.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 03:12:51 -0700 (PDT)
Date: Fri, 16 Sep 2016 20:12:42 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 08/13] powerpc: Add new _EXCEPTION_PROLOG_1 macro
Message-ID: <20160916201242.7b452f42@roar.ozlabs.ibm.com>
In-Reply-To: <1473944523-624-9-git-send-email-maddy@linux.vnet.ibm.com>
References: <1473944523-624-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1473944523-624-9-git-send-email-maddy@linux.vnet.ibm.com>
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

On Thu, 15 Sep 2016 18:31:58 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> To support addition of "bitmask" to MASKABLE_* macros,
> factor out the EXCPETION_PROLOG_1 macro.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Really minor nit, but as a matter of readability of the series,
would you consider moving this next to patch 10 where it's used,
if you submit again?

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
