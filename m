Return-Path: <jpoimboe@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gcLB5mygzF13T
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 10:14:42 +1000 (AEST)
Date: Tue, 8 May 2018 19:14:32 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Torsten Duwe <duwe@lst.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Jiri Kosina <jkosina@suse.cz>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, live-patching@vger.kernel.org
Subject: Re: [PATCH v3] ppc64le livepatch: implement reliable stacktrace for
 newer consistency models
Message-ID: <20180509001432.5nd55ictwf5yi7sm@treble>
References: <20180305164928.GA17953@lst.de>
 <20180308162616.yhbymodggnfzpskx@treble>
 <20180309174718.2700b29e@blackhole.lan>
 <20180312153536.7avozx64ku4lvd3e@treble>
 <20180504123834.GA16581@lst.de>
 <20180507154208.jo4s43olrf5a3hw4@treble>
 <20180508103832.085378b9@blackhole.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180508103832.085378b9@blackhole.lan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 08, 2018 at 10:38:32AM +0200, Torsten Duwe wrote:
> On Mon, 7 May 2018 10:42:08 -0500
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> > The subject doesn't actively describe what the patch does, maybe
> > change it to something like:
> > 
> >   powerpc: Add support for HAVE_RELIABLE_STACKTRACE
> > 
> > or maybe
> > 
> >   powerpc: Add support for livepatch consistency model
> 
> Maybe $SUBJECT? You're absolutely right, the old subject was just a
> leftover of my original attempt to just set the flag, before Miroslav
> corrected me. I just kept on copying it without a second thought. Thanks
> for noting.

Generally we refer to it as "the consistency model".  So I would
propose a minor edit:

  ppc64le/livepatch: Implement reliable stack tracing for the consistency model

> > Otherwise it looks great to me.
> > 
> > Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > 
> Thanks.
> 
> 	Torsten
> 

-- 
Josh
