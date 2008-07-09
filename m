Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8AD76DDF5B
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 18:59:03 +1000 (EST)
Subject: Re: AZFS file system proposal
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200807011659.33413.arnd@arndb.de>
References: <20080618160629.6cd749a8@mercedes-benz.boeblingen.de.ibm.com>
	<200807011659.33413.arnd@arndb.de>
Content-Type: text/plain
Date: Wed, 09 Jul 2008 18:58:38 +1000
Message-Id: <1215593918.8970.363.camel@pasglop>
Mime-Version: 1.0
Cc: linux-fsdevel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Maxim Shchetynin <maxim@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-07-01 at 16:59 +0200, Arnd Bergmann wrote:
> I wouldn't hold up merging the file system for this problem, but
> until it is solved, the Kconfig entry should probably have
> a "depends on PPC".

Better, use an ifdef for powerpc flags, and #else to pgprot_noncached.

Ben.
