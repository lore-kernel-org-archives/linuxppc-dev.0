Return-Path: <shaohua.li@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 7E908B7087
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Aug 2009 12:08:56 +1000 (EST)
Date: Thu, 6 Aug 2009 09:58:55 +0800
From: Shaohua Li <shaohua.li@intel.com>
To: Gautham R Shenoy <ego@in.ibm.com>
Subject: Re: [PATCH 0/3] cpu: idle state framework for offline CPUs.
Message-ID: <20090806015855.GA20596@sli10-desk.sh.intel.com>
References: <20090805142311.553.78286.stgit@sofia.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090805142311.553.78286.stgit@sofia.in.ibm.com>
Cc: "Brown, Len" <len.brown@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
	Ingo Molnar <mingo@elte.hu>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"Darrick J. Wong" <djwong@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Wed, Aug 05, 2009 at 10:25:53PM +0800, Gautham R Shenoy wrote:
> In this patch-series, we propose to extend the CPU-Hotplug infrastructure
> and allow the system administrator to choose the desired state the CPU should
> go to when it is offlined. We think this approach addresses the concerns about
> determinism as well as transparency, since CPU-Hotplug already provides
> notification mechanism which the userspace can listen to for any change
> in the configuration and correspondingly readjust any previously set
> cpu-affinities.
Peter dislikes any approach (including cpuhotplug) which breaks userspace policy,
even userspace can get a notification.

> Also, approaches such as [1] can make use of this
> extended infrastructure instead of putting the CPU to an arbitrary C-state
> when it is offlined, thereby providing the system administrator a rope to hang
> himself with should he feel the need to do so.
I didn't see the reason why administrator needs to know which state offline cpu
should stay. Don't know about powerpc side, but in x86 side, it appears deepest
C-state is already preferred.

Thanks,
Shaohua
