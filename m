Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sb9SB6XdRzDsZc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 19:47:38 +1000 (AEST)
Received: by mail-pa0-x229.google.com with SMTP id oz2so20221964pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 02:47:38 -0700 (PDT)
Date: Fri, 16 Sep 2016 19:47:29 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 02/13] powerpc: Cleanup to use IRQ_DISABLE_MASK_* macros
 for paca->soft_enabled update
Message-ID: <20160916194729.3c0bfa9b@roar.ozlabs.ibm.com>
In-Reply-To: <1473944523-624-3-git-send-email-maddy@linux.vnet.ibm.com>
References: <1473944523-624-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1473944523-624-3-git-send-email-maddy@linux.vnet.ibm.com>
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

On Thu, 15 Sep 2016 18:31:52 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> Replace the hardcoded values used when updating
> paca->soft_enabled with IRQ_DISABLE_MASK_* #def.
> No logic change.

This could be folded with patch 1.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
