Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CE6C41A00BC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 21:06:02 +1100 (AEDT)
Message-ID: <1457345161.18915.3.camel@ellerman.id.au>
Subject: Re: How to merge? (was Re: [PATCH][v4] livepatch/ppc: Enable
 livepatching on powerpc)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jiri Kosina <jikos@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, linuxppc-dev@ozlabs.org,
 jeyu@redhat.com,  linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com,  duwe@lst.de, live-patching@vger.kernel.org,
 mbenes@suse.cz, Torsten Duwe <duwe@suse.de>, vojtech@suse.com,
 jpoimboe@redhat.com, sjenning@redhat.com
Date: Mon, 07 Mar 2016 21:06:01 +1100
In-Reply-To: <alpine.LNX.2.00.1603040952330.3656@cbobk.fhfr.pm>
References: <1457023921-2051-1-git-send-email-pmladek@suse.com>
 <1457078800.20076.4.camel@ellerman.id.au>
 <alpine.LNX.2.00.1603040952330.3656@cbobk.fhfr.pm>
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

On Fri, 2016-03-04 at 09:56 +0100, Jiri Kosina wrote:
> On Fri, 4 Mar 2016, Michael Ellerman wrote:
>
> > Obviously it depends heavily on the content of my series, which will go into
> > powerpc#next, so it would make sense if this went there too.
> >
> > I don't see any changes in linux-next for livepatch, so merging it via powerpc
> > would probably work fine and not cause any conflicts, unless there's some
> > livepatch changes pending for 4.6 that aren't in linux-next yet?
> >
> > The other option is that I put my ftrace changes and this in a topic branch
> > (based on v4.5-rc3), and then that can be merged into both powerpc#next and the
> > livepatch tree.
>
> This aligns with my usual workflow, so that'd be my preferred way of doing
> things; i.e. you put all the ftrace changes into a separate topic branch,
> and then
>
> - you pull that branch into powerpc#next
> - I pull that branch into livepatching tree
> - I apply the ppc livepatching support on top of that
> - I send a pull request to Linus only after powerpc#next gets merged to
>   Linus' tree
>
> Sounds good?

Yep, here it is:

  https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git/log/?h=topic/mprofile-kernel

aka:

  git fetch git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git topic/mprofile-kernel


I haven't merged it into my next yet, but I will tomorrow unless you tell me
there's something wrong with it.

cheers
