Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ECE902BF07
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Dec 2004 17:56:01 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
In-Reply-To: <20041223062515.GB4546@pegasos>
References: <1103739194.5316.1.camel@gaston>
	<1103740513.29974.0.camel@gaston>  <20041223062515.GB4546@pegasos>
Content-Type: text/plain
Date: Thu, 23 Dec 2004 07:55:02 +0100
Message-Id: <1103784902.29975.4.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: [PATCH] Fix Alsa issues including Oopses with OSS emulation
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2004-12-23 at 07:25 +0100, Sven Luther wrote:
> On Wed, Dec 22, 2004 at 07:35:13PM +0100, Benjamin Herrenschmidt wrote:
> > On Wed, 2004-12-22 at 19:13 +0100, Benjamin Herrenschmidt wrote:
> > > This patch (which will be send upstream separately by the Alsa folks) fixes
> > > an signed vs. unsigned char problem in Alsa which was the cause of the Oops
> > > people were experiencing on ppc with OSS emulation and possibly other issues.
> > 
> > Ok, actually, the one that will be commited upstream is a bit different,
> > here it is:
> 
> Ben, i suppose this one is for inclusion in the debian kernel too, do you
> think you could send such patches as bug reports against kernel-source-2.6.8
> package, or to debian-kernel also ? 

Wherever as long as it gets into the debian kernel packages. I doesn't
affect ppc only (any arch with unsigned char by default)

Ben.
