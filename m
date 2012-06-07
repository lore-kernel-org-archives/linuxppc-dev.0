Return-Path: <alex.shi@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by ozlabs.org (Postfix) with ESMTP id E0FF8B6FB4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2012 10:35:24 +1000 (EST)
Message-ID: <4FCFF6D8.70507@intel.com>
Date: Thu, 07 Jun 2012 08:33:28 +0800
From: Alex Shi <alex.shi@intel.com>
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [RFC PATCH] sched/numa: do load balance between remote nodes
References: <1338965571-9812-1-git-send-email-alex.shi@intel.com>
 <1338973295.2749.81.camel@twins>
In-Reply-To: <1338973295.2749.81.camel@twins>
Content-Type: text/plain; charset=ISO-8859-1
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

On 06/06/2012 05:01 PM, Peter Zijlstra wrote:

> On Wed, 2012-06-06 at 14:52 +0800, Alex Shi wrote:
>> -       if (sched_domains_numa_distance[level] > REMOTE_DISTANCE)
>> +       if (sched_domains_numa_distance[level] > RECLAIM_DISTANCE) 
> 
> I actually considered this.. I just felt a little uneasy re-purposing
> the RECLAIM_DISTANCE for this, but I guess its all the same anyway. Both
> mean expensive-away-distance.
> 


I understand you, the BIOS guys don't have a good alignment with us on
this.

> So I've taken this.
> 
> thanks!
