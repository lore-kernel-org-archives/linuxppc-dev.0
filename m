Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Date: Thu, 20 Nov 2003 12:53:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Wolfgang Denk <wd@denx.de>,
	Dale Farnsworth <dale@farnsworth.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC5200 Patches
Message-ID: <20031120115315.GA7411@lst.de>
References: <20031117151948.GB30251@ip68-0-152-218.tc.ph.cox.net> <20031117160250.CD994C5F59@atlas.denx.de> <20031117162530.GD30251@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031117162530.GD30251@ip68-0-152-218.tc.ph.cox.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Nov 17, 2003 at 09:25:30AM -0700, Tom Rini wrote:
> This is a tree that we can check the initial MPC5xxx work into for 2.4,
> make sure that it works and get Marcelo to take it.  Then it can die.
> And the older (linuxppc_2_4_mgt5100) can be archived and die.  And the
> new (linuxppc_2_4_mpc5200) tree should die now since it's only got
> Dale's one patch in it, that I'm moving over.

Umm, the code needs a rewrite before it's suitable for mainline.  In
it's current state is just bogus utter crap.  The bestcomm API needs
to go away and the dma engine used directly.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
