Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjp3K6Wh9zDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 02:38:37 +1000 (AEST)
Date: Thu, 31 Aug 2017 13:38:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Anton Blanchard <anton@au1.ibm.com>, Jiri Olsa <jolsa@redhat.com>,
 mpetlan@redhat.com, Michael Ellerman <mpe@ellerman.id.au>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Andi Kleen <andi@firstfloor.org>
Subject: Re: [GIT PULL] Please pull JSON files for POWER9 PMU events
Message-ID: <20170831163833.GG4831@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170830231506.GB20351@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Wed, Aug 30, 2017 at 04:15:06PM -0700, Sukadev Bhattiprolu escreveu:
> 
> Hi Arnaldo,
> 
> Please pull an update to the JSON files for POWER9 PMU events. This
> removes alternate event codes from the JSON files which seem to confuse
> perf.
> 
> The following changes since commit 1b2f76d77a277bb70d38ad0991ed7f16bbc115a9:

Thanks, applied and added the CCed people to CC lines in the cset
comment, also added Andi to that CC list.

- Arnaldo
 
>   Merge tag 'perf-core-for-mingo-4.14-20170829' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2017-08-29 23:13:56 +0200)
> 
> are available in the git repository at:
> 
>   https://github.com/sukadev/linux/ p9-json-v3
> 
> Sukadev Bhattiprolu (1):
>       perf vendor events powerpc: remove duplicate events
> 
>  .../pmu-events/arch/powerpc/power9/frontend.json   |    7 +-
>  .../perf/pmu-events/arch/powerpc/power9/other.json |  120 --------------------
>  .../pmu-events/arch/powerpc/power9/pipeline.json   |    7 +-
>  tools/perf/pmu-events/arch/powerpc/power9/pmc.json |    7 +-
>  4 files changed, 3 insertions(+), 138 deletions(-)
