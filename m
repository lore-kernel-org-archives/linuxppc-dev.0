Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x22d.google.com (mail-pf0-x22d.google.com
 [IPv6:2607:f8b0:400e:c00::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1jM15NVxzDrkB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 16:02:37 +1100 (AEDT)
Received: by mail-pf0-x22d.google.com with SMTP id u25so12130190pfg.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 21:02:37 -0800 (PST)
Date: Wed, 20 Dec 2017 15:02:20 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v10 00/17] powerpc: "paca->soft_enabled" based local
 atomic operation implementation
Message-ID: <20171220150220.2a55c114@roar.ozlabs.ibm.com>
In-Reply-To: <1513742157-28768-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1513742157-28768-1-git-send-email-maddy@linux.vnet.ibm.com>
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

On Wed, 20 Dec 2017 09:25:40 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> Local atomic operations are fast and highly reentrant per CPU counters.
> Used for percpu variable updates. Local atomic operations only guarantee
> variable modification atomicity wrt the CPU which owns the data and
> these needs to be executed in a preemption safe way.

As we've been discussing offline, these are all

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
Nick
