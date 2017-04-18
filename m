Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6vRX0MFnzDq9B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 04:53:44 +1000 (AEST)
Date: Tue, 18 Apr 2017 20:53:37 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Jin Yao <yao.jin@linux.intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
 mingo@redhat.com, alexander.shishkin@linux.intel.com,
 Linux-kernel@vger.kernel.org, ak@linux.intel.com,
 kan.liang@intel.com, yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 4/5] perf report: Show branch type statistics for
 stdio mode
Message-ID: <20170418185337.GD15584@krava>
References: <1491949266-6835-1-git-send-email-yao.jin@linux.intel.com>
 <1491949266-6835-5-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491949266-6835-5-git-send-email-yao.jin@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 12, 2017 at 06:21:05AM +0800, Jin Yao wrote:

SNIP

> +static int hist_iter__branch_callback(struct hist_entry_iter *iter,
> +				      struct addr_location *al __maybe_unused,
> +				      bool single __maybe_unused,
> +				      void *arg)
> +{
> +	struct hist_entry *he = iter->he;
> +	struct report *rep = arg;
> +	struct branch_info *bi;
> +
> +	if (sort__mode == SORT_MODE__BRANCH) {

is this check necessary? the hist_iter__branch_callback
was set based on this check

jirka
