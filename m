Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 820F2DDE26
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2008 08:12:22 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m15LCJCU006796
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Feb 2008 16:12:19 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m15LCIoK071680
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Feb 2008 14:12:19 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m15LCI5r030413
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Feb 2008 14:12:18 -0700
Date: Tue, 5 Feb 2008 15:12:16 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: jgarzik@pobox.com
Subject: Re: [PATCH] net: NEWEMAC: Remove "rgmii-interface" from rgmii
	matching table
Message-ID: <20080205151216.4ff3c32a@weaponx>
In-Reply-To: <1201734898.8146.0.camel@pasglop>
References: <1200476230-14026-1-git-send-email-sr@denx.de>
	<1200477239.6755.21.camel@pasglop>
	<20080116090110.1b7b2f00@zod.rchland.ibm.com>
	<200801300716.52463.sr@denx.de> <1201734898.8146.0.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stefan Roese <sr@denx.de>, netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 31 Jan 2008 10:14:58 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Wed, 2008-01-30 at 07:16 +0100, Stefan Roese wrote:
> > On Wednesday 16 January 2008, Josh Boyer wrote:
> > > On Wed, 16 Jan 2008 20:53:59 +1100
> > >
> > > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > > > On Wed, 2008-01-16 at 10:37 +0100, Stefan Roese wrote:
> > > > > With the removal the the "rgmii-interface" device_type property from
> > > > > the dts files, the newemac driver needs an update to only rely on
> > > > > compatible property.
> > > > >
> > > > > Signed-off-by: Stefan Roese <sr@denx.de>
> > > >
> > > > I need to test if it works on CAB, can't change the DT on those. I'll
> > > > let you know tomorrow.
> > >
> > > This should be fine on CAB.  The rgmii node has:
> > >
> > > compatible = "ibm,rgmii-axon", "ibm,rgmii"
> > >
> > > so the match should still catch on the latter.
> > 
> > How about this patch? Ben, if you think this is ok then we should make sure 
> > that it goes in in this merge-window, since the other dts patch relies on it.
> 
> It's fine.

Jeff, any chance this can get into .25 soon?  I have another patch
queued up behind this one that requires it, and I don't see it in any
of your trees or branches.

Or, if you aren't opposed, I can take it through Paul's tree with your
Ack.

josh
