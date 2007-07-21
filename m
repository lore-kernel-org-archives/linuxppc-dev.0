Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 68FE8DDEDB
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jul 2007 10:35:58 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: mpic protected sources
Date: Sat, 21 Jul 2007 02:00:55 +0200
References: <OFD54BD0CE.6883770C-ONC125731D.00322C4C-C125731D.00324A9E@de.ibm.com>
	<1184975721.5439.33.camel@localhost.localdomain>
In-Reply-To: <1184975721.5439.33.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707210200.56466.arnd@arndb.de>
Cc: Paul Mackerras <paulus@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 21 July 2007, Benjamin Herrenschmidt wrote:
> 0% probability of being spam.
>=20
> Full report:
> No, score=3D-2.5 required=3D5.0 tests=3DAWL,BAYES_00 autolearn=3Dham  ver=
sion=3D3.1.7-deb =A0
> Some HW platforms, such as the new cell blades, requires some MPIC sources
> to be left alone by the operating system. This patch implements support f=
or
> a "protected-sources" property in the mpic controller node containing a l=
ist
> of source numbers to be protected against operating system interference.
>=20
> For those interested in the gory details, the MPIC on the southbridge of
> those blades has some of the processor outputs routed to the cell, and
> at least one routed as a GPIO to the service processor. It will be used
> in the GA product for routing some of the southbridge error interrupts
> to the service processor which implements some of the RAS stuff, such
> as checkstopping when fatal errors occurs before they can propagate.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
