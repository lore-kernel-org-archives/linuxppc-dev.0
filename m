Date: Thu, 20 Nov 2003 13:17:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Wolfgang Denk <wd@denx.de>
Cc: Christoph Hellwig <hch@lst.de>,
	Tom Rini <trini@kernel.crashing.org>,
	Dale Farnsworth <dale@farnsworth.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC5200 Patches
Message-ID: <20031120121717.GA7764@lst.de>
References: <20031120115315.GA7411@lst.de> <20031120121037.90F93C5F5F@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031120121037.90F93C5F5F@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Nov 20, 2003 at 01:10:32PM +0100, Wolfgang Denk wrote:
> In message <20031120115315.GA7411@lst.de> you wrote:
> >
> > Umm, the code needs a rewrite before it's suitable for mainline.  In
>
> Are you volunteering? ;-)

Sure, feel free to contract me for that.

> > it's current state is just bogus utter crap.  The bestcomm API needs
> > to go away and the dma engine used directly.
>
> It would be nice if you explained your reasons for such a statement.

Because Linux is about doing things right, not fast?  Look at the bogus
taks abstractions - you just call into some deep multiplexer calls to
load pregenerated and (accoring to benh who worked with the even more
buggy predessecor) often bogus.  It looks like MOT once again produced
a really crappy chip and now hides the interface behind a huge bloated
API.  That might be find for them to sell the POS to someone wearing
Suits, but it's not really enough to get it included into the kernel
tree.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
