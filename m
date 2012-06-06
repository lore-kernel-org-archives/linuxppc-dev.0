Return-Path: <sshtylyov@mvista.com>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
 [209.85.217.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 29B40B6FC4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2012 20:53:45 +1000 (EST)
Received: by lban1 with SMTP id n1so4469279lba.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jun 2012 03:53:42 -0700 (PDT)
Message-ID: <4FCF3694.206@mvista.com>
Date: Wed, 06 Jun 2012 14:53:08 +0400
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: Alex Shi <alex.shi@intel.com>
Subject: Re: [RFC PATCH] sched/numa: do load balance between remote nodes
References: <1338965571-9812-1-git-send-email-alex.shi@intel.com>
In-Reply-To: <1338965571-9812-1-git-send-email-alex.shi@intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, dhowells@redhat.com, paulus@samba.org, hpa@zytor.com,
 sparclinux@vger.kernel.org, mingo@kernel.org, sivanich@sgi.com, x86@kernel.org,
 greg.pearson@hp.com, chris.mason@oracle.com, arjan.van.de.ven@intel.com,
 mattst88@gmail.com, pjt@google.com, fenghua.yu@intel.com,
 seto.hidetoshi@jp.fujitsu.com, a.p.zijlstra@chello.nl, cmetcalf@tilera.com,
 ak@linux.intel.com, ink@jurassic.park.msu.ru, anton@samba.org,
 tglx@linutronix.de, kamezawa.hiroyu@jp.fujitsu.com, rth@twiddle.net,
 tony.luck@intel.com, torvalds@linux-foundation.org,
 linux-kernel@vger.kernel.org, ralf@linux-mips.org, lethal@linux-sh.org,
 linux-alpha@vger.kernel.org, bob.picco@oracle.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

On 06-06-2012 10:52, Alex Shi wrote:

> commit cb83b629b

    Please also specify that commit's summary in parens.

> remove the NODE sched domain and check if the node
> distance in SLIT table is farther than REMOTE_DISTANCE, if so, it will
> lose the load balance chance at exec/fork/wake_affine points.

> But actually, even the node distance is farther than REMOTE_DISTANCE,
> Modern CPUs also has QPI like connections, that make memory access is

    "Is" not needed here.

> not too slow between nodes.  So above losing on NUMA machine make a
> huge performance regression on benchmark: hackbench, tbench, netperf
> and oltp etc.

> This patch will recover the scheduler behavior to old mode on all my
> Intel platforms: NHM EP/EX, WSM EP, SNB EP/EP4S, and so remove the
> perfromance regressions. (all of them just has 2 kinds distance, 10 21)

> Signed-off-by: Alex Shi<alex.shi@intel.com>

WBR, Sergei
