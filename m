Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 20FDDDDE20
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 21:35:45 +1000 (EST)
Subject: Re: [PATCH] Make u64 long long on all architectures (was: the
	printk problem)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20080722030506.206a2cc2.akpm@linux-foundation.org>
References: <20080625131101.GA6205@digi.com> <20080704104634.GA31634@digi.com>
	<20080704111540.ddffd241.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0807041147450.2815@woody.linux-foundation.org>
	<alpine.LFD.1.10.0807041250220.2815@woody.linux-foundation.org>
	<20080704132716.f1e12554.akpm@linux-foundation.org>
	<20080704204252.GM14894@parisc-linux.org>
	<20080704150100.1f7b8a65.akpm@linux-foundation.org>
	<20080705020350.GN14894@parisc-linux.org>
	<20080722030506.206a2cc2.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Tue, 22 Jul 2008 21:35:30 +1000
Message-Id: <1216726530.11027.205.camel@pasglop>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
	Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Peter Anvin <hpa@zytor.com>,
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


> 
> This is (IMO) a desirable change and will prevent a heck of a lot of
> goofing around, and will permit a lot of prior goofing around to
> be removed.
> 
> But I bet there are lots of instalces of printk("%l", some_u64) down in
> arch code where the type of u64 _is_ known which will now spew warnings.

Well, I'm about to call a big "warning fixing day" on the powerpc list,
I saw a few today when building a couple of configs and that hurts my
eyes so we may as well fold that in :-)

Cheers,
Ben.
 
