Return-Path: <heiko.carstens@de.ibm.com>
Received: from mtagate4.uk.ibm.com (mtagate4.uk.ibm.com [195.212.29.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1EB0BDDEB7
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 21:53:35 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate4.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l8CBrVgn134758
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 11:53:31 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l8CBrVwA479318
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 12:53:31 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l8CBrEEc006154
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 12:53:15 +0100
Date: Wed, 12 Sep 2007 13:52:57 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michael Neuling <mikey@neuling.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, paulus@samba.org,
	Alan Cox <alan@redhat.com>, "David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] powerpc: add new required termio functions
Message-ID: <20070912115257.GC7858@osiris.boeblingen.de.ibm.com>
References: <8018.1189562679@neuling.org>
	<20070912102032.GB7858@osiris.boeblingen.de.ibm.com>
	<20070912040109.3f6a9149.akpm@linux-foundation.org>
	<20070912113409.GA7253@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070912113409.GA7253@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 12, 2007 at 12:34:09PM +0100, Christoph Hellwig wrote:
> On Wed, Sep 12, 2007 at 04:01:09AM -0700, Andrew Morton wrote:
> > On Wed, 12 Sep 2007 12:20:32 +0200 Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> > 
> > > On Wed, Sep 12, 2007 at 12:04:39PM +1000, Michael Neuling wrote:
> > > > The "tty: termios locking functions break with new termios type" patch
> > > > (f629307c857c030d5a3dd777fee37c8bb395e171) breaks the powerpc compile.
> > > > [...]
> > > > I'm guessing other architectures are broken too?
> > > 
> > > FWIW, the above quoted patch breaks s390 as well.
> > 
> > Does this fix it?

Yes, it does.

> I might be missing something, but the the right fix is probably to
> apply the arch patches from Alan to powerpc and s390.  We don't want to
> be left over without all the nice termios features on these platforms,
> do we?

But not in rc6 timeframe, I would guess?
