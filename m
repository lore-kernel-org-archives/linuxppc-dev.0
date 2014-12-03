Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 692251A0251
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Dec 2014 17:18:54 +1100 (AEDT)
Message-ID: <1417587532.16722.12.camel@concordia>
Subject: Re: [PATCH v5 1/6] perf: provide sysfs_show for struct
 perf_pmu_events_attr
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Wed, 03 Dec 2014 17:18:52 +1100
In-Reply-To: <1417572235-8197-2-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1417572235-8197-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1417572235-8197-2-git-send-email-sukadev@linux.vnet.ibm.com>
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

On Tue, 2014-12-02 at 18:03 -0800, Sukadev Bhattiprolu wrote:
> From: Cody P Schafer <cody@linux.vnet.ibm.com>
> 
> (struct perf_pmu_events_attr) is defined in include/linux/perf_event.h,
> but the only "show" for it is in x86 and contains x86 specific stuff.
> 
> Make a generic one for those of us who are just using the event_str.
> 
> CC: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> CC: Haren Myneni <hbabu@us.ibm.com>
> CC: Cody P Schafer <dev@codyps.com>
> Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
> ---
>  include/linux/perf_event.h | 3 +++
>  kernel/events/core.c       | 8 ++++++++
>  2 files changed, 11 insertions(+)

Acme/Peterz, are you happy for us to take this series through the powerpc tree?
Do you want to give us an ack for patches 1 & 2?

cheers
