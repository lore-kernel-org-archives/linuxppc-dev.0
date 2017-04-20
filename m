Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7v0G0ckyzDqJx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 19:37:01 +1000 (AEST)
Date: Thu, 20 Apr 2017 11:36:56 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Jin Yao <yao.jin@linux.intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
 mingo@redhat.com, alexander.shishkin@linux.intel.com,
 Linux-kernel@vger.kernel.org, ak@linux.intel.com,
 kan.liang@intel.com, yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 0/7] perf report: Show branch type
Message-ID: <20170420093656.GA28272@krava>
References: <1492690075-17243-1-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1492690075-17243-1-git-send-email-yao.jin@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 20, 2017 at 08:07:48PM +0800, Jin Yao wrote:
> v6:
>    Update according to the review comments from
>    Jiri Olsa <jolsa@redhat.com>. Major modifications are: 
> 
>    1. Move that multiline conditional code inside {} brackets.
> 
>    2. Move branch_type_stat_display() from builtin-report.c to
>       branch.c. Move branch_type_str() from callchain.c to
>       branch.c.
> 
>    3. Keep the original branch info display order, that is:
>       predicted, abort, cycles, iterations

for the tools part

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
