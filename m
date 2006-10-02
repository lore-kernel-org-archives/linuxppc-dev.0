Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 54E0F67BD2
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Oct 2006 02:50:56 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 0/6]: powerpc/cell spidernet ethernet patches
Date: Mon, 2 Oct 2006 18:50:39 +0200
References: <20060929230552.GG6433@austin.ibm.com>
	<200609301240.03464.arnd@arndb.de>
	<20061002162749.GB4546@austin.ibm.com>
In-Reply-To: <20061002162749.GB4546@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610021850.41062.arnd@arndb.de>
Cc: akpm@osdl.org, jeff@garzik.org, netdev@vger.kernel.org,
	James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 02 October 2006 18:27, Linas Vepstas wrote:
> >=20
> > I'm not sure if I have missed a patch in here, but I
> > don't see anything reintroducing the 'netif_stop_queue'
> > that is missing from the transmit path.
> >=20
> > Do you have a extra patch for that?
>=20
> Unfinished. =A0There are several ways in which the current=20
> spider-net driver doesn't do things the way Greg KH's, etal=20
> book on device drivers recommends. I was planning on combing=20
> through these this week.

Ok, that's good. However, removing the netif_stop_queue
was an obvious oversight that happened during the cleanup
last year.

Putting that one line back in should be a really safe fix for
the problem of overly high system load we sometimes see.

	Arnd <><
