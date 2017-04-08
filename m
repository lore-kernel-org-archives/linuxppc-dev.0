Return-Path: <yao.jin@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w0VRb204TzDqHq
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Apr 2017 18:46:34 +1000 (AEST)
Subject: Re: [PATCH v2 2/5] perf/x86/intel: Record branch type
To: Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>
Cc: acme@kernel.org, jolsa@kernel.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
 kan.liang@intel.com, yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org
References: <1491562066-7472-1-git-send-email-yao.jin@linux.intel.com>
 <1491562066-7472-3-git-send-email-yao.jin@linux.intel.com>
 <20170407152031.k2auigfkj7ek4suo@hirez.programming.kicks-ass.net>
 <20170407164834.GA4021@tassilo.jf.intel.com>
 <20170407172024.r66fkp4xkux5blxi@hirez.programming.kicks-ass.net>
 <20170407175006.GB4021@tassilo.jf.intel.com>
From: "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <a3ef37a8-ab07-cce6-fbcf-f8fa11b03186@linux.intel.com>
Date: Sat, 8 Apr 2017 16:46:29 +0800
MIME-Version: 1.0
In-Reply-To: <20170407175006.GB4021@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Without this patch, we don't know if it's conditional or something else.
> And the kernel already knows this for its filtering, so it can as well
> report it.
>
> Right the CROSS_* and forward backward information could be computed
> later.
>
> -Andi
>
>
OK, I will move CROSS_* and JCC forward/backward computing to user-space though it makes user-space code to be complicated.

Thanks
Jin Yao
