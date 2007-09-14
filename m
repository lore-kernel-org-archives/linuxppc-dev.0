Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F3EBDDDDF7
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 11:22:23 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8F1MKjF002385
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 21:22:20 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8F1MK9b616826
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 21:22:20 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8F1MKMr026511
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 21:22:20 -0400
Subject: Re: [PATCH] add Kconfig option for optimizing for cell
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200709150302.23743.arnd@arndb.de>
References: <200709150221.57825.arnd@arndb.de>
	<1189811264.24878.3.camel@localhost.localdomain>
	<200709150302.23743.arnd@arndb.de>
Content-Type: text/plain
Date: Fri, 14 Sep 2007 18:36:21 -0500
Message-Id: <1189812981.24878.6.camel@localhost.localdomain>
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

On Sat, 2007-09-15 at 03:02 +0200, Arnd Bergmann wrote:
> On Saturday 15 September 2007, Josh Boyer wrote:
> > On Sat, 2007-09-15 at 02:21 +0200, Arnd Bergmann wrote:
> > > Since the PPE on cell is an in-order core, it suffers significantly
> > > from wrong instruction scheduling. This adds an Kconfig option that
> > > enables passing -mtune=cell to gcc in order to generate object
> > > code that runs well on cell.
> > 
> > Which version of gcc supports that?
> > 
> 
> gcc-4.3 will be the first official release that has everything in it,
> and I think 4.1 has some parts. However, there are many patched gcc
> versions in various distributions, so I tried to avoid being too
> specific about the version here.
> 
> Of course, on gcc versions that don't support -mtune=cell, the 
> Kconfig option does not make a difference.

Sure.  I was just wondering if mentioning the first official GCC version
in the Kconfig description would help prevent users from selecting the
option for GCCs that don't support it and then being confused later when
nothing happens.  Your call though.

josh
