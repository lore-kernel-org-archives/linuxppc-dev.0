Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 3D5D5DDF1C
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 09:28:36 +1000 (EST)
Date: Wed, 25 Apr 2007 16:28:41 -0700 (PDT)
Message-Id: <20070425.162841.90714338.davem@davemloft.net>
To: segher@kernel.crashing.org
Subject: Re: [PATCH 3/6] Consolidate of_find_property
From: David Miller <davem@davemloft.net>
In-Reply-To: <86094f4e887d90dbff1be6d20e5fdd5c@kernel.crashing.org>
References: <1177541265.14873.222.camel@localhost.localdomain>
	<20070425.161309.02297897.davem@davemloft.net>
	<86094f4e887d90dbff1be6d20e5fdd5c@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, sfr@canb.auug.org.au, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Thu, 26 Apr 2007 01:18:59 +0200

> > Meanwhile any feedback on the idea of pushing all of this
> > consolidation and cleanup work through one of our trees
> > instead of having all of these difficult dependencies
> > between the two?
> 
> Set up a branch in one of the Git repos that is for
> this consolidation work only, that both the arch trees
> can pull from?  The beauty with Git is that this won't
> lead to merge problems :-)

I rebase my GIT tree as patches very often, and I have many direct
dependencies on this work both at the beginning and further along in
my tree.

So this won't work, that's why I haven't suggested it.
