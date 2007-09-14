Return-Path: <alan@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 5BAD1DDDFE
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 00:22:29 +1000 (EST)
Date: Fri, 14 Sep 2007 10:20:14 -0400
From: Alan Cox <alan@redhat.com>
To: Christoph Hellwig <hch@infradead.org>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michael Neuling <mikey@neuling.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, paulus@samba.org,
	Alan Cox <alan@redhat.com>, "David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] powerpc: add new required termio functions
Message-ID: <20070914142014.GC20963@devserv.devel.redhat.com>
References: <8018.1189562679@neuling.org>
	<20070912102032.GB7858@osiris.boeblingen.de.ibm.com>
	<20070912040109.3f6a9149.akpm@linux-foundation.org>
	<20070912113409.GA7253@infradead.org>
	<20070912115257.GC7858@osiris.boeblingen.de.ibm.com>
	<20070912134910.GA12660@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070912134910.GA12660@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 12, 2007 at 02:49:10PM +0100, Christoph Hellwig wrote:
> On Wed, Sep 12, 2007 at 01:52:57PM +0200, Heiko Carstens wrote:
> > > I might be missing something, but the the right fix is probably to
> > > apply the arch patches from Alan to powerpc and s390.  We don't want to
> > > be left over without all the nice termios features on these platforms,
> > > do we?
> > 
> > But not in rc6 timeframe, I would guess?
> 
> Ask Alan..

Well i've been chasing people for many months on the 390 side so if they missed
a release tough ...

Alan


-- 
--
		"A wiki is where ideas go to die"
				-- Becky Hogge
