Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 17E46DE2A9
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2008 20:56:54 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m92Aun6w002808
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Oct 2008 06:56:49 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m92AunIY194310
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Oct 2008 06:56:49 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m92Aum7N029852
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Oct 2008 06:56:49 -0400
Date: Thu, 2 Oct 2008 06:56:48 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH v2] ibm_newemac: Add support for GPCS, SGMII andM88E1112
	PHY
Message-ID: <20081002065648.285cce25@zod.rchland.ibm.com>
In-Reply-To: <1222943668.12264.106.camel@pasglop>
References: <1222929477-10329-1-git-send-email-vgallardo@amcc.com>
	<1222929920.12264.96.camel@pasglop>
	<0CA0A16855646F4FA96D25A158E299D602C81377@SDCEXCHANGE01.ad.amcc.com>
	<1222932759.12264.104.camel@pasglop>
	<20081002063320.7b2331b4@zod.rchland.ibm.com>
	<1222943668.12264.106.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Victor Gallardo <vgallardo@amcc.com>,
	Jeff Garzik <jgarzik@pobox.com>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 02 Oct 2008 20:34:28 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Thu, 2008-10-02 at 06:33 -0400, Josh Boyer wrote:
> > On Thu, 02 Oct 2008 17:32:39 +1000
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > 
> > > On Thu, 2008-10-02 at 00:30 -0700, Victor Gallardo wrote:
> > > > 
> > > >  
> > > > Yes, this based on Josh's git repository. Should I sync up with your
> > > > git repository or is Josh's OK.
> > > 
> > > Josh is fine.
> > > 
> > > Jeff, can we merge all those EMAC patches via the powerpc git ? need an
> > > ack from you I suppose ...
> > 
> > I already have this in my tree.  Jeff already acked it (twice now I
> > think).
> > 
> > http://git.kernel.org/?p=linux/kernel/git/jwboyer/powerpc-4xx.git;a=shortlog;h=next
> 
> Ok so it will go in when I get your pull request then :-0

Yep.  You could pull now if you'd like.  I have a few more patches I'd
like to get in before the merge window, but if it helps things I can do
those in a separate pull request.

josh
