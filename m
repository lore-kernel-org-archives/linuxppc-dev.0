Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CE73D67C4C
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 08:00:15 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBDL0dVV003538
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 16:00:39 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kBDL0BWD175018
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 16:00:11 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kBDL0ASR021185
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 16:00:11 -0500
Date: Wed, 13 Dec 2006 15:00:10 -0600
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 0/14]: Spidernet RX-side patches
Message-ID: <20061213210010.GR4329@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org,
	Jens Osterkamp <Jens.Osterkamp@gmx.de>, jgarzik@pobox.com,
	James K Lewis <jim@jklewis.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Andrew, 

Please apply; these patches obsolete/replace the series of 16 patches
I'd previously sent, by addressing problems raised by Christoph Hellwig
and Jeff Garzik. 

Most of te focus of this series of patches is to simplify the RX code
be removing extraneous flags, branches, arguments, etc. The first
few patches are the biggest: using dma_alloc_coherent for the rings,
and removing a bogus tasklet that does work that could be better done in
the poll loop. The rest are mostly cleanup.

--linas
