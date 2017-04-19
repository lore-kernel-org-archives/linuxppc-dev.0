Return-Path: <yao.jin@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w739P1xJRzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 10:42:01 +1000 (AEST)
Subject: Re: [PATCH v4 4/5] perf report: Show branch type statistics for stdio
 mode
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
 mingo@redhat.com, alexander.shishkin@linux.intel.com,
 Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
 yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org
References: <1491949266-6835-1-git-send-email-yao.jin@linux.intel.com>
 <1491949266-6835-5-git-send-email-yao.jin@linux.intel.com>
 <20170418185337.GD15584@krava>
From: "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <a3df40fc-576a-7f3f-3eb6-8e8e29fdd3a3@linux.intel.com>
Date: Wed, 19 Apr 2017 08:41:56 +0800
MIME-Version: 1.0
In-Reply-To: <20170418185337.GD15584@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 4/19/2017 2:53 AM, Jiri Olsa wrote:
> On Wed, Apr 12, 2017 at 06:21:05AM +0800, Jin Yao wrote:
>
> SNIP
>
>> +static int hist_iter__branch_callback(struct hist_entry_iter *iter,
>> +				      struct addr_location *al __maybe_unused,
>> +				      bool single __maybe_unused,
>> +				      void *arg)
>> +{
>> +	struct hist_entry *he = iter->he;
>> +	struct report *rep = arg;
>> +	struct branch_info *bi;
>> +
>> +	if (sort__mode == SORT_MODE__BRANCH) {
> is this check necessary? the hist_iter__branch_callback
> was set based on this check
>
> jirka

Let me double check.

Thanks
Jin Yao
