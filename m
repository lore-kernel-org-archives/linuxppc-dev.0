Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao11.cox.net (fed1rmmtao11.cox.net [68.230.241.28])
	by ozlabs.org (Postfix) with ESMTP id 9184C67A67
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Mar 2005 01:33:14 +1100 (EST)
Date: Thu, 10 Mar 2005 07:33:12 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050310143312.GO3098@smtp.west.cox.net>
References: <20050310082639.GA19275@gate.ebshome.net>
	<d10a9ba3f7ed768cff5f439840c96aec@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d10a9ba3f7ed768cff5f439840c96aec@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: build failure for 2.6.11-mm2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 10, 2005 at 08:06:04AM -0600, Kumar Gala wrote:

> right, but if you look back in the pervious -mm builds that past, they 
> also did not have mkImage but still succeeded.
> 
> It appear some change is now report the lack of mkImage as a build 
> error.  If this is desired behavior, should we maybe look at having a 
> copy of its source in the kernel tree?

I think what's happened, but I haven't verified is that Andrew took an
incorrect patch to make 'mkuboot.sh', which invokes mkimage to produce a
uImage, fail if mkimage isn't found.  This isn't right.  The problem the
patch was trying to fix is that mkuboot.sh will say that it made a
uImage, even if mkimage isn't found.

-- 
Tom Rini
http://gate.crashing.org/~trini/
