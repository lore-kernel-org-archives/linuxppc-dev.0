Return-Path: <SRS0+8f0e197e6e608bebd9c3+1480+infradead.org+hch@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CCE72DDE43
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 21:34:28 +1000 (EST)
Date: Wed, 12 Sep 2007 12:34:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] powerpc: add new required termio functions
Message-ID: <20070912113409.GA7253@infradead.org>
References: <8018.1189562679@neuling.org>
	<20070912102032.GB7858@osiris.boeblingen.de.ibm.com>
	<20070912040109.3f6a9149.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070912040109.3f6a9149.akpm@linux-foundation.org>
Cc: Michael Neuling <mikey@neuling.org>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Alan Cox <alan@redhat.com>,
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

On Wed, Sep 12, 2007 at 04:01:09AM -0700, Andrew Morton wrote:
> On Wed, 12 Sep 2007 12:20:32 +0200 Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> 
> > On Wed, Sep 12, 2007 at 12:04:39PM +1000, Michael Neuling wrote:
> > > The "tty: termios locking functions break with new termios type" patch
> > > (f629307c857c030d5a3dd777fee37c8bb395e171) breaks the powerpc compile.
> > > [...]
> > > I'm guessing other architectures are broken too?
> > 
> > FWIW, the above quoted patch breaks s390 as well.
> 
> Does this fix it?

I might be missing something, but the the right fix is probably to
apply the arch patches from Alan to powerpc and s390.  We don't want to
be left over without all the nice termios features on these platforms,
do we?
