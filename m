Return-Path: <hpa@zytor.com>
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2001:1868:205::10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 954011007D8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2012 20:24:14 +1100 (EST)
References: <20111214181545.6e13bc954cb7ddce9086e861@canb.auug.org.au>
 <1323880322.23971.33.camel@gandalf.stny.rr.com> <4EE8D305.8020407@zytor.com>
 <20111222163304.26be6d0f5e514fefb078c0a6@canb.auug.org.au>
 <20120104190613.2e76daaa000ccf61121fdcc1@canb.auug.org.au>
In-Reply-To: <20120104190613.2e76daaa000ccf61121fdcc1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: linux-next: build warnings after merge of the final tree
From: "hpanvin@gmail.com" <hpa@zytor.com>
Date: Wed, 04 Jan 2012 01:23:11 -0800
To: Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <f5643ab8-9ba0-4ee6-b61e-403f03525a46@email.android.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, linux-next@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I thought it had been...?  Need to investigate (as baby permits...)

Stephen Rothwell <sfr@canb.auug.org.au> wrote:

>Hi again,
>
>On Thu, 22 Dec 2011 16:33:04 +1100 Stephen Rothwell
><sfr@canb.auug.org.au> wrote:
>>
>> On Wed, 14 Dec 2011 08:47:01 -0800 "H. Peter Anvin" <hpa@zytor.com>
>wrote:
>> >
>> > On 12/14/2011 08:32 AM, Steven Rostedt wrote:
>> > > On Wed, 2011-12-14 at 18:15 +1100, Stephen Rothwell wrote:
>> > > 
>> > >> Maybe caused by commit d5e553d6e0a4 ("trace: Include
><asm/asm-offsets.h>
>> > >> in trace_syscalls.c") from the tip tree.  These warnings may
>have been
>> > >> here for a while as it is hard to catch the new ones among the
>flood.
>> > >>
>> > > 
>> > > hpa,
>> > > 
>> > > Was this change only needed for x86? If so, could you put that
>into
>> > > asm/ftrace.h instead?
>> > 
>> > Yes (on both accounts).  It was part of the syscall changes; I'll
>move
>> > the include.
>> 
>> Ping?
>
>Can we please have this fixed ...
>-- 
>Cheers,
>Stephen Rothwell                    sfr@canb.auug.org.au
>http://www.canb.auug.org.au/~sfr/

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
