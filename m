Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7EFBBDDE9E
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 06:23:39 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0MJNZTV015941
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 14:23:35 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0MJNZFF031036
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 12:23:35 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0MJNYY2017591
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 12:23:34 -0700
Date: Tue, 22 Jan 2008 13:23:33 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Joshua Williams <joshua.williams@qlogic.com>
Subject: Re: [PATCH] Various new ibm405 DCRN #defines
Message-ID: <20080122132333.07cc28fb@weaponx>
In-Reply-To: <479640BB.8020704@qlogic.com>
References: <47952018.7050702@qlogic.com> <1200956274.6807.12.camel@pasglop>
	<47962316.8040709@qlogic.com> <20080122111038.1072dac4@weaponx>
	<479640BB.8020704@qlogic.com>
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

On Tue, 22 Jan 2008 13:15:07 -0600
Joshua Williams <joshua.williams@qlogic.com> wrote:

> Josh Boyer wrote:
> > On Tue, 22 Jan 2008 11:08:38 -0600
> > Joshua Williams <joshua.williams@qlogic.com> wrote:
> > 
> >> Benjamin Herrenschmidt wrote:
> >>> On Mon, 2008-01-21 at 16:43 -0600, Joshua Williams wrote:
> >>>> Various new ibm405 DCRN #defines.
> >>>>
> >>>>      Signed-off-by: Joshua Williams <joshua.williams@qlogic.com>
> >>> May I ask what for ? :-) Also, it's all arch/ppc, not arch/powerpc...
> >>> nothing we want to improve to much on at this stage unless there's a
> >>> really good reason.
> >> The 405x #defines were incomplete and this was meant to
> >> make them a bit tighter.  Since arch/ppc is in life support
> >> mode this can wait until the 405x stuff gets moved over to
> >> arch/powerpc.
> > 
> > Which 405x stuff?  Walnut is moved over already.  Other boards will
> > need to be ported by people that have those boards.
> 
> Gotcha.  I'll revisit this once everything has been moved over.

Sorry, maybe Ben and I aren't being clear.  405GP (Walnut) support is
in arch/powerpc.  There is also support for 405EX and 405EXr.  The
arch/ppc tree is going to die in June, whether the rest of the 405
boards are ported or not.

So are you trying to add defines for a new board, or?  I don't see much
of a reason not to go ahead and do what you're doing now rather than
later but I'll leave that up to you :)

josh
