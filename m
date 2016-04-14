Return-Path: <duwe@lst.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qm10z6qtMzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 22:57:39 +1000 (AEST)
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qm10z3bBpz9sD9
 for <linuxppc-dev@ozlabs.org>; Thu, 14 Apr 2016 22:57:39 +1000 (AEST)
Date: Thu, 14 Apr 2016 14:57:35 +0200
From: Torsten Duwe <duwe@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 linuxppc-dev@ozlabs.org, bsingharora@gmail.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 live-patching@vger.kernel.org
Subject: Re: [PATCH 0/5] Live patching for powerpc
Message-ID: <20160414125735.GA20296@lst.de>
References: <1460552003-15409-1-git-send-email-mpe@ellerman.id.au>
 <alpine.LNX.2.00.1604131457180.16586@pobox.suse.cz>
 <alpine.LNX.2.00.1604131508500.27368@cbobk.fhfr.pm>
 <1460616590.2754.6.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460616590.2754.6.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 14, 2016 at 04:49:50PM +1000, Michael Ellerman wrote:
> On Wed, 2016-04-13 at 15:22 +0200, Jiri Kosina wrote:
> > On Wed, 13 Apr 2016, Miroslav Benes wrote:
> > > > This series adds live patching support for powerpc (ppc64le only ATM).
> > > > 
> > > > It's unchanged since the version I posted on March 24, with the exception that
> > > > I've dropped the first patch, which was a testing-only patch.

Confirmed. And it still works on top of 4.6-rc3, even with the additional testing.

> > > > If there's no further comments I'll put this in a topic branch in the next day
> > > > or two and Jiri & I will both merge that into next.

"Go" from my side.

FTR: then I still have a few ppc64 hunks floating around to support certain consistency
models...

	Torsten
