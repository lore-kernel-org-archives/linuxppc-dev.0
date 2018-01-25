Return-Path: <SRS0=lhnB=EU=goodmis.org=rostedt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zRzg12P0wzDqxT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jan 2018 22:03:41 +1100 (AEDT)
Date: Thu, 25 Jan 2018 06:03:30 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Frank Rowand <frowand.list@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 devicetree@vger.kernel.org, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-renesas-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Rob
 Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/1] of: easier debugging for node life cycle issues
Message-ID: <20180125060330.781667e9@vmware.local.home>
In-Reply-To: <00fc90ee-de26-f819-9c81-27d06918564d@gmail.com>
References: <20180121143117.19805-1-wsa+renesas@sang-engineering.com>
 <00fc90ee-de26-f819-9c81-27d06918564d@gmail.com>
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

On Wed, 24 Jan 2018 22:55:13 -0800
Frank Rowand <frowand.list@gmail.com> wrote:

> Hi Steve,

> 
> Off the top of your head, can you tell me know early in the boot
> process a trace_event can be called and successfully provide the
> data to someone trying to debug early boot issues?

The trace events are enabled by early_initcall().

> 
> Also, way back when version 1 of this patch was being discussed,
> a question about stacktrace triggers:
> 
>      >>> # echo stacktrace > /sys/kernel/debug/tracing/trace_options
>      >>> # cat trace | grep -A6 "/pci@800000020000018"    
>      >>
>      >> Just to let you know that there is now stacktrace event triggers, where
>      >> you don't need to stacktrace all events, you can pick and choose. And
>      >> even filter the stack trace on specific fields of the event.    
>      >
>      > This is great, and I did figure that out this afternoon. One thing I was
>      > still trying to determine though was whether its possible to set these
>      > triggers at boot? As far as I could tell I'm still limited to
>      > "trace_options=stacktrace" as a kernel boot parameter to get the stack
>      > for event tracepoints.  
> 
>      No not yet. But I'll add that to the todo list.
> 
>      Thanks,
> 
>      -- Steve
> 
> Is this still on your todo list, or is it now available?

Still on the todo list. As someone once said, there really is no todo
list, but just work on the stuff that people are yelling the loudest
about. Yell louder, and it will get done quicker ;-)

-- Steve
