Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F0A31DDDE1
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jun 2009 11:54:21 +1000 (EST)
Subject: Re: [PATCH 3/5] powerpc: Introduce CONFIG_PPC_BOOK3S
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200906021149.17816.arnd@arndb.de>
References: <20090602075022.57FE2DDF72@ozlabs.org>
	<200906021149.17816.arnd@arndb.de>
Content-Type: text/plain
Date: Wed, 03 Jun 2009 11:54:11 +1000
Message-Id: <1243994051.27194.27.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-06-02 at 11:49 +0100, Arnd Bergmann wrote:
> 
> then add the other BOOK3S option depending on PPC64. Even though
> it might look silly to have a choice statement with just one possible
> option in case of PPC64, why not integrate it right away, for
> consistency
> reasons. It seems strange to have the same Kconfig symbol both
> as a choice and a simple bool.

After some thinking I decided to keep the PPC64 variant as a separate
simple bool for now, among others, because it should be a separate
choice anyway due to the help text being different for 32 and 64-bit
anyway and I'm not fan of a one-option choice.

Ben.
