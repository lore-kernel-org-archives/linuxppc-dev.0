Date: Mon, 24 May 2004 10:06:59 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linuxppc-dev@lists.linuxppc.org, debian-kernel@lists.debian.org
Subject: Re: minimum required binutils for ppc32?
Message-ID: <20040524170659.GS6763@smtp.west.cox.net>
References: <20040523095826.GA10105@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040523095826.GA10105@lst.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, May 23, 2004 at 11:58:26AM +0200, Christoph Hellwig wrote:

> What's the minimum required binutils version for ppc32 these days?

For 2.6, it is 2.12.1 or the corresponding hjl version which knows about
'dssall', for classic (CONFIG_6xx=y) PPC.  I don't believe an exact
minimum has been nailed down for 40x/44x.

> The debian kernel package ups it from 2.12.1 to 2.12.90.0.7, i.e. from
> the first 2.12 maintaince release to one of hjl's later releases and
> I wonder why it does that.  Either it's bogus and should be be dropped
> or we should up it in mainline.

AFAIK, it is bogus.  Unless there's a reason for it in the debian BTS.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
