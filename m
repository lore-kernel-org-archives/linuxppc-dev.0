Return-Path: <hpa@zytor.com>
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2001:1868:205::10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AC15B1007D6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2011 03:47:41 +1100 (EST)
Message-ID: <4EE8D305.8020407@zytor.com>
Date: Wed, 14 Dec 2011 08:47:01 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: linux-next: build warnings after merge of the final tree
References: <20111214181545.6e13bc954cb7ddce9086e861@canb.auug.org.au>
 <1323880322.23971.33.camel@gandalf.stny.rr.com>
In-Reply-To: <1323880322.23971.33.camel@gandalf.stny.rr.com>
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/14/2011 08:32 AM, Steven Rostedt wrote:
> On Wed, 2011-12-14 at 18:15 +1100, Stephen Rothwell wrote:
> 
>> Maybe caused by commit d5e553d6e0a4 ("trace: Include <asm/asm-offsets.h>
>> in trace_syscalls.c") from the tip tree.  These warnings may have been
>> here for a while as it is hard to catch the new ones among the flood.
>>
> 
> hpa,
> 
> Was this change only needed for x86? If so, could you put that into
> asm/ftrace.h instead?
> 

Yes (on both accounts).  It was part of the syscall changes; I'll move
the include.

	-hpa


-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
