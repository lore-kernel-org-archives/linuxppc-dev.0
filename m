Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 76AED67D30
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Nov 2006 09:11:57 +1100 (EST)
Subject: Re: [PATCH 4/9] [POWERPC] move Efika support files into platforms/52xx
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200611272256.44623.arnd@arndb.de>
References: <1164662190802-git-send-email-grant.likely@secretlab.ca>
	<11646622073115-git-send-email-grant.likely@secretlab.ca>
	<11646622072999-git-send-email-grant.likely@secretlab.ca>
	<200611272256.44623.arnd@arndb.de>
Content-Type: text/plain
Date: Tue, 28 Nov 2006 09:12:36 +1100
Message-Id: <1164665556.5350.40.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I know you're only moving this code, but shouldn't this really use the
> code from arch/powerpc/kernel/rtas_pci.c? If it doesn't work out of
> the box, I guess we should rather split out the pseries specific
> bits from it and make the common parts more generic.

I looked into it and decided to wait before trying to do that. The 32
bits versions are very small so it doesn't matter much anyway.

Ben.
