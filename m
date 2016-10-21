Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t0kss5Xv7zDt20
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 23:06:09 +1100 (AEDT)
Date: Fri, 21 Oct 2016 14:06:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
 linux-s390 <linux-s390@vger.kernel.org>, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, Noam Camus <noamc@ezchip.com>
Subject: Re: [PATCH/RFC 0/5] cpu_relax: introduce yield, remove lowlatency
Message-ID: <20161021120605.GD3142@twins.programming.kicks-ass.net>
References: <1477051138-1610-1-git-send-email-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1477051138-1610-1-git-send-email-borntraeger@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 21, 2016 at 01:58:53PM +0200, Christian Borntraeger wrote:
> Christian Borntraeger (5):
>   processor.h: introduce cpu_relax_yield
>   stop_machine: yield CPU during stop machine
>   s390: make cpu_relax a barrier again
>   Remove cpu_relax_lowlatency users
>   remove cpu_relax_lowlatency

Yay for killing cpu_relax_lowlatency()...
