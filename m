Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D9C42DDE49
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 04:11:02 +1100 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0MHAwlc006933
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 12:10:58 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0MHAnsg921702
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 12:10:49 -0500
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0MHAd87028577
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 10:10:39 -0700
Date: Tue, 22 Jan 2008 11:10:38 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Joshua Williams <joshua.williams@qlogic.com>
Subject: Re: [PATCH] Various new ibm405 DCRN #defines
Message-ID: <20080122111038.1072dac4@weaponx>
In-Reply-To: <47962316.8040709@qlogic.com>
References: <47952018.7050702@qlogic.com> <1200956274.6807.12.camel@pasglop>
	<47962316.8040709@qlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 22 Jan 2008 11:08:38 -0600
Joshua Williams <joshua.williams@qlogic.com> wrote:

> Benjamin Herrenschmidt wrote:
> > On Mon, 2008-01-21 at 16:43 -0600, Joshua Williams wrote:
> >> Various new ibm405 DCRN #defines.
> >>
> >>      Signed-off-by: Joshua Williams <joshua.williams@qlogic.com>
> > 
> > May I ask what for ? :-) Also, it's all arch/ppc, not arch/powerpc...
> > nothing we want to improve to much on at this stage unless there's a
> > really good reason.
> 
> The 405x #defines were incomplete and this was meant to
> make them a bit tighter.  Since arch/ppc is in life support
> mode this can wait until the 405x stuff gets moved over to
> arch/powerpc.

Which 405x stuff?  Walnut is moved over already.  Other boards will
need to be ported by people that have those boards.

josh
