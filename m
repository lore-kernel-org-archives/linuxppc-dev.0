Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DFEEEDDE2B
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 08:07:30 +1100 (EST)
Subject: Re: [PATCH] Various new ibm405 DCRN #defines
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080122111038.1072dac4@weaponx>
References: <47952018.7050702@qlogic.com> <1200956274.6807.12.camel@pasglop>
	<47962316.8040709@qlogic.com>  <20080122111038.1072dac4@weaponx>
Content-Type: text/plain
Date: Wed, 23 Jan 2008 07:58:48 +1100
Message-Id: <1201035528.6807.34.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Joshua Williams <joshua.williams@qlogic.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-01-22 at 11:10 -0600, Josh Boyer wrote:
> On Tue, 22 Jan 2008 11:08:38 -0600
> Joshua Williams <joshua.williams@qlogic.com> wrote:
> 
> > Benjamin Herrenschmidt wrote:
> > > On Mon, 2008-01-21 at 16:43 -0600, Joshua Williams wrote:
> > >> Various new ibm405 DCRN #defines.
> > >>
> > >>      Signed-off-by: Joshua Williams <joshua.williams@qlogic.com>
> > > 
> > > May I ask what for ? :-) Also, it's all arch/ppc, not arch/powerpc...
> > > nothing we want to improve to much on at this stage unless there's a
> > > really good reason.
> > 
> > The 405x #defines were incomplete and this was meant to
> > make them a bit tighter.  Since arch/ppc is in life support
> > mode this can wait until the 405x stuff gets moved over to
> > arch/powerpc.
> 
> Which 405x stuff?  Walnut is moved over already.  Other boards will
> need to be ported by people that have those boards.

I have no objection with adding #define's to arch/powerpc somewhere
though I'd like to avoid having 36 different .h files per processor
type.

Ben.
