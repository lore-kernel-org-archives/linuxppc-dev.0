Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qmcDP4CkKzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2016 22:24:37 +1000 (AEST)
Message-ID: <1460723070.22415.5.camel@ellerman.id.au>
Subject: Re: [PATCH 0/5] Live patching for powerpc
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jiri Kosina <jikos@kernel.org>, Torsten Duwe <duwe@lst.de>
Cc: Miroslav Benes <mbenes@suse.cz>, linuxppc-dev@ozlabs.org,
 bsingharora@gmail.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 live-patching@vger.kernel.org
Date: Fri, 15 Apr 2016 22:24:30 +1000
In-Reply-To: <alpine.LNX.2.00.1604141631430.27368@cbobk.fhfr.pm>
References: <1460552003-15409-1-git-send-email-mpe@ellerman.id.au>
 <alpine.LNX.2.00.1604131457180.16586@pobox.suse.cz>
 <alpine.LNX.2.00.1604131508500.27368@cbobk.fhfr.pm>
 <1460616590.2754.6.camel@ellerman.id.au> <20160414125735.GA20296@lst.de>
 <alpine.LNX.2.00.1604141631430.27368@cbobk.fhfr.pm>
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

On Thu, 2016-04-14 at 16:34 +0200, Jiri Kosina wrote:
> On Thu, 14 Apr 2016, Torsten Duwe wrote:
> > > > > > It's unchanged since the version I posted on March 24, with the exception that
> > > > > > I've dropped the first patch, which was a testing-only patch.
> > 
> > Confirmed. And it still works on top of 4.6-rc3, even with the 
> > additional testing.
> 
> Thanks a lot for testing.
> 
> The imporant part here is testing on top of 
> livepatching.git#for-4.7/arch-independent-klp-relocations as well.
> 
> I am pretty sure there will be adjustments needed for the merge, as we'll 
> have to figure out which parts of ELF can't be thrown away and need to be 
> preserved in order for the relocation entry to be successfully 
> constructed.
> 
> Michael, I think this is an additional reason why the whole final pile 
> will have to go through livepatching.git, as the merge with what we have 
> in for-4.7/arch-independent-klp-relocations might not be completely 
> trivial.

Well it will go through both :)

I'll merge it into powerpc#next, and you can merge it into livepatching and do
what ever else is needed as part of, or after, that merge.

cheers
