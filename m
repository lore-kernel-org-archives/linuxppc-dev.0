Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D7B81A0070
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 20:32:03 +1000 (AEST)
Date: Wed, 15 Jul 2015 12:31:23 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Baolin Wang <baolin.wang@linaro.org>
cc: benh@kernel.crashing.org, arnd@arndb.de, john.stultz@linaro.org,
 peterz@infradead.org, paulus@samba.org, mpe@ellerman.id.au,
 schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com,
 rth@twiddle.net, riel@redhat.com, cl@linux.com, tj@kernel.org,
 fweisbec@gmail.com, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, y2038@lists.linaro.org
Subject: Re: [PATCH 6/6] cputime: Introduce
 cputime_to_timespec64()/timespec64_to_cputime()
In-Reply-To: <a1bd8d71caeb4051d0be87aad1baae7ababa4df7.1436511577.git.baolin.wang@linaro.org>
Message-ID: <alpine.DEB.2.11.1507151226210.18576@nanos>
References: <cover.1436511577.git.baolin.wang@linaro.org>
 <a1bd8d71caeb4051d0be87aad1baae7ababa4df7.1436511577.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 15 Jul 2015, Baolin Wang wrote:

> The cputime_to_timespec() and timespec_to_cputime() functions are
> not year 2038 safe on 32bit systems due to that the struct timepsec
> will overflow in 2038 year.

And how is this relevant? cputime is not based on wall clock time at
all. So what has 2038 to do with cputime?

We want proper explanations WHY we need such a change.

Thanks,

	tglx
