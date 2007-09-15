Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 121FADDDF6
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Sep 2007 03:37:00 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8FHatkA018395
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 13:36:55 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8FHatFV688878
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 13:36:55 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8FHatDo016179
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 13:36:55 -0400
Subject: Re: [patch 3/4] 4xx: Convert Walnut flash mappings to new binding
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20070915150901.AC712247CE@gemini.denx.de>
References: <20070915150901.AC712247CE@gemini.denx.de>
Content-Type: text/plain
Date: Sat, 15 Sep 2007 12:35:48 -0500
Message-Id: <1189877748.17593.9.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-09-15 at 17:09 +0200, Wolfgang Denk wrote:
> In message <1189866379.17593.2.camel@localhost.localdomain> Josh Boyer wrote:
> > On Sat, 2007-09-15 at 05:23 +0200, Stefan Roese wrote:
> ...
> > > There are not only Bamboo board running PIBS, but running U-Boot too. How 
> > > should we handle this different FLASH partitioning? Same goes for Ebony too 
> > > btw.
> > 
> > That's a good question.  I'm working on making the NOR flash show up for
> > Bamboo right now, and I had intended to just leave the partition
> > subnodes missing.
> 
> Maybe we can have  U-Boot  add  the  partition  information  if  it's
> missing in the device tree, and extend the mtdparts command in U-Boot
> to add / adjust settings so they match what is defined in U-Boot.

That would be great for newer U-Boots.  For existing older ones, it
doesn't really solve the problem.  But then again, there's no way to
possibly define all the partitioning schemes people may have adopted to
their needs on their boards.  And I believe that is why David has
RedBoot and command line partitioning override what is in the DTS today.

josh
