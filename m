Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18723.64019.500474.586671@cargo.ozlabs.ibm.com>
Date: Wed, 19 Nov 2008 22:35:47 +1100
From: Paul Mackerras <paulus@samba.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/7] Porting dynmaic ftrace to PowerPC
In-Reply-To: <20081119105719.GA21533@elte.hu>
References: <20081116212428.938752312@goodmis.org>
	<18720.42209.880409.297291@cargo.ozlabs.ibm.com>
	<alpine.DEB.1.10.0811171035530.2919@gandalf.stny.rr.com>
	<alpine.DEB.1.10.0811180853390.15003@gandalf.stny.rr.com>
	<18723.31762.522696.647294@cargo.ozlabs.ibm.com>
	<alpine.DEB.1.10.0811182150530.14914@gandalf.stny.rr.com>
	<20081119092723.GC22309@elte.hu>
	<18723.60578.179210.736789@cargo.ozlabs.ibm.com>
	<20081119105719.GA21533@elte.hu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ingo Molnar writes:

> and it's all in flux (we are in the middle of the development cycle), 
> so i dont think it would be a good idea for you to pull those bits 
> into the powerpc tree.

Quite.  OK, it does sound like this stuff needs to live in your tree
for now, and from the diffstat it doesn't look like there is any
conflict with stuff in my tree yet.

> Maybe Steve could do the following trick: create a Linus -git based 
> branch that uses the new APIs but marks ppc's ftrace as "depends 0" in 
> the powerpc Kconfig. (the new ftrace.c wont build)
> 
> You could pull that tree into the powerpc tree and everything should 
> still work fine in PPC - sans ftrace.

Sounds like a reasonable idea, except that I think I'll delay pulling
that branch into my tree until I need to in order to resolve a
conflict - at least as far as my exported branches are concerned.

> In tip/tracing we'd merge it too (these commits will never be 
> rebased),

I do want to see the patches in their final form and have the
opportunity to give an acked-by before you declare the branch frozen.
Apart from that, sounds good.

Paul.
