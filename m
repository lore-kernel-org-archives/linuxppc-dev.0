Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401kCj3gRTzDr2Z
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 07:41:34 +1100 (AEDT)
Date: Wed, 14 Mar 2018 17:41:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>
Subject: Re: [GIT PULL] Please pull JSON files for POWR9 PMU events
Message-ID: <20180314204129.GH27335@kernel.org>
References: <20180313224647.GA22960@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180313224647.GA22960@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Tue, Mar 13, 2018 at 03:46:47PM -0700, Sukadev Bhattiprolu escreveu:
> 
> Hi Arnaldo,
> 
> Please pull an update to the JSON files for POWER9 PMU events.

Can you please be a bit more verbose in the next pull requets, something
like describing what is the nature of this specific pull request, say it
is to better support some specific measurements, etc, so that people
don't have to go and peruse the patches looking for what has changed.

If you could even show it being used and drawind some interesting
conclusion, even better. Or point to documentation describing it being
used, a blog post, whatever that clarifies these updates and encourages
potential users to try the perf tools with those events.

- Arnaldo
 
> The following changes since commit 90d2614c4d10c2f9d0ada9a3b01e5f43ca8d1ae3:
> 
>   perf test: Fix exit code for record+probe_libc_inet_pton.sh (2018-03-13 15:14:43 -0300)
> 
> are available in the git repository at:
> 
>   https://github.com/sukadev/linux/ p9-json-v5
> 
> for you to fetch changes up to 99c9dff949f2502964005f9afa8d60c89b446f2c:
> 
>   perf vendor events: Update POWER9 events (2018-03-13 16:48:12 -0500)
> 
> ----------------------------------------------------------------
> Sukadev Bhattiprolu (1):
>       perf vendor events: Update POWER9 events
> 
>  .../perf/pmu-events/arch/powerpc/power9/cache.json |  25 ---
>  .../pmu-events/arch/powerpc/power9/frontend.json   |  10 -
>  .../pmu-events/arch/powerpc/power9/marked.json     |   5 -
>  .../pmu-events/arch/powerpc/power9/memory.json     |   5 -
>  .../perf/pmu-events/arch/powerpc/power9/other.json | 241 ++++++++++++++-------
>  .../pmu-events/arch/powerpc/power9/pipeline.json   |  50 ++---
>  tools/perf/pmu-events/arch/powerpc/power9/pmc.json |   5 -
>  .../arch/powerpc/power9/translation.json           |  10 +-
>  8 files changed, 178 insertions(+), 173 deletions(-)
