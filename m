Date: Fri, 7 May 2004 08:32:05 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix MOD_{INC,DEC}_USE_COUNT abuse in ppc 4xx/8xx code
Message-ID: <20040507153205.GA24627@smtp.west.cox.net>
References: <20040507104748.GA10971@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040507104748.GA10971@lst.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, May 07, 2004 at 12:47:48PM +0200, Christoph Hellwig wrote:

>
> not that most of the drivers are in a compiling shape currently, but
> I want to get rid of the last callers of those.

Looks fine to me.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
