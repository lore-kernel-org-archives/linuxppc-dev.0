Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x236.google.com (mail-pa0-x236.google.com
 [IPv6:2607:f8b0:400e:c03::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rz67m5Cg8zDqfp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 15:27:16 +1000 (AEST)
Received: by mail-pa0-x236.google.com with SMTP id ks6so68502079pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 22:27:16 -0700 (PDT)
Date: Tue, 26 Jul 2016 15:27:06 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 1/9] Add #defs for paca->soft_enabled flags
Message-ID: <20160726152706.43bffd08@roar.ozlabs.ibm.com>
In-Reply-To: <1469458342-26233-2-git-send-email-maddy@linux.vnet.ibm.com>
References: <1469458342-26233-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1469458342-26233-2-git-send-email-maddy@linux.vnet.ibm.com>
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

On Mon, 25 Jul 2016 20:22:14 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> Two #defs LAZY_INTERRUPT_ENABLED and
> LAZY_INTERRUPT_DISABLED are added to be used
> when updating paca->soft_enabled.

This is a very nice patchset, but can this not be a new name?
We use "soft enabled/disabled" everywhere for it. I think lazy
is an implementation detail anyway because some interrupts don't
cause a hard disable at all.

Thanks,
Nick
