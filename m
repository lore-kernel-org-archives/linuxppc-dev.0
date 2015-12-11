Return-Path: <rostedt@goodmis.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C4A251A1053
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Dec 2015 06:40:56 +1100 (AEDT)
Received: from smtprelay.hostedemail.com (smtprelay0158.hostedemail.com
 [216.40.44.158])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4E39B14031D
 for <linuxppc-dev@ozlabs.org>; Sat, 12 Dec 2015 06:40:56 +1100 (AEDT)
Date: Fri, 11 Dec 2015 14:40:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: introduce TRACE_EVENT_FN_COND macro
Message-ID: <20151211144044.0957c379@gandalf.local.home>
In-Reply-To: <CAOJe8K3wP_KT9XAOhduw35dD=QVaDUVBMi-jSeRDLGD+Zs-a-A@mail.gmail.com>
References: <1448389419-5296-1-git-send-email-kda@linux-powerpc.org>
 <CAOJe8K3wP_KT9XAOhduw35dD=QVaDUVBMi-jSeRDLGD+Zs-a-A@mail.gmail.com>
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

On Mon, 7 Dec 2015 17:42:42 +0300
Denis Kirjanov <kda@linux-powerpc.org> wrote:

> On 11/24/15, Denis Kirjanov <kda@linux-powerpc.org> wrote:
> > TRACE_EVENT_FN can't be used in some circumstances
> > like invoking trace functions from offlined CPU due
> > to RCU usage.
> >
> > This patch adds the TRACE_EVENT_FN_COND macro
> > to make such trace points conditional.
> >
> > Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>  
> 
> Hi Steven,
> are you going to take this series through your tree?
> 

I haven't gotten an ack for the powerpc side yet. I can take the
tracing patch, but I'm not pulling in powerpc without an ack from one
of the maintainers. Maybe I got it already, but I don't see it in my
INBOX in this thread.

-- Steve
