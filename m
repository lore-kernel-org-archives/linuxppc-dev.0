Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3Ym96zw7zDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 18:26:33 +1000 (AEST)
Date: Thu, 13 Apr 2017 10:26:28 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: "Jin, Yao" <yao.jin@linux.intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
 mingo@redhat.com, alexander.shishkin@linux.intel.com,
 Linux-kernel@vger.kernel.org, ak@linux.intel.com,
 kan.liang@intel.com, yao.jin@intel.com,
 linuxppc-dev@lists.ozlabs.org, treeze.taeung@gmail.com
Subject: Re: [PATCH v4 0/5] perf report: Show branch type
Message-ID: <20170413082628.GB4784@krava>
References: <1491949266-6835-1-git-send-email-yao.jin@linux.intel.com>
 <20170412105839.GC14409@krava>
 <74ee84f8-e756-65d2-9ba4-b560f6e241bd@linux.intel.com>
 <c480d004-8a02-65fb-48b5-6db43b8efa4f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c480d004-8a02-65fb-48b5-6db43b8efa4f@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 13, 2017 at 11:25:39AM +0800, Jin, Yao wrote:

SNIP

> > 
> > Now it works without my patch and it runs with latest perf/core branch.
> > So it looks like a regression issue.
> > 
> > Thanks
> > Jin Yao
> > 
> > 
> 
> I have tested, the regression issue is happened after this commit:
> 
> bdd97ca perf tools: Refactor the code to strip command name with {l,r}trim()
> 
> CC to the author for double checking.

cool, thanks

jirka
