Return-Path: <rostedt@goodmis.org>
Received: from smtprelay.hostedemail.com (smtprelay0054.hostedemail.com
 [216.40.44.54])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 38FAF1A0E61
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Dec 2015 12:21:16 +1100 (AEDT)
Date: Tue, 8 Dec 2015 20:21:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 chuhu@redhat.com
Subject: Re: [RFC][PATCH] ppc: Implement save_stack_trace_regs()
Message-ID: <20151208202111.79d60550@gandalf.local.home>
In-Reply-To: <1449622985.6028.8.camel@ellerman.id.au>
References: <20151208135056.718b7668@gandalf.local.home>
 <1449620422.6028.6.camel@ellerman.id.au>
 <20151208192844.70fb33e6@gandalf.local.home>
 <1449622985.6028.8.camel@ellerman.id.au>
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

On Wed, 09 Dec 2015 12:03:05 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:


> Looks like we actually have:
> 
>   #define kernel_stack_pointer(regs) ((regs)->gpr[1])
> 
> So that would be the most self documenting way to do it I guess, though I've
> never actually seen that macro used anywhere before :)

Cool, throw that in, and then it will be the first for you ;-)

-- Steve
