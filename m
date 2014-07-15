Return-Path: <rostedt@goodmis.org>
Received: from cdptpa-oedge-vip.email.rr.com
 (cdptpa-outbound-snat.email.rr.com [107.14.166.228])
 by lists.ozlabs.org (Postfix) with ESMTP id 404B11A014F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 12:16:58 +1000 (EST)
Date: Mon, 14 Jul 2014 22:16:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Revert removing of _INIT_GLOBAL(), _STATIC()
 and _INIT_STATIC()
Message-ID: <20140714221653.335cd39c@gandalf.local.home>
In-Reply-To: <1405389955.9343.48.camel@pasglop>
References: <20140714201204.7b6fcd8e@gandalf.local.home>
 <1405389955.9343.48.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 15 Jul 2014 12:05:55 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:


> Cheers,
> Ben.
> 

While I got your attention, could you please ack my patch with subject:

[RFA][PATCH 09/27] powerpc/ftrace: Add call to ftrace_graph_is_dead() in function graph code

so that I can push it through my tree.

Thanks!

-- Steve
