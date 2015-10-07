Return-Path: <mingo.kernel.org@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 803A51A0008
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2015 03:33:56 +1100 (AEDT)
Received: from mail-wi0-x235.google.com (mail-wi0-x235.google.com
 [IPv6:2a00:1450:400c:c05::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BE20D140D8B
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2015 03:33:55 +1100 (AEDT)
Received: by wicfx3 with SMTP id fx3so221073533wic.1
 for <linuxppc-dev@ozlabs.org>; Wed, 07 Oct 2015 09:33:51 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 7 Oct 2015 18:33:48 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
 Jiri Olsa <jolsa@kernel.org>, linuxppc-dev@ozlabs.org,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Stephane Eranian <eranian@google.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [GIT PULL 0/1] perf/urgent fix
Message-ID: <20151007163348.GA10371@gmail.com>
References: <1444232523-20638-1-git-send-email-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444232523-20638-1-git-send-email-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> The following changes since commit 097f70b3c4d84ffccca15195bdfde3a37c0a7c0f:
> 
>   Merge branch 'upstream' of git://git.linux-mips.org/pub/scm/ralf/upstream-linus (2015-09-27 18:22:34 -0400)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo
> 
> for you to fetch changes up to 9fb4765451f22c5e782c1590747717550bff34b2:
> 
>   perf tools: Fix build break on powerpc due to sample_reg_masks (2015-10-07 10:20:08 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fix:
> 
> - Fix build break on (at least) powerpc due to sample_reg_masks, not being
>   available for linking (Sukadev Bhattiprolu)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Sukadev Bhattiprolu (1):
>       perf tools: Fix build break on powerpc due to sample_reg_masks
> 
>  tools/perf/util/Build       | 2 +-
>  tools/perf/util/perf_regs.c | 2 ++
>  tools/perf/util/perf_regs.h | 1 +
>  3 files changed, 4 insertions(+), 1 deletion(-)

Pulled, thanks Arnaldo!

	Ingo
