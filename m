Date: Fri, 3 Aug 2001 10:02:51 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Hollis Blanchard <hollis@austin.ibm.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] IBM PReP power down
Message-ID: <20010803100251.A20944@opus.bloom.county>
References: <20010803114608.A9987@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010803114608.A9987@austin.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Aug 03, 2001 at 11:46:08AM -0500, Hollis Blanchard wrote:

> The patch is against _2_4, but applies with slight offsets to _2_4_devel as
> well. Please commit to both?

It currently fails on 2_4, and it's the big hunk too.  Also, can't
utah_sig87c750_setbit be 'static'?  Aside from that it looks good..

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
