Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id 3097C1A0BB4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 23:48:11 +1000 (AEST)
Date: Thu, 25 Jun 2015 10:48:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
 Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>,
 He Kuang <hekuang@huawei.com>, Jiri Olsa <jolsa@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, Lukas Wunner <lukas@wunner.de>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Namhyung Kim <namhyung@kernel.org>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Stephane Eranian <eranian@google.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Wang Nan <wangnan0@huawei.com>
Subject: Re: [GIT PULL 00/13] perf/core improvements and fixes
Message-ID: <20150625134806.GC3253@kernel.org>
References: <1435096047-32088-1-git-send-email-acme@kernel.org>
 <20150625073141.GA12795@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150625073141.GA12795@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Thu, Jun 25, 2015 at 09:31:41AM +0200, Ingo Molnar escreveu:
> Pulled, thanks a lot Arnaldo!
> 
> Btw., one small thing I noticed about the status line in perf top: if I ever use 
> 'f' to freeze/unfreeze events, the following message:
> 
>   Press 'f' to disable the events or 'h' to see other hotkeys
> 
> sticks around forever, even after I look into annotation and exit it, etc.
 
> So I don't mind some default, helpful message there (such as 'Press 'h' to see 
> hotkeys'), but it appears this particular message is context and usage sensitive, 
> which wasn't really the goal, right?

Agreed, some more work is needed to change that message in more places,
will do it eventually.

- Arnaldo
