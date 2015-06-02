Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D7E321A1025
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 05:21:07 +1000 (AEST)
Date: Tue, 2 Jun 2015 21:20:45 +0200 (CEST)
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
Subject: Re: [PATCH v4 00/25] Convert the posix_clock_operations and k_clock
 structure to ready for 2038
In-Reply-To: <1433159093-4548-1-git-send-email-baolin.wang@linaro.org>
Message-ID: <alpine.DEB.2.11.1506022115240.20347@nanos>
References: <1433159093-4548-1-git-send-email-baolin.wang@linaro.org>
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

On Mon, 1 Jun 2015, Baolin Wang wrote:

> This patch series changes the 32-bit time types (timespec/itimerspec) to
> the 64-bit types (timespec64/itimerspec64), since 32-bit time types will
> break in the year 2038.

That's only true for 32bit systems.

All in all the patch series looks rather reasonable now, except for
the subject lines and the changelogs.

The only technical objection I have is the macro conversion magic in
patch #6. This can be done in a less cryptic and more efficient way.

See the comments to the various patches and please apply them to all
of the series.

Thanks,

	tglx
