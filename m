Date: Sat, 15 May 2004 20:02:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix MOD_{INC,DEC}_USE_COUNT abuse in ppc 4xx/8xx code
Message-ID: <20040515180238.GA7465@infradead.org>
References: <20040507104748.GA10971@lst.de> <20040507153205.GA24627@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040507153205.GA24627@smtp.west.cox.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, May 07, 2004 at 08:32:05AM -0700, Tom Rini wrote:
>
> On Fri, May 07, 2004 at 12:47:48PM +0200, Christoph Hellwig wrote:
>
> >
> > not that most of the drivers are in a compiling shape currently, but
> > I want to get rid of the last callers of those.
>
> Looks fine to me.

So is someone goging to forward it or should I send it to akpm directly?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
