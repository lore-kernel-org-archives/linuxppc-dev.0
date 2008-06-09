Return-Path: <julia@diku.dk>
Received: from mgw1.diku.dk (mgw1.diku.dk [130.225.96.91])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mgw1.diku.dk",
	Issuer "KU Security Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 387EBDE3B8
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Jun 2008 23:23:04 +1000 (EST)
Date: Mon, 9 Jun 2008 15:22:53 +0200 (CEST)
From: Julia Lawall <julia@diku.dk>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 2/4] drivers/macintosh/smu.c: add missing of_node_put
In-Reply-To: <20080609230752.f3bba16d.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.64.0806091521390.16009@ask.diku.dk>
References: <Pine.LNX.4.64.0806091420080.16009@ask.diku.dk>
	<20080609230752.f3bba16d.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> However, the error handling in that routine (smu_init) needs much more
> work.

Indeed, the smu = NULL at the end of the function seems a bit brutal - a 
lot of allocated data ends up not getting freed.  I can try to do 
something about it.  Did you see something else?

julia
