Return-Path: <rostedt@goodmis.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5FF3C1A00BC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 13:00:21 +1100 (AEDT)
Received: from cdptpa-oedge-vip.email.rr.com
 (cdptpa-outbound-snat.email.rr.com [107.14.166.226])
 by ozlabs.org (Postfix) with ESMTP id C13D514017E
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2016 13:00:20 +1100 (AEDT)
Date: Mon, 7 Mar 2016 20:53:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>,
 linuxppc-dev@ozlabs.org, jeyu@redhat.com, linux-kernel@vger.kernel.org,
 kamalesh@linux.vnet.ibm.com, duwe@lst.de, live-patching@vger.kernel.org,
 mbenes@suse.cz, Torsten Duwe <duwe@suse.de>, vojtech@suse.com,
 jpoimboe@redhat.com, sjenning@redhat.com
Subject: Re: How to merge? (was Re: [PATCH][v4] livepatch/ppc: Enable
 livepatching on powerpc)
Message-ID: <20160307205310.48417c9d@grimm.local.home>
In-Reply-To: <1457392822.25457.4.camel@ellerman.id.au>
References: <1457023921-2051-1-git-send-email-pmladek@suse.com>
 <1457078800.20076.4.camel@ellerman.id.au>
 <alpine.LNX.2.00.1603040952330.3656@cbobk.fhfr.pm>
 <1457345161.18915.3.camel@ellerman.id.au>
 <alpine.LNX.2.00.1603072348280.3656@cbobk.fhfr.pm>
 <1457392822.25457.4.camel@ellerman.id.au>
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

On Tue, 08 Mar 2016 10:20:22 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> >
> > There is one remaining issue which I think would be really nice to
> > have(TM), and that's Steven's Ack for the whole thing :)  
> 
> Yeah. He's been on CC the whole time, but he's probably getting a bit sick of
> it all, as we're up to about version 15. So I figure if he really hated it he'd
> have said so by now :) - but an Ack would still be good.
> 

I figured this is all powerpc work, and you can crash what you like :-)

If you want, I can try to get some time tomorrow and take a quick look
at the patches. But yeah, I haven't been paying too much attention to
this.

-- Steve
