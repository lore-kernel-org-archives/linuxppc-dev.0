Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3EBACDDE37
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 09:20:48 +1000 (EST)
Subject: Re: [PATCH 1/4] Add support for 750CL Holly board
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <1178308913.3026.238.camel@zod.rchland.ibm.com>
References: <1178302414.3026.202.camel@zod.rchland.ibm.com>
	<1178302469.3026.204.camel@zod.rchland.ibm.com>
	<200705042144.31194.arnd@arndb.de>
	<1178308913.3026.238.camel@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Wed, 09 May 2007 09:20:28 +1000
Message-Id: <1178666428.14928.121.camel@localhost.localdomain>
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


> I know.  Looking for a better suggestions.  Kumar suggested a Kconfig
> option at least, which is what I'm going to go with unless someone has a
> better idea...

Yes, I do: Fix the TSI driver, it should be trivial :-)

Ben.
