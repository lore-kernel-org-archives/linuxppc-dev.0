Return-Path: <ak@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by lists.ozlabs.org (Postfix) with ESMTP id A4DF21A0E05
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 00:40:10 +1000 (AEST)
Date: Wed, 27 May 2015 07:40:07 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, mingo@redhat.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] perf: jevents: Program to convert JSON file to C
 style file
Message-ID: <20150527144007.GL7484@tassilo.jf.intel.com>
References: <1432080130-6678-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1432080130-6678-3-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150527135402.GA29557@danjae.kornet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150527135402.GA29557@danjae.kornet>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> So we build tables of all models in the architecture, and choose
> matching one when compiling perf, right?  Can't we do that when
> building the tables?  IOW, why don't we check the VFM and discard
> non-matching tables?  Those non-matching tables are also needed?

We build it for all cpus in an architecture, not all architectures.
So e.g. for an x86 binary power is not included, and vice versa.
It always includes all CPUs for a given architecture, so it's possible
to use the perf binary on other systems than just the one it was 
build on.

-andi

-- 
ak@linux.intel.com -- Speaking for myself only
