Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 41ECDB7D4A
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 30 May 2010 15:03:26 +1000 (EST)
Subject: Re: mmio_nvram.c users ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20100529134143.GL24511@zod.rchland.ibm.com>
References: <1274773439.1931.238.camel@pasglop>
	<20100525110050.GH24511@zod.rchland.ibm.com>
	<1275104704.1931.528.camel@pasglop>
	<20100529134143.GL24511@zod.rchland.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 30 May 2010 09:15:16 +1000
Message-ID: <1275174916.1931.532.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2010-05-29 at 09:41 -0400, Josh Boyer wrote:
> 
> Probably.  Maybe we shouldn't have duplicated a driver in our platform
> code to begin with. 

I believe our nvram infrastructure predates it by a long shot :-)

powerpc /dev/nvram stuff is very very very ancient.

Cheers,
Ben.
