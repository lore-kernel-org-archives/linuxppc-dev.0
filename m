Return-Path: <u.luckas@road.de>
Received: from mail.road.de (85-10-209-111.clients.your-server.de
	[85.10.209.111]) by ozlabs.org (Postfix) with ESMTP id DB92CDE139
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 05:54:59 +1000 (EST)
From: Uli Luckas <u.luckas@road.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: azfs: initial submit of azfs, a non-buffered filesystem
Date: Mon, 7 Jul 2008 21:37:43 +0200
References: <20080618160629.6cd749a8@mercedes-benz.boeblingen.de.ibm.com>
	<200807011659.33413.arnd@arndb.de>
	<20080707174230.63bc68cf@mercedes-benz.boeblingen.de.ibm.com>
In-Reply-To: <20080707174230.63bc68cf@mercedes-benz.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200807072137.45094.u.luckas@road.de>
Cc: linux-fsdevel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Maxim Shchetynin <maxim@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday, 7. July 2008, Maxim Shchetynin wrote:
> AZFS is a file system which keeps all files on memory mapped random
> access storage.
Hi Maxim, 
do you mean "memory backed" instead of "memory mapped"?

regards
Uli

-- 

------- ROAD ...the handyPC Company - - -  ) ) )

Uli Luckas
Software Development

ROAD GmbH
Bennigsenstr. 14 | 12159 Berlin | Germany
fon: +49 (30) 230069 - 64 | fax: +49 (30) 230069 - 69
url: www.road.de

Amtsgericht Charlottenburg: HRB 96688 B
Managing directors: Hans-Peter Constien, Hubertus von Streit
