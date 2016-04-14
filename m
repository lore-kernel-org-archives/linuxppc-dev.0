Return-Path: <jikos@kernel.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qm38r1qYvzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2016 00:34:36 +1000 (AEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qm38q4Ggtz9s4n
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Apr 2016 00:34:35 +1000 (AEST)
Date: Thu, 14 Apr 2016 16:34:28 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Torsten Duwe <duwe@lst.de>
cc: Michael Ellerman <mpe@ellerman.id.au>, Miroslav Benes <mbenes@suse.cz>,
 linuxppc-dev@ozlabs.org, bsingharora@gmail.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 live-patching@vger.kernel.org
Subject: Re: [PATCH 0/5] Live patching for powerpc
In-Reply-To: <20160414125735.GA20296@lst.de>
Message-ID: <alpine.LNX.2.00.1604141631430.27368@cbobk.fhfr.pm>
References: <1460552003-15409-1-git-send-email-mpe@ellerman.id.au>
 <alpine.LNX.2.00.1604131457180.16586@pobox.suse.cz>
 <alpine.LNX.2.00.1604131508500.27368@cbobk.fhfr.pm>
 <1460616590.2754.6.camel@ellerman.id.au> <20160414125735.GA20296@lst.de>
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

On Thu, 14 Apr 2016, Torsten Duwe wrote:

> > > > > It's unchanged since the version I posted on March 24, with the exception that
> > > > > I've dropped the first patch, which was a testing-only patch.
> 
> Confirmed. And it still works on top of 4.6-rc3, even with the 
> additional testing.

Thanks a lot for testing.

The imporant part here is testing on top of 
livepatching.git#for-4.7/arch-independent-klp-relocations as well.

I am pretty sure there will be adjustments needed for the merge, as we'll 
have to figure out which parts of ELF can't be thrown away and need to be 
preserved in order for the relocation entry to be successfully 
constructed.

Michael, I think this is an additional reason why the whole final pile 
will have to go through livepatching.git, as the merge with what we have 
in for-4.7/arch-independent-klp-relocations might not be completely 
trivial.

-- 
Jiri Kosina
SUSE Labs
