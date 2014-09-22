Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 666131A00C1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Sep 2014 00:43:59 +1000 (EST)
Date: Mon, 22 Sep 2014 16:43:19 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 00/10] Add support for parameterized events from sysfs
Message-ID: <20140922144318.GG18187@krava.brq.redhat.com>
References: <1410979923-7722-1-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1410979923-7722-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: ak@linux.intel.com, Michael Ellerman <michaele@au1.ibm.com>,
 peterz@infradead.org, linux-kernel@vger.kernel.org, eranian@google.com,
 dev@codyps.com, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 17, 2014 at 11:51:53AM -0700, Sukadev Bhattiprolu wrote:

SNIP

> 
> 	This means that when provided as an event, a value for
> 	phys_processor_idx must also be supplied. For example:
> 
> 	  perf stat -e 'hv_gpci/dtbp_ptitc,phys_processor_idx=0x2/' ...
> 
> Changelog[v3]
> 	- [Jiri Olsa] Changed the event parameters are specified. If
> 	  event file specifes 'param=val' make the usage 'param=123'
> 	  rather than 'val=123'. (patch 1,2/10)
> 	- Shortened event names using "PHYS" and "VCPU" (patch 4/10)
> 	- Print help message if invalid parameter is specified or required
> 	  parameter is missing.
> 	- Moved 3 patches that are unrelated to parametrized events into
> 	  a separate patchset.
> 	- Reordered patches so code changes come first.

hi,
Could you please rebase to latest acme/perf/core?
There were some changes in util/pmu.c conflicting with yours..

thanks,
jirka
