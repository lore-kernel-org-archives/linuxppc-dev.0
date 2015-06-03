Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F9A41A0E30
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 20:32:37 +1000 (AEST)
Date: Wed, 3 Jun 2015 12:32:30 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 12/14] perf, tools: Add support for event list topics
Message-ID: <20150603103229.GK1828@krava.redhat.com>
References: <1433265135-20426-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1433265135-20426-13-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150602191641.GA3978@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150602191641.GA3978@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 02, 2015 at 12:16:41PM -0700, Sukadev Bhattiprolu wrote:

SNIP

>        [Speculative and retired macro-conditional branches]
>   br_inst_exec.all_direct_jmp
>        [Speculative and retired macro-unconditional branches excluding calls and indirects]
>   br_inst_exec.all_direct_near_call
>        [Speculative and retired direct near calls]
>   br_inst_exec.all_indirect_jump_non_call_ret
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> 
> Changelog[v2]
> 	Dropped an unnecessary patch before this and fixed resulting
> 	conflicts in tools/perf/util/pmu.c
> ---
>  tools/perf/pmu-events/jevents.c    | 16 +++++++++++-----
>  tools/perf/pmu-events/jevents.h    |  3 ++-
>  tools/perf/pmu-events/pmu-events.h |  1 +
>  tools/perf/util/pmu.c              | 34 ++++++++++++++++++++++++----------
>  tools/perf/util/pmu.h              |  1 +
>  5 files changed, 39 insertions(+), 16 deletions(-)

please split at least the jevents Topic parsing from the rest
idelay also the alias update and the display change

jirka
