Return-Path: <yao.jin@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2Q6062rNzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 21:37:59 +1000 (AEST)
Subject: Re: [PATCH v3 2/5] perf/x86/intel: Record branch type
To: Peter Zijlstra <peterz@infradead.org>
Cc: acme@kernel.org, jolsa@kernel.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
 ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
 linuxppc-dev@lists.ozlabs.org, Thomas Gleixner <tglx@linutronix.de>
References: <1491908193-25418-1-git-send-email-yao.jin@linux.intel.com>
 <1491908193-25418-3-git-send-email-yao.jin@linux.intel.com>
 <20170411075219.bcteozodfkmwo45f@hirez.programming.kicks-ass.net>
 <eff40b15-0da5-f573-1716-d9732ea1fd36@linux.intel.com>
 <20170411083521.rlnkfz326rwpzs3k@hirez.programming.kicks-ass.net>
From: "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <4fd82c89-5986-1c4b-2195-a9d0e7245b04@linux.intel.com>
Date: Tue, 11 Apr 2017 19:37:53 +0800
MIME-Version: 1.0
In-Reply-To: <20170411083521.rlnkfz326rwpzs3k@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 4/11/2017 4:35 PM, Peter Zijlstra wrote:
> On Tue, Apr 11, 2017 at 04:11:21PM +0800, Jin, Yao wrote:
>>
>> On 4/11/2017 3:52 PM, Peter Zijlstra wrote:
>>> This is still a completely inadequate changelog. I really will not
>>> accept patches like this.
>>>
>> Hi,
>>
>> The changelog is added in the cover-letter ("[PATCH v3 0/5] perf report: Show branch type").
>>
>> Does the changelog need to be added in each patch's description?
>>
>> That's fine, I can add and resend this patch.
> The cover letter is not retained; it is throw away information.
>
> Each patch should have a coherent changelog that explain why the patch
> was done and explain non trivial things in the implementation.
>
> Simply copy/pasting the same story in multiple patches is not right
> either, for the simple fact that the patches were not the same. You did
> a different thing, so you need a different story.
>
>
>
Thanks so much for the suggestion!

I accept this and decide to make changes on my patch description. Maybe 
not adding a full change-log, I will add a section in patch description 
to describe the major changes from previous version.

Thanks
Jin Yao
