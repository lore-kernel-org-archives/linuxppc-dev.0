Return-Path: <SRS0=MqA1=34=goodmis.org=rostedt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w80KN3yxgzDqKB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 23:37:12 +1000 (AEST)
Date: Thu, 20 Apr 2017 09:37:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tyrel Datwyler <turtle.in.the.kernel@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Frank Rowand
 <frowand.list@gmail.com>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 robh+dt@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 nfont@linux.vnet.ibm.com, mingo@redhat.com
Subject: Re: [PATCH] of: introduce event tracepoints for dynamic device_node
 lifecyle
Message-ID: <20170420093704.577f262d@gandalf.local.home>
In-Reply-To: <90e008a7-0660-99b9-edbe-6bf146268ba8@gmail.com>
References: <1492475525-10827-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <58F6AA35.2040902@gmail.com>
 <87efwp6v4e.fsf@concordia.ellerman.id.au>
 <1d51a229-612b-bf09-93d5-6e43b476e2cf@gmail.com>
 <20170419223342.0bbe2593@grimm.local.home>
 <90e008a7-0660-99b9-edbe-6bf146268ba8@gmail.com>
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

On Wed, 19 Apr 2017 22:24:58 -0700
Tyrel Datwyler <turtle.in.the.kernel@gmail.com> wrote:

> On 04/19/2017 07:33 PM, Steven Rostedt wrote:
> > On Wed, 19 Apr 2017 16:27:10 -0700
> > Tyrel Datwyler <turtle.in.the.kernel@gmail.com> wrote:
> >   
> >> # echo stacktrace > /sys/kernel/debug/tracing/trace_options
> >> # cat trace | grep -A6 "/pci@800000020000018"  
> > 
> > Just to let you know that there is now stacktrace event triggers, where
> > you don't need to stacktrace all events, you can pick and choose. And
> > even filter the stack trace on specific fields of the event.  
> 
> This is great, and I did figure that out this afternoon. One thing I was
> still trying to determine though was whether its possible to set these
> triggers at boot? As far as I could tell I'm still limited to
> "trace_options=stacktrace" as a kernel boot parameter to get the stack
> for event tracepoints.

No not yet. But I'll add that to the todo list.

Thanks,

-- Steve
