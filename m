Return-Path: <rostedt@goodmis.org>
Received: from smtprelay.hostedemail.com (smtprelay0042.hostedemail.com
 [216.40.44.42])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8AAE71A0202
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 01:57:35 +1100 (AEDT)
Date: Mon, 11 Jan 2016 09:57:29 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 chuhu@redhat.com
Subject: Re: [RFC][PATCH] ppc: Implement save_stack_trace_regs()
Message-ID: <20160111095729.77efd8e5@gandalf.local.home>
In-Reply-To: <1452483031.31943.6.camel@ellerman.id.au>
References: <20151208135056.718b7668@gandalf.local.home>
 <1449620422.6028.6.camel@ellerman.id.au>
 <20151208192844.70fb33e6@gandalf.local.home>
 <1449622985.6028.8.camel@ellerman.id.au>
 <20151216122419.385f1306@gandalf.local.home>
 <20160108175053.04e4296f@gandalf.local.home>
 <1452483031.31943.6.camel@ellerman.id.au>
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

On Mon, 11 Jan 2016 14:30:31 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

 
> Sorry, yep I'll take it.
> 
> I trimmed the change log a bit, final version below.
> 
> cheers
>

Thanks, appreciate it!

-- Steve
