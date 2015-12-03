Return-Path: <ak@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by lists.ozlabs.org (Postfix) with ESMTP id AE2B71A04EB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Dec 2015 08:02:33 +1100 (AEDT)
Date: Thu, 3 Dec 2015 13:02:30 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: mingo@redhat.com, Michael Ellerman <mpe@ellerman.id.au>,
 Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, namhyung@kernel.org,
 maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v19 00/19] perf, tools: Add support for PMU events in
 JSON format
Message-ID: <20151203210230.GC18534@tassilo.jf.intel.com>
References: <1448938635-29176-1-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1448938635-29176-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 30, 2015 at 06:56:55PM -0800, Sukadev Bhattiprolu wrote:
> CPUs support a large number of performance monitoring events (PMU events)
> and often these events are very specific to an architecture/model of the
> CPU. To use most of these PMU events with perf, we currently have to identify
> them by their raw codes:

Could this patch be merged please? I'm not aware of any open objection to it,
and it has been already extensively reviewed in the past.

Full event lists are very useful for people. Also there are additional
changes (uncore event lists) which are blocked on these patches getting
merged.

Thanks,
-Andi
