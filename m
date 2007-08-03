Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F0E0FDDDE9
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 10:13:44 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l730DeQ2024893
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 20:13:40 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l730DeLC529760
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 20:13:40 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l730DevI007544
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 20:13:40 -0400
Date: Thu, 2 Aug 2007 19:26:52 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch 00/14] Current 4xx patch series
Message-ID: <20070803002652.GX3925@crusty.rchland.ibm.com>
References: <41060.0659474314$1184697204@news.gmane.org>
	<f8tgfm$e2g$1@sea.gmane.org>
	<20070802163951.11c398ee@weaponx.rchland.ibm.com>
	<1186094296.5495.638.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1186094296.5495.638.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 03, 2007 at 08:38:16AM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2007-08-02 at 16:39 -0500, Josh Boyer wrote:
> > 
> > Someone brought up the fact that the EMAC rewrite is mostly just
> > changing probing code and the guts are still similar to the current
> > EMAC driver.  I haven't really looked into it yet, but if that's true,
> > I'd be curious as to why it was done that way.
> 
> Ask :-) What specifically do you want to know ?

:)

Are the guts mostly the same, and if so why wasn't the existing driver just
modified to do the device tree probing, perhaps in addition to the arch/ppc
method?

I can answer the "are they similar" myself with inspection, but I just haven't
found the time yet.  So just some history about the patch would be good in
general I think.

josh
