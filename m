Date: Mon, 9 Aug 2004 17:54:44 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Harald Welte <laforge@gnumonks.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] md raid autodetection on mac partitions
Message-ID: <20040809155444.GA25045@obroa-skai.de.gnumonks.org>
References: <20040806075918.GA11638@sunbeam2> <20040807110404.GA1854@lst.de>
Mime-Version: 1.0
In-Reply-To: <20040807110404.GA1854@lst.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Aug 07, 2004 at 01:04:04PM +0200, Christoph Hellwig wrote:

> No.   raid autodetection is deprectaed, we don't want it for more
> partiton types.

Oh well.  I guess I'm the only user who likes to boot his machine
without building some initrd - especially since this never works out of
the box with any vendor-supplied tools on any distribution I've tried
so far.

If autodetection is deprecated, will we at least see some kernel boot
option, where one could specify which partitions to use?

--
- Harald Welte <laforge@gnumonks.org>               http://www.gnumonks.org/
============================================================================
Programming is like sex: One mistake and you have to support it your lifetime

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
