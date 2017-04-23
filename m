Return-Path: <yao.jin@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w9jW85jc9zDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Apr 2017 18:36:36 +1000 (AEST)
Subject: Re: [PATCH v6 0/7] perf report: Show branch type
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
 mingo@redhat.com, alexander.shishkin@linux.intel.com,
 Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
 yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org
References: <1492690075-17243-1-git-send-email-yao.jin@linux.intel.com>
 <20170420093656.GA28272@krava>
From: "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <201ae5e4-6cbe-532a-8377-55649349bd83@linux.intel.com>
Date: Sun, 23 Apr 2017 16:36:30 +0800
MIME-Version: 1.0
In-Reply-To: <20170420093656.GA28272@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 4/20/2017 5:36 PM, Jiri Olsa wrote:
> On Thu, Apr 20, 2017 at 08:07:48PM +0800, Jin Yao wrote:
>> v6:
>>     Update according to the review comments from
>>     Jiri Olsa <jolsa@redhat.com>. Major modifications are:
>>
>>     1. Move that multiline conditional code inside {} brackets.
>>
>>     2. Move branch_type_stat_display() from builtin-report.c to
>>        branch.c. Move branch_type_str() from callchain.c to
>>        branch.c.
>>
>>     3. Keep the original branch info display order, that is:
>>        predicted, abort, cycles, iterations
> for the tools part
>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
>
> thanks,
> jirka

Thanks so much!

Is the kernel part OK?

Thanks
Jin Yao
