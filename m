Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYr9N1NlwzDsW3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 15:45:11 +1000 (AEST)
Received: by mail-wm0-x241.google.com with SMTP id b184so797640wma.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 22:45:11 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 14 Sep 2016 07:45:03 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, mingo@redhat.com,
 Arnaldo Carvalho de Melo <acme@kernel.org>, peterz@infradead.org,
 maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@infradead.org>
Subject: Re: [PATCH v20 00/20] perf, tools: Add support for PMU events in
 JSON format
Message-ID: <20160914054503.GA31616@gmail.com>
References: <1466481770-25290-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <20160831114254.GA9001@krava>
 <20160831144247.GV3078@tassilo.jf.intel.com>
 <20160831145459.GA32396@krava>
 <20160831161530.GW3078@tassilo.jf.intel.com>
 <20160901064613.GA17731@krava>
 <871t0np7qj.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <871t0np7qj.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Michael Ellerman <mpe@ellerman.id.au> wrote:

> Jiri Olsa <jolsa@redhat.com> writes:
> 
> > On Wed, Aug 31, 2016 at 09:15:30AM -0700, Andi Kleen wrote:
> >> > > 
> >> > > > 
> >> > > > I've already made some changes in pmu-events/* to support
> >> > > > this hierarchy to see how bad the change would be.. and
> >> > > > it's not that bad ;-)
> >> > > 
> >> > > Everything has to be automated, please no manual changes.
> >> > 
> >> > sure
> >> > 
> >> > so, if you're ok with the layout, how do you want to proceed further?
> >> 
> >> If the split version is acceptable it's fine for me to merge it.
> >> 
> >> I'll add split-json to my scripting, so the next update would
> >> be split too.
> >
> > ook, I'll wait for patches then
> 
> Who are you waiting for patches from?
> 
> Would be great if this could go in for 4.9 still.

No objections from me - the latest bits were good:

  Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
