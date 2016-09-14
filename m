Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYl1w6mkhzDsTX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 11:53:24 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, mingo@redhat.com,
 Arnaldo Carvalho de Melo <acme@kernel.org>, peterz@infradead.org,
 maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v20 00/20] perf,
 tools: Add support for PMU events in JSON format
In-Reply-To: <20160901064613.GA17731@krava>
References: <1466481770-25290-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <20160831114254.GA9001@krava> <20160831144247.GV3078@tassilo.jf.intel.com>
 <20160831145459.GA32396@krava> <20160831161530.GW3078@tassilo.jf.intel.com>
 <20160901064613.GA17731@krava>
Date: Wed, 14 Sep 2016 11:53:24 +1000
Message-ID: <871t0np7qj.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jiri Olsa <jolsa@redhat.com> writes:

> On Wed, Aug 31, 2016 at 09:15:30AM -0700, Andi Kleen wrote:
>> > > 
>> > > > 
>> > > > I've already made some changes in pmu-events/* to support
>> > > > this hierarchy to see how bad the change would be.. and
>> > > > it's not that bad ;-)
>> > > 
>> > > Everything has to be automated, please no manual changes.
>> > 
>> > sure
>> > 
>> > so, if you're ok with the layout, how do you want to proceed further?
>> 
>> If the split version is acceptable it's fine for me to merge it.
>> 
>> I'll add split-json to my scripting, so the next update would
>> be split too.
>
> ook, I'll wait for patches then

Who are you waiting for patches from?

Would be great if this could go in for 4.9 still.

cheers
