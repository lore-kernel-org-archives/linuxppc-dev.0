Return-Path: <linas@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8FC22DDEF6
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 04:49:40 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6AInbh2011092
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 14:49:37 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l6AInbuc483078
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 14:49:37 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6AInaqx011362
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 14:49:36 -0400
Date: Tue, 10 Jul 2007 13:49:36 -0500
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] [ide] mmio ide support
Message-ID: <20070710184936.GF24480@austin.ibm.com>
References: <20070707094852.9473.21013.stgit@localhost.localdomain>
	<468FC4AC.9030701@ru.mvista.com> <200707072007.10448.arnd@arndb.de>
	<200707081515.42105.bzolnier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200707081515.42105.bzolnier@gmail.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jul 08, 2007 at 03:15:41PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> > on the argument that drivers/ide/ is going away soon. Most
> > current distros have already moved over to using libata
> > exclusively.
> 
> The in-kernel default for PATA systems is still IDE subsystem.

In part because libata still does not yet work correctly 
for at least some (older) ide chipsets (like mine).

--linas
