Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xQqKV00GtzDqkF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Aug 2017 17:43:57 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id j68so8294372pfc.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Aug 2017 00:43:57 -0700 (PDT)
Date: Mon, 7 Aug 2017 17:43:29 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling
 <mikey@neuling.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Akshay Adiga
 <akshay.adiga@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [v4 PATCH 0/2] powerpc/powernv: Enable stop4 via cpuidle
Message-ID: <20170807174329.51dd531a@roar.ozlabs.ibm.com>
In-Reply-To: <cover.1502084311.git.ego@linux.vnet.ibm.com>
References: <cover.1502084311.git.ego@linux.vnet.ibm.com>
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

On Mon,  7 Aug 2017 11:12:42 +0530
"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> Hi,
> 
> This is the fourth iteration of the patchset to enable exploitation of
> stop4 idle state on POWER9 via cpuidle.

These look good to me, thanks. I think the SPR saving is moving in the
right direction too. We should get this enabled stream as soon as possible.
For both patches,

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
