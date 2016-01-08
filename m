Return-Path: <rostedt@goodmis.org>
Received: from smtprelay.hostedemail.com (smtprelay0161.hostedemail.com
 [216.40.44.161])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6C0C31A0007
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jan 2016 09:51:01 +1100 (AEDT)
Date: Fri, 8 Jan 2016 17:50:53 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 chuhu@redhat.com
Subject: Re: [RFC][PATCH] ppc: Implement save_stack_trace_regs()
Message-ID: <20160108175053.04e4296f@gandalf.local.home>
In-Reply-To: <20151216122419.385f1306@gandalf.local.home>
References: <20151208135056.718b7668@gandalf.local.home>
 <1449620422.6028.6.camel@ellerman.id.au>
 <20151208192844.70fb33e6@gandalf.local.home>
 <1449622985.6028.8.camel@ellerman.id.au>
 <20151216122419.385f1306@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 16 Dec 2015 12:24:19 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 09 Dec 2015 12:03:05 +1100
> Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
> > > > Should I take this via powerpc or do you want it to go in via tracing?    
> > > 
> > > You can take it. And you can replace the PT_R1 if you want. I just
> > > noticed that it was defined, and I try to use macro names instead of
> > > hard coded numbers. I was actually looking for a "PT_SP" :-)    
> > 
> > OK thanks.
> > 
> > Looks like we actually have:
> > 
> >   #define kernel_stack_pointer(regs) ((regs)->gpr[1])
> > 
> > So that would be the most self documenting way to do it I guess, though I've
> > never actually seen that macro used anywhere before :)  
> 
> Hi,
> 
> Are you going to take this, or do you want me to?
> 
> -- Steve

Ping?

-- Steve
