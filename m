Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x22d.google.com (mail-pf0-x22d.google.com
 [IPv6:2607:f8b0:400e:c00::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBG5F6PBqzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 23:05:04 +1100 (AEDT)
Received: by mail-pf0-x22d.google.com with SMTP id z11so7046275pfk.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 05:05:04 -0700 (PDT)
Date: Tue, 10 Oct 2017 22:04:51 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kvm-ppc@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: POWER9 more doorbell fixes
Message-ID: <20171010220451.4ff90328@roar.ozlabs.ibm.com>
In-Reply-To: <20171010101828.5950-1-npiggin@gmail.com>
References: <20171010101828.5950-1-npiggin@gmail.com>
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

On Tue, 10 Oct 2017 20:18:28 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> - Add another case where msgsync is required.
> - Required barrier sequence for global doorbells is msgsync ; lwsync
> - POWER9 DD1 has a different barrier sequence that we don't implement,
>   so remove

This last item was not included in the patch, it slipped past.
I think the changelog can just be changed to remove it.

Fixing up DD1 should be a different patch if we want to bother
with it. Guess either we add the darn sequence for msgsync, or
add support for xive IPIs?

Thanks,
Nick
