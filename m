Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4EA80DDE1F
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Aug 2007 22:25:32 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l76CPTd9032319
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 08:25:29 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l76CPT9m530324
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 08:25:29 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l76CPSnt014807
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 08:25:28 -0400
Date: Mon, 6 Aug 2007 07:39:02 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org, dwg@au1.ibm.com
Subject: Re: [patch 10/10] Bamboo zImage wrapper
Message-ID: <20070806123901.GA3925@crusty.rchland.ibm.com>
References: <20070803160900.069522000@linux.vnet.ibm.com>>
	<20070803161711.457497000@linux.vnet.ibm.com>
	<20070806050011.GC11051@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070806050011.GC11051@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 06, 2007 at 03:00:12PM +1000, David Gibson wrote:
> On Fri, Aug 03, 2007 at 11:09:10AM -0500, Josh Boyer wrote:
> > Add a bootwrapper for the AMCC 440EP Bamboo Eval board.  This also adds a
> > common fixup_clock function for all 440EP(x) chips.
> 
> Ok, you have a separate bamboo.c and treeboot-bamboo.c, like with
> ebony.  However here, therer's only one outermost wrapper -
> treeboot-bamboo.c which means there's not really any point to this
> separation.

Milton already mentioned this the first time I submitted the patch.

> Do you know if there are Bamboo boards with old u-boot versions, or
> some other bootloader which would make the separation worthwhile
> later?

Yes, there are.  And yes, I plan on submitting the cuboot-bamboo.c wrapper
just as soon as I get a chance to get my board switched back to u-boot.  It's
actually pretty trivial to keep both PIBS and u-boot on a bamboo board, since
you can program u-boot into the flash from PIBS and flip some switches to boot
from it.

josh
