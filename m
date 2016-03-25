Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qWfYC6s1GzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Mar 2016 21:24:15 +1100 (AEDT)
Message-ID: <1458901449.30923.0.camel@ellerman.id.au>
Subject: Re: [PATCH 2/6] ftrace: Make ftrace_location_range() global
From: Michael Ellerman <mpe@ellerman.id.au>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linuxppc-dev@ozlabs.org, bsingharora@gmail.com, duwe@lst.de,
 linux-kernel@vger.kernel.org, kamalesh@linux.vnet.ibm.com,
 pmladek@suse.com,  jeyu@redhat.com, jkosina@suse.cz,
 live-patching@vger.kernel.org, mbenes@suse.cz
Date: Fri, 25 Mar 2016 21:24:09 +1100
In-Reply-To: <20160324112019.0a61e0b3@gandalf.local.home>
References: <1458817445-5855-1-git-send-email-mpe@ellerman.id.au>
 <1458817445-5855-2-git-send-email-mpe@ellerman.id.au>
 <20160324112019.0a61e0b3@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-03-24 at 11:20 -0400, Steven Rostedt wrote:

> On Thu, 24 Mar 2016 22:04:01 +1100
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> > In order to support live patching on powerpc we would like to call
> > ftrace_location_range(), so make it global.
>
> Do you want me to try to get this into this merge window?

Nah, we can just take it next window with the whole series. If you're happy to
ack it.

cheers
