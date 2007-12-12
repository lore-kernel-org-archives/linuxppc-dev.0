Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EFE99DDE27
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 20:46:05 +1100 (EST)
Subject: Re: [PATCH 1/2] Make setjmp/longjmp code generic
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20071212203727.f3719e4a.sfr@canb.auug.org.au>
References: <20071212054512.882AC62C070@localhost.localdomain>
	<B07AAF57-E87C-40CF-A550-7F868497A2CB@kernel.crashing.org>
	<1197446814.8385.104.camel@pasglop>
	<20071212203727.f3719e4a.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Wed, 12 Dec 2007 20:44:36 +1100
Message-Id: <1197452676.8385.116.camel@pasglop>
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>, THEMANN@de.ibm.com,
	linuxppc-dev@ozlabs.org, RAISCH@de.ibm.com,
	Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2007-12-12 at 20:37 +1100, Stephen Rothwell wrote:
> On Wed, 12 Dec 2007 19:06:54 +1100 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > Time to introduce a merged misc.S ? :-)
> 
> We already have one ...

Hah ! I should have looked :-)

Ben.
