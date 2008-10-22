Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E2783DDDFB
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 20:37:27 +1100 (EST)
Date: Wed, 22 Oct 2008 10:37:22 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] mfd/wm8350: don't export static functions
Message-ID: <20081022093721.GA10499@rakim.wolfsonmicro.main>
References: <20081016204754.a41646e5.sfr@canb.auug.org.au>
	<20081016120416.GA5753@rakim.wolfsonmicro.main>
	<20081022203112.5a213e8c.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081022203112.5a213e8c.sfr@canb.auug.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, ppc-dev <linuxppc-dev@ozlabs.org>,
	linux-next@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Linus <torvalds@linux-foundation.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 22, 2008 at 08:31:12PM +1100, Stephen Rothwell wrote:

> I thought that this had been applied, but I have had to apply it to my
> tree today again.

Samuel doesn't seem to have picked it up (though looking at the CC list
you've not sent it to him).  I'm going to push another batch of stuff to
him later today, hopefully he will pick it up then.
