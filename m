Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlrrb1JS1zDq64
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 16:49:51 +1000 (AEST)
Message-ID: <1460616590.2754.6.camel@ellerman.id.au>
Subject: Re: [PATCH 0/5] Live patching for powerpc
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>
Cc: linuxppc-dev@ozlabs.org, bsingharora@gmail.com, duwe@lst.de,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com,  pmladek@suse.com, jeyu@redhat.com,
 live-patching@vger.kernel.org
Date: Thu, 14 Apr 2016 16:49:50 +1000
In-Reply-To: <alpine.LNX.2.00.1604131508500.27368@cbobk.fhfr.pm>
References: <1460552003-15409-1-git-send-email-mpe@ellerman.id.au>
 <alpine.LNX.2.00.1604131457180.16586@pobox.suse.cz>
 <alpine.LNX.2.00.1604131508500.27368@cbobk.fhfr.pm>
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

On Wed, 2016-04-13 at 15:22 +0200, Jiri Kosina wrote:
> On Wed, 13 Apr 2016, Miroslav Benes wrote:
> > > This series adds live patching support for powerpc (ppc64le only ATM).
> > > 
> > > It's unchanged since the version I posted on March 24, with the exception that
> > > I've dropped the first patch, which was a testing-only patch.
> > > 
> > > If there's no further comments I'll put this in a topic branch in the next day
> > > or two and Jiri & I will both merge that into next.
> > 
> > Hi,
> > 
> > I'll definitely give it a proper look today or tomorrow, but there is one 
> > thing that needs to be solved. The patch set from Jessica reworking 
> > relocations for live patching is now merged in our for-next branch. This 
> > means that we need to find out if there is something in struct 
> > mod_arch_specific for powerpc which needs to be preserved and do it.
> 
> Michael, if the plan is still the original one, i.e. you push it to your 
> branch, and I merge it to livepatching (and resolve any dependencies on 
> the relocations code during the merge) and push it to Linus from 
> livepatching.git, then there shouldn't be anything do to on your side.

That is my plan yeah.

Topic branch here:

  https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git/log/?h=topic/livepatch

I will merge that before Monday (my time) if I don't hear any objections.

cheers
