Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id 0C35CB70F4
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Nov 2010 01:24:38 +1100 (EST)
Received: from hrndva-omtalb.mail.rr.com ([10.128.143.52])
	by hrndva-qmta01.mail.rr.com with ESMTP
	id <20101108141945848.EXNX7732@hrndva-qmta01.mail.rr.com>
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Nov 2010 14:19:45 +0000
Subject: Re: [PATCH] powerpc: Add jump label support
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <45fbc3cd7f6ce404d1e25bf01695fb629d86189d.1289189560.git.michael@ellerman.id.au>
References: <45fbc3cd7f6ce404d1e25bf01695fb629d86189d.1289189560.git.michael@ellerman.id.au>
Content-Type: text/plain; charset="ISO-8859-15"
Date: Mon, 08 Nov 2010 09:18:35 -0500
Message-ID: <1289225915.12418.2.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Cc: Kumar Gala <kumar.gala@freescale.com>, linux-kernel@vger.kernel.org, "David
	S.Miller" <davem@davemloft.net>, linuxppc-dev@ozlabs.org,
	Anton Blanchard <anton@samba.org>, jbaron@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-11-08 at 15:12 +1100, Michael Ellerman wrote:
> This patch adds support for the new "jump label" feature.

Darn it! I wanted to port this!!!

;-)

> 
> Built for 64 & 32 bit, tested on 64 bit. Survives a kernel build under
> perf with all tracepoints enabled, and manual inspection of the patched
> code looks right. But still, lightly tested, YMMV.
> 
> Unlike x86 and sparc we just merrily patch the code with no locks etc,
> as far as I know this is safe, but I'm not really sure what the x86/sparc
> code is protecting against so maybe it's not.

Thanks, I'll give it a test on my electra as soon as I get a gcc 4.5.1
cross compiler working.

-- Steve
