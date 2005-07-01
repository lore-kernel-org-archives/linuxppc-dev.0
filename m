Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BFAAE67BCC
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Jul 2005 10:58:09 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20050701102741.50361e86.sfr@canb.auug.org.au>
References: <20050630220349.966609000@>
	<20050701102741.50361e86.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Fri, 01 Jul 2005 10:51:57 +1000
Message-Id: <1120179117.31924.66.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, domen@coderock.org, clucas@rotomalug.org
Subject: Re: [patch 1/1] Audit return code : drivers/macintosh/apm_emu.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2005-07-01 at 10:27 +1000, Stephen Rothwell wrote:
> On Fri, 01 Jul 2005 00:03:50 +0200 domen@coderock.org wrote:
> >
> > From: Christophe Lucas <clucas@rotomalug.org>
> > 
> > 
> > Audit return codes (and handle failure correctly) for misc_register.
> 
> This patch was rejected against arch/i386/kernel/apm.c since the driver
> can still do useful things even if the misc_register fails.  (I don't know
> if this is true for the ppc emulation, just a note).

Yes same for ppc, we still have the /proc entry which is useful.

Ben.
