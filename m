Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qm1Dz3pDNzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 23:08:03 +1000 (AEST)
Message-ID: <1460639282.21066.5.camel@ellerman.id.au>
Subject: Re: [PATCH 0/5] Live patching for powerpc
From: Michael Ellerman <mpe@ellerman.id.au>
To: Torsten Duwe <duwe@lst.de>
Cc: Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 linuxppc-dev@ozlabs.org, bsingharora@gmail.com,
 linux-kernel@vger.kernel.org,  rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com,  jeyu@redhat.com,
 live-patching@vger.kernel.org
Date: Thu, 14 Apr 2016 23:08:02 +1000
In-Reply-To: <20160414125735.GA20296@lst.de>
References: <1460552003-15409-1-git-send-email-mpe@ellerman.id.au>
 <alpine.LNX.2.00.1604131457180.16586@pobox.suse.cz>
 <alpine.LNX.2.00.1604131508500.27368@cbobk.fhfr.pm>
 <1460616590.2754.6.camel@ellerman.id.au> <20160414125735.GA20296@lst.de>
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

On Thu, 2016-04-14 at 14:57 +0200, Torsten Duwe wrote:
> On Thu, Apr 14, 2016 at 04:49:50PM +1000, Michael Ellerman wrote:
> > On Wed, 2016-04-13 at 15:22 +0200, Jiri Kosina wrote:
> > > On Wed, 13 Apr 2016, Miroslav Benes wrote:
> > > > > This series adds live patching support for powerpc (ppc64le only ATM).
> > > > > 
> > > > > It's unchanged since the version I posted on March 24, with the exception that
> > > > > I've dropped the first patch, which was a testing-only patch.
> 
> Confirmed. And it still works on top of 4.6-rc3, even with the additional testing.
 
Thanks. Yeah I tested on top of rc3 as well as back on the topic branch (4.5-rc).

> > > > > If there's no further comments I'll put this in a topic branch in the next day
> > > > > or two and Jiri & I will both merge that into next.
> 
> "Go" from my side.
 
Throttle up!

> FTR: then I still have a few ppc64 hunks floating around to support certain consistency
> models...

OK. I'm not quite sure what you mean but post them and we'll see I guess :)

cheers
