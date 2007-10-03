Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C867ADDFD3
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 10:49:17 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l930nE94002799
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Oct 2007 20:49:14 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l930nDiE529816
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Oct 2007 20:49:13 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l930nDBe007721
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Oct 2007 20:49:13 -0400
Subject: Re: [PATCH] Remove unnecessary memset from physmap_of driver
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18178.55231.813138.369480@cargo.ozlabs.ibm.com>
References: <20071002155328.GA3574@ru.mvista.com>
	<18178.55231.813138.369480@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Tue, 02 Oct 2007 19:49:08 -0500
Message-Id: <1191372548.3647.0.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-10-03 at 09:43 +1000, Paul Mackerras wrote:
> Valentine Barshak writes:
> 
> > No need for memset to zero memory here, since we use kzalloc.
> > 
> > Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> > ---
> >  drivers/mtd/maps/physmap_of.c |    1 -
> 
> Please cc the mtd list (linux-mtd@lists.infradead.org) and/or David
> Woodhouse on MTD patches.  Posting them to linuxppc-dev isn't going to
> get them upstream.

Except when I screw up and pull them into my tree.  Which won't happen
again.

josh
