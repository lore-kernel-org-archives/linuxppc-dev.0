Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 75128DE35F
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 21:55:43 +1000 (EST)
Subject: Re: [PATCH] Make u64 long long on all architectures (was: the
	printk problem)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1216722995.8357.4.camel@localhost>
References: <20080625131101.GA6205@digi.com> <20080704104634.GA31634@digi.com>
	<20080704111540.ddffd241.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0807041147450.2815@woody.linux-foundation.org>
	<alpine.LFD.1.10.0807041250220.2815@woody.linux-foundation.org>
	<20080704132716.f1e12554.akpm@linux-foundation.org>
	<20080704204252.GM14894@parisc-linux.org>
	<20080704150100.1f7b8a65.akpm@linux-foundation.org>
	<20080705020350.GN14894@parisc-linux.org>
	<20080722030506.206a2cc2.akpm@linux-foundation.org>
	<1216722995.8357.4.camel@localhost>
Content-Type: text/plain
Date: Tue, 22 Jul 2008 21:36:46 +1000
Message-Id: <1216726606.11027.207.camel@pasglop>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
	Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Peter Anvin <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-07-22 at 20:36 +1000, Michael Ellerman wrote:
> concordia powerpc(master) $ find arch/powerpc/ ! -name '*32.*' | xargs
> grep "%l" | grep -v "%ll" | wc -l
> 635
> 
> 
> Someone's gonna get a lot of git points for fixing all those. Might
> keep
> the speeling fix crowd busy for a 

But a bunch of those might actually be real longs, not u64's ...

Easier to do the change and build something like ppc6xx_defconfig to get
a better approximation.

Ben.
