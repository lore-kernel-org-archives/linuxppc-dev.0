Return-Path: <jdub@us.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CCC9167A6D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Mar 2005 07:56:38 +1100 (EST)
Received: from e1.ny.us.ibm.com ([192.168.1.101])
	by pokfb.esmtp.ibm.com (8.12.11/8.12.11) with ESMTP id j2HIP1b5020556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-embedded@ozlabs.org>; Thu, 17 Mar 2005 13:25:01 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j2HIOva5013367
	for <linuxppc-embedded@ozlabs.org>; Thu, 17 Mar 2005 13:24:57 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j2HIOvMR245198
	for <linuxppc-embedded@ozlabs.org>; Thu, 17 Mar 2005 13:24:57 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j2HIOuWT000754
	for <linuxppc-embedded@ozlabs.org>; Thu, 17 Mar 2005 13:24:56 -0500
From: Josh Boyer <jdub@us.ibm.com>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <4239C51B.70101@mvista.com>
References: <42323A97.5070105@mvista.com>
	<20050317163526.GB10864@wohnheim.fh-wedel.de>
	<4239C51B.70101@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 17 Mar 2005 12:24:31 -0600
Message-Id: <1111083871.7610.3.camel@windu.rchland.ibm.com>
Mime-Version: 1.0
Cc: linux-mtd@lists.infradead.org,
	=?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
	dwmw2@infradead.org, Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 2.6.12] mtd: Remove MTD map file for Chestnut platform.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2005-03-17 at 10:57 -0700, Mark A. Greer wrote:
> Jörn Engel wrote:
> >
> >Applied to mtd cvs.  It will make its way to Linus eventually...
> >
> >Thanks!
> >  
> >
> 
> Jörn,
> 
> Thanks for looking into this but Andrew has already pushed that through 
> from his end.  (I had posted an earler patch with the map removal in it 
> before I broke it out and sent that part to you and the rest to Andrew 
> again.)
> 
> Sorry for wasting your time.

Not a waste of time.  It's been removed from MTD CVS so it doesn't
magically reappear later (or cause headaches when doing a merge).

Jörn meant that the next time the MTD BK tree is synced with Linus,
it'll show up.  If it's already there, then no big deal :).

josh
