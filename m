Subject: Re: [PATCH] fix MOD_{INC,DEC}_USE_COUNT abuse in ppc 4xx/8xx code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040515180238.GA7465@infradead.org>
References: <20040507104748.GA10971@lst.de>
	 <20040507153205.GA24627@smtp.west.cox.net>
	 <20040515180238.GA7465@infradead.org>
Content-Type: text/plain
Message-Id: <1084766798.6438.23.camel@gaston>
Mime-Version: 1.0
Date: Mon, 17 May 2004 14:06:39 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2004-05-16 at 04:02, Christoph Hellwig wrote:
> On Fri, May 07, 2004 at 08:32:05AM -0700, Tom Rini wrote:
> >
> > On Fri, May 07, 2004 at 12:47:48PM +0200, Christoph Hellwig wrote:
> >
> > >
> > > not that most of the drivers are in a compiling shape currently, but
> > > I want to get rid of the last callers of those.
> >
> > Looks fine to me.
>
> So is someone goging to forward it or should I send it to akpm directly?

I think it's ok for you to send it directly ;)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
