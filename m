Message-ID: <3CF3612B.8020102@embeddededge.com>
Date: Tue, 28 May 2002 06:51:23 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Armin <akuster@pacbell.net>,
	Tom Rini <trini@kernel.crashing.org>,
	Armin Kuster <akuster@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Another OCP enet patch
References: <20020527040330.GH16537@zax> <20020527162323.GB32718@opus.bloom.county> <20020528005728.GO16537@zax> <20020528012516.GE1295@opus.bloom.county> <3CF32B87.4010908@pacbell.net> <20020528065027.GT16537@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:

> ...  In some ways, since we're PPC specific anyway, I think it would
> make as much sense as anything just to directly call
> dcache_flush_range() and so forth, rather than consistent_sync() or
> dma_cache_*().

Yes, that's true.  These consistent_* functions were added when we
started using non-PCI drivers that are common across multiple platforms.
It seems none of the platforms had common names for data cache management
functions, so people started using the consistent_sync() in it's place.
It also made sense because they were using the other consistent_* functions
as well.  No one probably noticed, but at the same time we also changed
the cache management function names to be similar to other architectures
as well.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
