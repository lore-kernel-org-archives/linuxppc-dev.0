Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18723.60578.179210.736789@cargo.ozlabs.ibm.com>
Date: Wed, 19 Nov 2008 21:38:26 +1100
From: Paul Mackerras <paulus@samba.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/7] Porting dynmaic ftrace to PowerPC
In-Reply-To: <20081119092723.GC22309@elte.hu>
References: <20081116212428.938752312@goodmis.org>
	<18720.42209.880409.297291@cargo.ozlabs.ibm.com>
	<alpine.DEB.1.10.0811171035530.2919@gandalf.stny.rr.com>
	<alpine.DEB.1.10.0811180853390.15003@gandalf.stny.rr.com>
	<18723.31762.522696.647294@cargo.ozlabs.ibm.com>
	<alpine.DEB.1.10.0811182150530.14914@gandalf.stny.rr.com>
	<20081119092723.GC22309@elte.hu>
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

> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Wed, 19 Nov 2008, Paul Mackerras wrote:
> > 
> > > Steven Rostedt writes:
> > > 
> > > > Can I add your Acked-by: to all these patches that I submitted? I'm going 
> > > > to recommit them with a consistent subject (all lower case ppc), but I'm 
> > > > not going to change the patches themselves.
> > > > 
> > > > Would you two be fine with that? Or at least one of you?
> > > 
> > > My preference would be for the patches to go through the powerpc tree
> > > unless there is a good reason for them to go via another tree.
> > 
> > I have no problem with that. The only thing is that we have a lot of 
> > pending work still in the linux-tip tree, which you may need to pull 
> > in to get these patches working. Well, there's two or three commits 
> > in the generic code that I know the PPC code is dependent on.
> > 
> > I could give you a list of commits in tip that need to go mainline 
> > first before we can pull in the PPC changes. Then you could wait 
> > till those changes make it into 29 and then you could push the PPC 
> > modifications in from your tree.
> 
> note that this inserts a lot of (unnecessary) serialization and a 
> window of non-testing - by all likelyhood this will delay ppc ftrace 
> to v2.6.30 or later kernels.

Well, note that I said "unless there is a good reason".  If it does
need to go via your tree, it can, though I don't see that it will get
much testing on powerpc there, and having it there will make it harder
to manage any conflicts with the other stuff I have queued up.

How much generic stuff that's not upstream do the powerpc ftrace
patches depend on?

Paul.
