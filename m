Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 885E5DE035
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 04:52:05 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8KIq2JU005630
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 14:52:02 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8KIpw3W186058
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 12:51:59 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8KIpwA5003588
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 12:51:58 -0600
Date: Thu, 20 Sep 2007 13:51:53 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 2/2] PowerPC: Fix Sequoia MAL0 and EMAC dts entries.
Message-ID: <20070920135153.588cfd61@weaponx.rchland.ibm.com>
In-Reply-To: <46F2BFFA.1060203@ru.mvista.com>
References: <20070918172510.GA30944@ru.mvista.com>
	<20070918172913.GA31098@ru.mvista.com>
	<20070919010526.GA23646@localhost.localdomain>
	<46F10478.1080506@ru.mvista.com> <46F2BFFA.1060203@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 20 Sep 2007 22:46:18 +0400
Valentine Barshak <vbarshak@ru.mvista.com> wrote:

> Valentine Barshak wrote:
> > David Gibson wrote:
> >> On Tue, Sep 18, 2007 at 09:29:13PM +0400, Valentine Barshak wrote:
> >>> According to PowerPC 440EPx documentation,
> >>> MAL0 is comprised of four channels (two transmit and two receive).
> >>> Each channel is dedicated to one of two EMAC cores.
> >>> This patch fixes Sequoia DTS MAL0 entry and EMAC entries,
> >>> assigning correct channel numbers to EMACs.
> >>
> >> Hrm.. did they change the EMAC in 440EPx to only use one MAL
> >> tx-channel?  All the older ones could use two (for no readily apparent
> >> reason, IMO).
> >>
> > Yes, they did.
> > Just 1 tx and 1 rx-channel per EMAC. Just 2 bits to select channels, 
> > while all other bits in MAL registers are reserved.
> > I'm not sure why they did it (possible bus bandwidth problems), but it's 
> > impossible to set more than 1 rx/tx channel for each EMAC in 440EPx.
> 
> Josh, David, is this patch OK?

Yeah.  I applied it to my tree and asked Paul to pull.  Same for the
Bamboo one.

josh
