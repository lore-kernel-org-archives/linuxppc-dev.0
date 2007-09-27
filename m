Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 14B17DDDF8
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 07:35:07 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8RLZ4WP011844
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 17:35:04 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8RLZ4oC576114
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 17:35:04 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8RLZ3xc026396
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 17:35:04 -0400
Date: Thu, 27 Sep 2007 16:35:03 -0500
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Subject: Re: 2.6.23-rc8 dies somewhere during boot!?
Message-ID: <20070927213503.GA18686@austin.ibm.com>
References: <20070927191233.201980@gmx.net>
	<20070927192551.GK7970@austin.ibm.com>
	<20070927193131.201920@gmx.net>
	<20070927205012.GN7970@austin.ibm.com>
	<20070927211700.201970@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070927211700.201970@gmx.net>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 27, 2007 at 11:17:00PM +0200, Gerhard Pircher wrote:
> > Betreff: Re: 2.6.23-rc8 dies somewhere during boot!?
> 
> Do you have an idea how to debug it?

Not particularly. What caught my eye was the failure right near the
PCI quirk stuff, as I was having problems there as well (but apearntly,
for very different reasons).  Based on your boot messages, it looks 
like you are failing somewhere in pci probe.  My olde-fashioned, slow,
but-usually-works method is to sprinkle enough printk's into the code
to catch it in the act.

--linas
