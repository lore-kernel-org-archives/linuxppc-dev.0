Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t2VKk5QNxzDt6J
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 19:47:54 +1100 (AEDT)
Date: Mon, 24 Oct 2016 10:47:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
 linux-s390 <linux-s390@vger.kernel.org>, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, Noam Camus <noamc@ezchip.com>,
 virtualization@lists.linux-foundation.org,
 xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org
Subject: Re: [PATCH 2/5] stop_machine: yield CPU during stop machine
Message-ID: <20161024084747.GE3102@twins.programming.kicks-ass.net>
References: <1477051138-1610-1-git-send-email-borntraeger@de.ibm.com>
 <1477051138-1610-3-git-send-email-borntraeger@de.ibm.com>
 <20161021120536.GC3142@twins.programming.kicks-ass.net>
 <20161022110636.410f20bd@roar.ozlabs.ibm.com>
 <251574ff-13ba-c0df-76c3-cb7df30894cb@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <251574ff-13ba-c0df-76c3-cb7df30894cb@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 24, 2016 at 09:52:31AM +0200, Christian Borntraeger wrote:
> Peter, I will fixup the patch set (I forgot to remove the lowlatency
> in 2 places) and push it on my tree for linux-next. Lets see what happens.
> Would the tip tree be the right place if things work out ok?

I think so, you're touching a fair bit of kernel/locking/ and there's
bound to be some conflicts with work there. So carrying it in the
locking tree might be best.
