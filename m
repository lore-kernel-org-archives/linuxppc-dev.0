Return-Path: <jikos@kernel.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A7C4A1A032F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 19:56:47 +1100 (AEDT)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 32D2A140157
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Mar 2016 19:56:45 +1100 (AEDT)
Date: Fri, 4 Mar 2016 09:56:42 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
cc: Petr Mladek <pmladek@suse.com>, linuxppc-dev@ozlabs.org, jeyu@redhat.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, duwe@lst.de, live-patching@vger.kernel.org,
 mbenes@suse.cz, Torsten Duwe <duwe@suse.de>, vojtech@suse.com,
 jpoimboe@redhat.com, sjenning@redhat.com
Subject: Re: How to merge? (was Re: [PATCH][v4] livepatch/ppc: Enable
 livepatching on powerpc)
In-Reply-To: <1457078800.20076.4.camel@ellerman.id.au>
Message-ID: <alpine.LNX.2.00.1603040952330.3656@cbobk.fhfr.pm>
References: <1457023921-2051-1-git-send-email-pmladek@suse.com>
 <1457078800.20076.4.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 4 Mar 2016, Michael Ellerman wrote:

> Obviously it depends heavily on the content of my series, which will go into
> powerpc#next, so it would make sense if this went there too.
> 
> I don't see any changes in linux-next for livepatch, so merging it via powerpc
> would probably work fine and not cause any conflicts, unless there's some
> livepatch changes pending for 4.6 that aren't in linux-next yet?
> 
> The other option is that I put my ftrace changes and this in a topic branch
> (based on v4.5-rc3), and then that can be merged into both powerpc#next and the
> livepatch tree.

This aligns with my usual workflow, so that'd be my preferred way of doing 
things; i.e. you put all the ftrace changes into a separate topic branch, 
and then

- you pull that branch into powerpc#next
- I pull that branch into livepatching tree
- I apply the ppc livepatching support on top of that
- I send a pull request to Linus only after powerpc#next gets merged to 
  Linus' tree

Sounds good?

> Also regardless of who takes it an Ack from Steve for the ftrace changes 
> would be good.

Absolutely.

Thanks!

-- 
Jiri Kosina
SUSE Labs
