Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id DB4391007D3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2011 03:38:11 +1100 (EST)
Message-ID: <1323880322.23971.33.camel@gandalf.stny.rr.com>
Subject: Re: linux-next: build warnings after merge of the final tree
From: Steven Rostedt <rostedt@goodmis.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 14 Dec 2011 11:32:02 -0500
In-Reply-To: <20111214181545.6e13bc954cb7ddce9086e861@canb.auug.org.au>
References: <20111214181545.6e13bc954cb7ddce9086e861@canb.auug.org.au>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>, "H.
 Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-12-14 at 18:15 +1100, Stephen Rothwell wrote:

> Maybe caused by commit d5e553d6e0a4 ("trace: Include <asm/asm-offsets.h>
> in trace_syscalls.c") from the tip tree.  These warnings may have been
> here for a while as it is hard to catch the new ones among the flood.
> 

hpa,

Was this change only needed for x86? If so, could you put that into
asm/ftrace.h instead?

-- Steve
