Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8467FDDF12
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jul 2008 08:59:12 +1000 (EST)
Subject: Re: the printk problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthew Wilcox <matthew@wil.cx>
In-Reply-To: <20080704204252.GM14894@parisc-linux.org>
References: <20080625131101.GA6205@digi.com> <20080704104634.GA31634@digi.com>
	<20080704111540.ddffd241.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0807041147450.2815@woody.linux-foundation.org>
	<alpine.LFD.1.10.0807041250220.2815@woody.linux-foundation.org>
	<20080704132716.f1e12554.akpm@linux-foundation.org>
	<20080704204252.GM14894@parisc-linux.org>
Content-Type: text/plain
Date: Sat, 05 Jul 2008 08:58:56 +1000
Message-Id: <1215212336.8970.6.camel@pasglop>
Mime-Version: 1.0
Cc: linux-ia64@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Peter Anvin <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>,
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


> u64 is easy to fix, and I don't know why we haven't.  Just make it
> unsigned long long on all architectures.

Yup. Also, one of the major user of that is to print a struct resource,
which everybody does differently, so we may even look at doing a %pR
that does the nice start..end [attr]..

Ben.
