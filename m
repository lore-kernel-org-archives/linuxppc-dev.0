Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1E9FD1A0C10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 15:28:44 +1100 (AEDT)
Message-ID: <1422505723.6621.6.camel@ellerman.id.au>
Subject: Re: [PATCH v7 0/4] Add support for parametrized events
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Thu, 29 Jan 2015 15:28:43 +1100
In-Reply-To: <1422322990-9030-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1422322990-9030-1-git-send-email-sukadev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: peterz@infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>, dev@codyps.com,
 Jiri Olsa <jolsa@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-01-26 at 17:43 -0800, Sukadev Bhattiprolu wrote:
> Description of "event parameters" from the documentation patch:
> 
> Cody P Schafer (6):
>   perf: provide sysfs_show for struct perf_pmu_events_attr
>   perf: add PMU_EVENT_ATTR_STRING() helper
>   powerpc/perf/hv-24x7: parse catalog and populate sysfs with events
>   powerpc/perf/{hv-gpci, hv-common}: generate requests with counters
>     annotated
>   powerpc/perf/hv-gpci: add the remaining gpci requests
>   powerpc/perf/hv-24x7: Document sysfs event description entries
> 
> Sukadev Bhattiprolu (1):
>   perf: define EVENT_DEFINE_RANGE_FORMAT_LITE helper


Hi Sukadev,

I realise Cody wrote most of these and you are just getting them merged, but
they still need to be Signed-off-by you. Most of them aren't.

So please resend with them all signed off by you.

While you're at it, please drop all the CC lines, and move the changelog
annotations below the --- line so they are dropped when I apply them.

Also add Jiri's ack to the first two patches.

You can probably trim the CC list when you repost, I think everyone's seen this
series enough times.

cheers
