Return-Path: <a.p.zijlstra@chello.nl>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 92815B6FAF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2012 19:02:06 +1000 (EST)
Message-ID: <1338973295.2749.81.camel@twins>
Subject: Re: [RFC PATCH] sched/numa: do load balance between remote nodes
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Alex Shi <alex.shi@intel.com>
Date: Wed, 06 Jun 2012 11:01:35 +0200
In-Reply-To: <1338965571-9812-1-git-send-email-alex.shi@intel.com>
References: <1338965571-9812-1-git-send-email-alex.shi@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, dhowells@redhat.com, paulus@samba.org, hpa@zytor.com,
 sparclinux@vger.kernel.org, mingo@kernel.org, sivanich@sgi.com, x86@kernel.org,
 greg.pearson@hp.com, chris.mason@oracle.com, arjan.van.de.ven@intel.com,
 mattst88@gmail.com, pjt@google.com, fenghua.yu@intel.com,
 seto.hidetoshi@jp.fujitsu.com, cmetcalf@tilera.com, ak@linux.intel.com,
 ink@jurassic.park.msu.ru, anton@samba.org, tglx@linutronix.de,
 kamezawa.hiroyu@jp.fujitsu.com, rth@twiddle.net, tony.luck@intel.com,
 torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 ralf@linux-mips.org, lethal@linux-sh.org, linux-alpha@vger.kernel.org,
 bob.picco@oracle.com, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-06-06 at 14:52 +0800, Alex Shi wrote:
> -       if (sched_domains_numa_distance[level] > REMOTE_DISTANCE)
> +       if (sched_domains_numa_distance[level] > RECLAIM_DISTANCE)=20

I actually considered this.. I just felt a little uneasy re-purposing
the RECLAIM_DISTANCE for this, but I guess its all the same anyway. Both
mean expensive-away-distance.

So I've taken this.

thanks!
