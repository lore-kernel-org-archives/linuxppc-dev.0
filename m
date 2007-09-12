Return-Path: <SRS0+8f0e197e6e608bebd9c3+1480+infradead.org+hch@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D9C6EDDD0D
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 23:49:24 +1000 (EST)
Date: Wed, 12 Sep 2007 14:49:10 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] powerpc: add new required termio functions
Message-ID: <20070912134910.GA12660@infradead.org>
References: <8018.1189562679@neuling.org>
	<20070912102032.GB7858@osiris.boeblingen.de.ibm.com>
	<20070912040109.3f6a9149.akpm@linux-foundation.org>
	<20070912113409.GA7253@infradead.org>
	<20070912115257.GC7858@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070912115257.GC7858@osiris.boeblingen.de.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Alan Cox <alan@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 12, 2007 at 01:52:57PM +0200, Heiko Carstens wrote:
> > I might be missing something, but the the right fix is probably to
> > apply the arch patches from Alan to powerpc and s390.  We don't want to
> > be left over without all the nice termios features on these platforms,
> > do we?
> 
> But not in rc6 timeframe, I would guess?

Ask Alan..
