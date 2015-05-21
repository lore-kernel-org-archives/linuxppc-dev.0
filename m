Return-Path: <ak@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by lists.ozlabs.org (Postfix) with ESMTP id 1A26C1A0B9E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2015 04:50:50 +1000 (AEST)
Date: Thu, 21 May 2015 11:50:48 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: mingo@redhat.com, Michael Ellerman <mpe@ellerman.id.au>,
 Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] perf: Use pmu_events_map table to create event aliases
Message-ID: <20150521185048.GF7484@tassilo.jf.intel.com>
References: <1432080130-6678-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1432080130-6678-4-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150520235826.GB7484@tassilo.jf.intel.com>
 <20150521001935.GD11568@us.ibm.com>
 <20150521025653.GC7484@tassilo.jf.intel.com>
 <20150521050204.GA20360@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150521050204.GA20360@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 20, 2015 at 10:02:04PM -0700, Sukadev Bhattiprolu wrote:
> Andi Kleen [ak@linux.intel.com] wrote:
> | If you need something else in vfm to identify the CPU 
> | can't you just add it there? I wouldn't really call it vfm, it's
> | really a "abstract cpu identifier per architecture". So if you
> | need pvr just add it there.
> 
> Ok. I will change vfm to cpuid_str and include pvr in it.

Thanks.

With that change it would be also cleaner to provide a get_cpuid_str()
function by the architecture code, and then strcmp in the matching
code, instead of having architecture specific compare code.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
