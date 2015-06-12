Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 388B51A06DF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 23:16:46 +1000 (AEST)
Date: Fri, 12 Jun 2015 15:16:11 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Baolin Wang <baolin.wang@linaro.org>
cc: arnd@arndb.de, john.stultz@linaro.org, heenasirwani@gmail.com,
 pang.xunlei@linaro.org, peterz@infradead.org, rafael.j.wysocki@intel.com,
 gregkh@linuxfoundation.org, richardcochran@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com,
 rth@twiddle.net, riel@redhat.com, cl@linux.com, tj@kernel.org,
 fweisbec@gmail.com, ahh@google.com, pjt@google.com,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, serge.hallyn@canonical.com,
 james.l.morris@oracle.com, serge@hallyn.com, pmoore@redhat.com,
 tiwai@suse.de, jeffv@google.com, jlayton@primarydata.com,
 keescook@chromium.org, sds@tycho.nsa.gov, mark.d.rustad@intel.com,
 linux-security-module@vger.kernel.org, y2038@lists.linaro.org
Subject: Re: [PATCH v5 00/24] Convert the posix_clock_operations and k_clock
 structure to ready for 2038
In-Reply-To: <cover.1434079262.git.baolin.wang@linaro.org>
Message-ID: <alpine.DEB.2.11.1506121512180.3786@nanos>
References: <lfywpz1987> <cover.1434079262.git.baolin.wang@linaro.org>
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

On Fri, 12 Jun 2015, Baolin Wang wrote:

Sigh. Again threading of the series failed. Some patches are, the
whole series is not. Can you please get your tools straight?

You neither managed to cc me on the security patch.

> - Modify the subject line and the changelog:

>   timekeeping: Change the implementation of timekeeping_clocktai()

Sigh. How is that better than the previous one? It's more accurate,
but equally useless.

And of course you did not address my request to change the macro mess
in

>   posix-timers: Introduce {get,put}_timespec and {get,put}_itimerspec

according to the discussion with Arnd.

Thanks,

	tglx
