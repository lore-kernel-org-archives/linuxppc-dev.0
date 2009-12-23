Return-Path: <lsorense@csclub.uwaterloo.ca>
Received: from caffeine.csclub.uwaterloo.ca (caffeine.csclub.uwaterloo.ca
	[129.97.134.17]) by ozlabs.org (Postfix) with ESMTP id 0061FB7BF3
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Dec 2009 09:23:46 +1100 (EST)
Date: Wed, 23 Dec 2009 17:23:46 -0500
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: ucc_geth broken in 2.6.32 by
	864fdf884e82bacbe8ca5e93bd43393a61d2e2b4
Message-ID: <20091223222346.GI760@caffeine.csclub.uwaterloo.ca>
References: <20091223174019.GB762@caffeine.csclub.uwaterloo.ca>
	<20091223180415.GA12987@oksana.dev.rtsoft.ru>
	<20091223200948.GF760@caffeine.csclub.uwaterloo.ca>
	<20091223202226.GA8185@oksana.dev.rtsoft.ru>
	<20091223221047.GH760@caffeine.csclub.uwaterloo.ca>
	<20091223222116.GA851@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091223222116.GA851@oksana.dev.rtsoft.ru>
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 24, 2009 at 01:21:16AM +0300, Anton Vorontsov wrote:
> On Wed, Dec 23, 2009 at 05:10:47PM -0500, Lennart Sorensen wrote:
> [...]
> > That seems to be it.  It works now.  No more crashes.
> > Those two patches together seem to do the trick.
> 
> Great!
> 
> > I really hope they
> > can go into 2.6.32-stable then, since this is a regression over 2.6.31
> > and is hopefully an obvious fix.
> 
> Yep, will try to get them there.
> 
> Thanks a lot for helping to track this down,

Thanks for fixing it so fast.  I only knew that patch broke it, not why
it broke it.

-- 
Len Sorensen
