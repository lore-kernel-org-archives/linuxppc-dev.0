Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6ABE2DDDF7
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 10:38:46 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l490chcf022387
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 20:38:43 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l490chK8541066
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 20:38:43 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l490cgJD024626
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 20:38:43 -0400
Subject: Re: [PATCH 1/4] Add support for 750CL Holly board
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1178666428.14928.121.camel@localhost.localdomain>
References: <1178302414.3026.202.camel@zod.rchland.ibm.com>
	<1178302469.3026.204.camel@zod.rchland.ibm.com>
	<200705042144.31194.arnd@arndb.de>
	<1178308913.3026.238.camel@zod.rchland.ibm.com>
	<1178666428.14928.121.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 08 May 2007 19:32:59 -0500
Message-Id: <1178670779.3453.45.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-05-09 at 09:20 +1000, Benjamin Herrenschmidt wrote:
> > I know.  Looking for a better suggestions.  Kumar suggested a Kconfig
> > option at least, which is what I'm going to go with unless someone has a
> > better idea...
> 
> Yes, I do: Fix the TSI driver, it should be trivial :-)

You're a bit late.  It was fixed in a more generic manner :)

josh
