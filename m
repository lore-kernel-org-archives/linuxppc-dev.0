Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by ozlabs.org (Postfix) with ESMTP id EEF9B67A7A
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Feb 2005 08:49:53 +1100 (EST)
Date: Sun, 6 Feb 2005 14:49:52 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Message-ID: <20050206214951.GE7686@smtp.west.cox.net>
References: <20050206125056.GA6394@suse.de>
	<20050206165428.GA7686@smtp.west.cox.net>
	<20050206165629.GA18769@suse.de>
	<20050206172431.GB7686@smtp.west.cox.net>
	<20050206172552.GC19327@suse.de>
	<20050206200431.GC7686@smtp.west.cox.net>
	<20050206200802.GA28652@suse.de>
	<20050206202154.GD7686@smtp.west.cox.net>
	<20050206211506.GA31123@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050206211506.GA31123@suse.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] remove .tmp_gas_check
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Feb 06, 2005 at 10:15:06PM +0100, Olaf Hering wrote:

>  On Sun, Feb 06, Tom Rini wrote:
> 
> > I agree you shouldn't have to see it.  I'm saying the problem is the
> > variable shouldn't be evaluated.
> 
> This patch seems to work for me.

What I don't like is that checkbin shouldn't be evaluated for 'tags' or
other non-compile targets, so you don't need those explicit rm's.  Also,
you forgot the signed-off-by line :)

-- 
Tom Rini
http://gate.crashing.org/~trini/
