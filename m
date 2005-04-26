Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CA26467AC5
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Apr 2005 10:38:13 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eddy Petrisor <eddy.petrisor@gmail.com>
In-Reply-To: <426D8A32.8090005@gmail.com>
References: <1114228279.5996.44.camel@gaston> <426C17D3.7000807@gmail.com>
	<426D8A32.8090005@gmail.com>
Content-Type: text/plain
Date: Tue, 26 Apr 2005 10:42:15 +1000
Message-Id: <1114476136.18808.11.camel@gaston>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: [PATCH] ppc32: Fix a sleep issues on some laptops
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-04-26 at 03:24 +0300, Eddy Petrisor wrote:
> I had soem mail problems and this mail was not sent
> 
> Eddy Petrisor wrote:
> > Benjamin Herrenschmidt wrote:
> > 
> >> Hi !
> >>
> >> Some earlier models of aluminium powerbooks and ibook G4s have a clock
> >> chip that requires some tweaking before and after sleep. It seems that
> >> without that magic incantation to disable and re-enable clock spreading,
> >> RAM isn't properly refreshed during sleep. This fixes it.
> > 
> > over which version of kernel does this apply, or where can we find it, 
> > already included? I had some problems with sleeping (well, not me, my 
> > powerbook :o)

It should apply on 2.6.12-rc* and maybe 2.6.11

Ben.
